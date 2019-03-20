//
//  InfoCalculate.h
//  PanGu
//
//  Created by 张琦 on 2017/7/20.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoCalculate : NSObject

+ (CGRect)boundingRectForCharacterRange:(NSRange)range andContentStr:(NSString *)contentStr label:(UILabel *)tipLabel;


//最多两行
+ (CGFloat)caculateHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize row:(NSInteger)row;
//平方细
+ (CGFloat)caculatePingFangLightHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize;

//完全展示（两端对齐）
+ (CGFloat)caculateAlignmentTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize;

//完全展示
+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize;

//完全展示(加粗)
+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace boldFontSize:(CGFloat)fontSize;
//计算前后包含不同字号的总高度
+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace frontStr:(NSString *)frontStr frontFont:(UIFont *)frontFont backFont:(UIFont *)backFont;

//计算总高度
+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace;

+ (BOOL)filterArr:(NSArray *)arr1 andArr2:(NSArray *)arr2;


////
+ (void)saveNewEditColumnUserDefaults:(NSArray *)arr;

+ (NSArray *)queryNewEditColumnUserDefaults;

+ (void)removeNewEditColumnUserDefaults;

+ (void)updateNewEditColumnUserDafaults:(NSArray *)arr;

+ (void)controlNewEditColumn;

@end
