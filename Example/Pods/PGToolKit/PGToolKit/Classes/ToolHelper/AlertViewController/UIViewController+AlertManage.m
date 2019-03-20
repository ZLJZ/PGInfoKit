//
//  UIViewController+AlertManage.m
//  PanGu
//
//  Created by FYX on 2018/9/6.
//  Copyright © 2018年 Security Pacific Corporation. All rights reserved.
//

#import "UIViewController+AlertManage.h"
#import <objc/runtime.h>

@implementation UIViewController (AlertManage)


/**
 将弹框控制器放到队列里面管理

 @return 弹框队列
 */
- (NSOperationQueue *)getOperationQueue{
    
    static NSOperationQueue *operationQueue = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        operationQueue = [NSOperationQueue new];
        
    });
    
    return operationQueue;
}


- (void)PanGu_presentViewController:(UIViewController *)controller animated: (BOOL)flag completion:(void (^)(void))completion{
    //将队列线程阻塞住，就好像将弹窗的位置当做一个公共资源来访问，只有在当前弹窗位置没有窗口的时候才允许弹窗，
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf presentViewController:controller animated:flag completion:completion];
            
            [controller setDisappearCompletion:^{
                dispatch_semaphore_signal(semaphore);
            }];

        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
    }];
    if ([self getOperationQueue].operations.lastObject) {
        
        [operation addDependency:[self getOperationQueue].operations.lastObject];
        
    }
    
    [[self getOperationQueue] addOperation:operation];
}

- (void)setDisappearCompletion:(void (^)(void))completion {
    objc_setAssociatedObject(self, @selector(getDisappearCompletion), completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void (^)(void))getDisappearCompletion {
    
    return objc_getAssociatedObject(self, _cmd);
    
}

+ (void)load {
    
    SEL oldSel = @selector(viewDidDisappear:);
    
    SEL newSel = @selector(PanGu_viewDidDisappear:);
    
    Method oldMethod = class_getInstanceMethod([self class], oldSel);
    
    Method newMethod = class_getInstanceMethod([self class], newSel);
    
    
    BOOL didAddMethod = class_addMethod(self, oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    if (didAddMethod) {
        
        class_replaceMethod(self, newSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        
    } else {
        
        method_exchangeImplementations(oldMethod, newMethod);
        
    }
    
}

//hook一下viewDidDisappear方法，让ViewController在消失的时候执行一下回调
- (void)PanGu_viewDidDisappear:(BOOL)animated {
    
    [self PanGu_viewDidDisappear:animated];
    
    if ([self getDisappearCompletion]) {
        [self getDisappearCompletion]();
    }
}



@end
