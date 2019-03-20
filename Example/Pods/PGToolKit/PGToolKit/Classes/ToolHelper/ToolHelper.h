//
//  ToolHelper.h
//  xiangyunDemo
//
//  Created by 陈伟平 on 16/5/6.
//  Copyright © 2016年 陈伟平. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    yyyy_MM_dd = 0,
    HH_mm_ss,
    yyyyMMddHHmmss
} TimeFormat;
@interface ToolHelper : NSObject

//判断固定字体大小
+(CGRect)stringRectWithSize:(CGSize)size fontSize:(CGFloat)font withString:(NSString *)string;
+(CGRect)stringRectWithSize:(CGSize)size boldFontSize:(CGFloat)font withString:(NSString *)string;

//字符串判空
+(BOOL) isBlankString:(NSString *)string;

//计算字符串大小
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font;

+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHex:(NSString *)hexColor alpha:(float)alpha;


+(CGRect)stringRectWithPingFangLightSize:(CGSize)size fontSize:(CGFloat)font withString:(NSString *)string;
//iOS 9之前加载本地文件
+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL;


//判断是否防止弹框
+(BOOL)isShowDLLoading:(NSInteger)code;

/**
 *  压缩图片
 *
 *  @param image       需要压缩的图片
 *  @param kb 希望压缩后的大小(以KB为单位)
 *
 */
+ (void)compressedImageFiles:(UIImage *)image
                     imageKB:(NSInteger)kb
                  imageBlock:(void(^)(UIImage *image))block;

+ (NSString*)getJSONString:(NSDictionary*)dic withKey:(NSString*)aKey;

+ (NSString *)getNowDate:(TimeFormat)timeFormat;

@end
