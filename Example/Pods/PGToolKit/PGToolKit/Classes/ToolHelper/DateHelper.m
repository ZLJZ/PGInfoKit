//
//  DateHelper.m
//  PanGu
//
//  Created by 陈伟平 on 16/6/20.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

//获取当前时间 yyyy-MM-dd HH:mm:ss
+ (NSString *)currentTime {
    NSDate *cuttentDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *currentDateStr=[dateformatter stringFromDate:cuttentDate];
    return currentDateStr;
}
//yyyyMMdd 转 yyyy.MM.dd
+ (NSString *)dateStrDotWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}

//yyyyMMdd 转 yyyy-MM-dd
+ (NSString *)dateStrDashWithString:(NSString *)dateString {
    NSString *orderDateString = @"--";
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""] || dateString.length < 8) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}

//yyyyMMdd 转MM.dd
+ (NSString *)dateMDStrDashWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"MM.dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}
//yyyyMMdd 转 yyyy/MM/dd
+ (NSString *)dateStrObliqueLineWithString:(NSString *)dateString {
    NSString *orderDateString;
    if (![dateString isKindOfClass:[NSString class]] || [dateString isEqualToString:@""]) {
        orderDateString = @"--";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat =@"yyyyMMdd";
        NSDate *orderDate = [dateFormatter dateFromString:dateString];
        dateFormatter.dateFormat = @"yyyy/MM/dd";
        orderDateString = [dateFormatter stringFromDate:orderDate];
    }
    return orderDateString;
}

//HHmmss 转 HH:mm:ss
+ (NSString *)timeStrColonWithString:(NSString *)timeString {
    NSString *orderTimeString;
    if (![timeString isKindOfClass:[NSString class]] || [timeString isEqualToString:@""]) {
        orderTimeString = @"--";
    } else {
        NSMutableString *str = [timeString mutableCopy];
        if ([timeString length] != 6) {
            
            for (NSInteger i = 0; i < 6-timeString.length; i ++ ) {
                [str insertString:@"0" atIndex:0];
            }
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"HHmmss";
        NSDate *orderTime = [dateFormatter dateFromString:str];
        dateFormatter.dateFormat = @"HH:mm:ss";
        orderTimeString = [dateFormatter stringFromDate:orderTime];
    }
    return orderTimeString;
    
}



//yyyy-MM-dd 转 MM.dd
+ (NSString *)dateMDStrDashWithMinusString:(NSString *)dateString {
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"MM.dd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}

//yyyyMMdd 转 MM-dd
+ (NSString *)dateMDStrHengDashWithMinusString:(NSString *)dateString {
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"MM-dd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}
// yyyy/MM/dd 转 yyyyMMdd
+ (NSString *)dateStrLineWithString:(NSString *)dateString {
    if (dateString.length < 4) {
        return @"-";
    }
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"yyyyMMdd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}

// yyyy-MM-dd 转 yyyyMMdd
+ (NSString *)dateStrNoneWithString:(NSString *)dateString {
    if (dateString.length < 4) {
        return @"-";
    }
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"yyyyMMdd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}

+ (NSDate *)timeString:(NSString *)timeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString:timeString];
}

//yyyy-MM-dd,yyyy.MM.dd yyyyMMdd转 MMdd
+ (NSString *)dateMDStrTotalString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    if (dateString.length < 5) {
        return @"00-00";
    }
    
    if (dateString.length > 11){
        dateString = [dateString substringToIndex:8];
        dateFormatter.dateFormat = @"yyyyMMdd";
    }else if (dateString.length == 8) {
        dateFormatter.dateFormat = @"yyyyMMdd";
    }else if (!([dateString rangeOfString:@"-"].location == NSNotFound)) {
       dateFormatter.dateFormat = @"yyyy-MM-dd";
    }else if (!([dateString rangeOfString:@"."].location == NSNotFound)){
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    NSString *orderDateString;
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}
//yyyy-MM-dd,yyyy.MM.dd yyyyMMdd转date
+ (NSDate *)dateYMDStrTotalDate:(NSString *)dateString{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if (dateString.length > 11){
        dateString = [dateString substringToIndex:8];
        dateFormatter.dateFormat = @"yyyyMMdd";
    }else if ([dateString rangeOfString:@"-"].location) {
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    }else if ([dateString rangeOfString:@"."].location){
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }else{
        dateFormatter.dateFormat = @"yyyyMMdd";
    }
    NSDate *fromdate=[dateFormatter dateFromString:dateString];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSLog(@"fromdate=%@",fromDate);
    
    
    
//    NSDate *date = [dateFormatter dateFromString:dateString];
    return fromDate;
}

//yyyy-MM-dd HH:mm:ss 格式的当前时间
+ (NSString *)getDashNowDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}

// yyyy-MM-dd 转 yyyy.MM.dd
+ (NSString *)dateStrDotWithDashString:(NSString *)dateString {
    if ([self isBlankString:dateString]) {
        return @"-";
    }
    NSString *orderDateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    orderDateString = [dateFormatter stringFromDate:dateStr];
    return orderDateString;
}

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


+(NSString *)dateNumberConvertEnglish:(NSString *)dateString {
    NSString *englishStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateStr = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = @"MMM";
    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    englishStr = [dateFormatter stringFromDate:dateStr];
    return englishStr;
}

+ (NSDate *)dateFromLineString:(NSString *)lineStr {
    lineStr = [lineStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *resDate = [dateFormatter dateFromString:lineStr];
//    NSString *str = [dateFormatter stringFromDate:resDate];
    
    return resDate;
}

+ (NSString *)dateStrWithTotalStr:(NSString *)totalStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:totalStr];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *resStr = [dateFormatter stringFromDate:date];
    return resStr;
}

+ (NSString *)dateDotStrWithTotalStr:(NSString *)totalStr {
    if (totalStr.length <= 11) return @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:totalStr];
    dateFormatter.dateFormat = @"yyyy.MM.dd HH:mm";
    NSString *resStr = [dateFormatter stringFromDate:date];
    return resStr;
}

@end
