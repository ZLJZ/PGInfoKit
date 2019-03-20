//
//  ToolHelper.m
//  xiangyunDemo
//
//  Created by 陈伟平 on 16/5/6.
//  Copyright © 2016年 陈伟平. All rights reserved.
//

#import "ToolHelper.h"

#define FONT_SYSTEM @"Helvetica"
#define NetworkErrorCode 0x0000024B6

@implementation ToolHelper

//判断字体大小
+(CGRect)stringRectWithSize:(CGSize)size fontSize:(CGFloat)font withString:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect;
}

+(CGRect)stringRectWithPingFangLightSize:(CGSize)size fontSize:(CGFloat)font withString:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:FONT_SYSTEM size:font],NSFontAttributeName, nil] context:nil];
    return rect;
}

//判断字体大小(加粗)
+(CGRect)stringRectWithSize:(CGSize)size boldFontSize:(CGFloat)font withString:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font]} context:nil];
    return rect;
}

//字符串判空
+(BOOL) isBlankString:(NSString *)string {
    
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    //    if (string.length==0) {
    //        return YES;
    //    }
    return NO;
}

#pragma mark 计算字符串大小
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font{
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
        textSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return textSize;
}

+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)alpha{
    //删除空格
    NSString *colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([colorStr length] < 6||[colorStr length]>7)
    {
        return [UIColor clearColor];
    }
    //
    if ([colorStr hasPrefix:@"#"])
    {
        colorStr = [colorStr substringFromIndex:1];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //red
    NSString *redString = [colorStr substringWithRange:range];
    //green
    range.location = 2;
    NSString *greenString = [colorStr substringWithRange:range];
    //blue
    range.location = 4;
    NSString *blueString= [colorStr substringWithRange:range];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    return [UIColor colorWithRed:((float)red/ 255.0f) green:((float)green/ 255.0f) blue:((float)blue/ 255.0f) alpha:alpha];
}

//判断网络状态
//+(NSInteger)internetReachability{
//    NSInteger num = 0;
//    NetworkStatus netStatus = [HttpRequest getInstance].netStatus;
//
//    switch (netStatus) {
//        case NotReachable:
//            num=1;
//            break;
//        case ReachableViaWiFi:
//            num=2;
//            break;
//        case ReachableViaWWAN:
//            num=3;
//            break;
//    }
//    return num;
//}

+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"panguwk8"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    return dstURL;
}

#pragma mark -- 判断是否防止弹框
+(BOOL)isShowDLLoading:(NSInteger)code{
    BOOL bRet = YES;
    if (code == -999 || code == NetworkErrorCode) {
        bRet = NO;
    }
    return bRet;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/**
 *  压缩图片
 *
 *  @param image       需要压缩的图片
 *  @param fImageBytes 希望压缩后的大小(以KB为单位)
 *
 */
+ (void)compressedImageFiles:(UIImage *)image
                     imageKB:(NSInteger)kb
                  imageBlock:(void(^)(UIImage *image))block {
    
    if (!image) {
        block(image);
    }
    if (kb<1) {
        block(image);
    }
    
    kb*=1024;
    
    
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    if (image == nil) {
        return;
    }
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    block(compressedImage);
}

- (NSString*)getPort:(NSString*)address
{
    NSRange range = [address rangeOfString:@":" options:NSBackwardsSearch];
    if (range.location < 5) {
        address=@"80";
        return address;
    }else{
        
        return [address substringFromIndex:range.location + 1];
    }
}

+ (NSString*)getJSONString:(NSDictionary*)dic withKey:(NSString*)aKey
{
    NSString *str;
    str = [dic objectForKey:aKey];
    if (str.length > 0) {
        return str;
    }else{
        return @"";
    }
}

+ (NSString *)getNowDate:(TimeFormat)timeFormat {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (timeFormat == yyyy_MM_dd) {
        [dateFormatter setDateFormat:@"yyyyMMdd"];
    }else if (timeFormat == HH_mm_ss) {
        [dateFormatter setDateFormat:@"HHmmss"];
    }else if (timeFormat == yyyyMMddHHmmss) {
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    }
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

@end
