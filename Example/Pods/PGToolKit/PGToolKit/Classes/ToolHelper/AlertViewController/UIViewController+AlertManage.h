//
//  UIViewController+AlertManage.h
//  PanGu
//
//  Created by FYX on 2018/9/6.
//  Copyright © 2018年 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertManage)


/**
 替换系统presnet方法，
 用来解决多次弹框，只有第一次能弹框的问题
 @param controller 弹框控制器
 @param flag 是否动画
 @param completion 完成回调
 */
- (void)PanGu_presentViewController:(UIViewController *)controller animated: (BOOL)flag completion:(void (^)(void))completion;

@end
