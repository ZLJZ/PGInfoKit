//
//  DateHelper.h
//  PanGu
//
//  Created by 陈伟平 on 16/6/20.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

//获取当前时间 yyyy-MM-dd HH:mm:ss
+ (NSString *)currentTime;

//yyyyMMdd 转 yyyy.MM.dd
+ (NSString *)dateStrDotWithString:(NSString *)dateString;

//yyyyMMdd 转 yyyy-MM-dd
+ (NSString *)dateStrDashWithString:(NSString *)dateString;
//yyyyMMdd 转MM.dd
+ (NSString *)dateMDStrDashWithString:(NSString *)dateString;
//yyyy-MM-dd 转 MM.dd
+ (NSString *)dateMDStrDashWithMinusString:(NSString *)dateString;
//yyyyMMdd 转 MM-dd
+ (NSString *)dateMDStrHengDashWithMinusString:(NSString *)dateString;

+ (NSString *)dateStrObliqueLineWithString:(NSString *)dateString;

// yyyy/MM/dd 转 yyyyMMdd
+ (NSString *)dateStrLineWithString:(NSString *)dateString;
// yyyy-MM-dd 转 yyyyMMdd
+ (NSString *)dateStrNoneWithString:(NSString *)dateString;
//HHmmss 转 HH:mm:ss
+ (NSString *)timeStrColonWithString:(NSString *)timeString;

//string 转 date
+ (NSDate *)timeString:(NSString *)timeString;

//yyyy-MM-dd,yyyy.MM.dd yyyyMMdd转 MMdd
+ (NSString *)dateMDStrTotalString:(NSString *)dateString;
//yyyy-MM-dd,yyyy.MM.dd yyyyMMdd转date
+ (NSDate *)dateYMDStrTotalDate:(NSString *)dateString;

//yyyy-MM-dd HH:mm:ss 格式的当前时间
+ (NSString *)getDashNowDate;

// yyyy-MM-dd 转 yyyy.MM.dd
+ (NSString *)dateStrDotWithDashString:(NSString *)dateString;

+(NSString *)dateNumberConvertEnglish:(NSString *)dateString;

+ (NSDate *)dateFromLineString:(NSString *)lineStr;

+ (NSString *)dateStrWithTotalStr:(NSString *)totalStr;

+ (NSString *)dateDotStrWithTotalStr:(NSString *)totalStr;

@end

