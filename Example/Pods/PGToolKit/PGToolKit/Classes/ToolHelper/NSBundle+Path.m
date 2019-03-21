//
//  NSBundle+Path.m
//  OrbyunInfo
//
//  Created by 吴肖利 on 2019/3/21.
//  Copyright © 2019 com. All rights reserved.
//

#import "NSBundle+Path.h"
#import <objc/runtime.h>

@implementation NSBundle (Path)

+ (void)load {
    Method bundleMethod = class_getClassMethod([NSBundle class], @selector(mainBundle));
    Method zlBundleMethod = class_getClassMethod([NSBundle class], @selector(zl_mainBundle));
    method_exchangeImplementations(bundleMethod, zlBundleMethod);
}

+ (NSBundle *)zl_mainBundle {
    NSBundle *zlBundle = [NSBundle bundleForClass:[self class]];
    return zlBundle;
}

@end
