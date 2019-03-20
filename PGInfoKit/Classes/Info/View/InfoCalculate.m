//
//  InfoCalculate.m
//  PanGu
//
//  Created by 张琦 on 2017/7/20.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoCalculate.h"
#import "PGInfo.h"

#define FONT_SYSTEM                     @"Helvetica"
@implementation InfoCalculate

+ (CGRect)boundingRectForCharacterRange:(NSRange)range andContentStr:(NSString *)contentStr label:(UILabel *)tipLabel
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentStr.length)];
    
    NSDictionary *attrs =@{NSFontAttributeName : [UIFont systemFontOfSize:13.0]};
    [attributeString setAttributes:attrs range:NSMakeRange(0, contentStr.length)];
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributeString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:tipLabel.size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    
    NSRange glyphRange;
    
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    
    CGRect rect = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
    
    rect.origin.y = tipLabel.height-13;
    
    return rect;
}

+ (CGFloat)caculateHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize row:(NSInteger)row {
    titleLabel.text = titleLabel.text ? titleLabel.text : @"";
    CGFloat labelHeight = 0;
    CGRect rect = [ToolHelper stringRectWithSize:CGSizeMake(titleLabel.width, 0) fontSize:fontSize withString:
                   titleLabel.text];
    if (rect.size.height/(fontSize * row) > 1 && rect.size.height/(fontSize * row) != 0) {
        titleLabel.numberOfLines = 0;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
        NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:lineSpace];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [attributeString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:NSMakeRange(0, titleLabel.text.length)];
        [titleLabel setAttributedText:attributeString];
        labelHeight = (fontSize + 2 * KSINGLELINE_WIDTH) * row + lineSpace * row;
    } else {
        labelHeight = fontSize + 2 * KSINGLELINE_WIDTH + lineSpace;
    }
    return labelHeight + lineSpace/2.0;
    
}

+ (CGFloat)caculatePingFangLightHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize {
    titleLabel.text = titleLabel.text ? titleLabel.text : @"";
    CGFloat labelHeight = 0;
    CGRect rect = [ToolHelper stringRectWithPingFangLightSize:CGSizeMake(titleLabel.width, 0) fontSize:fontSize withString:
                   titleLabel.text];
    if (rect.size.height/(fontSize * 2) > 1 && rect.size.height/(fontSize * 2) != 0) {
        titleLabel.numberOfLines = 0;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
        NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:lineSpace];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [attributeString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont fontWithName:FONT_SYSTEM size:fontSize]} range:NSMakeRange(0, titleLabel.text.length)];
        [titleLabel setAttributedText:attributeString];
        labelHeight = (fontSize + 4 * KSINGLELINE_WIDTH) * 2 + lineSpace * 2 + 7;
    } else {
        labelHeight = fontSize + 4 * KSINGLELINE_WIDTH + lineSpace;
    }
    return labelHeight;
    
}

+ (CGFloat)caculateAlignmentTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize {
    titleLabel.text = titleLabel.text ? titleLabel.text : @"";
    titleLabel.numberOfLines = 0;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
    NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent = 1;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.paragraphSpacing = 0;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleLabel.text.length)];
    [titleLabel setAttributedText:attributeString];
    CGRect rect = [ToolHelper stringRectWithSize:CGSizeMake(titleLabel.width, 0) fontSize:fontSize withString:titleLabel.text];
    CGFloat labelHeight = rect.size.height+(rect.size.height/(fontSize)-1)*lineSpace;
    
    return labelHeight;
}

+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace fontSize:(CGFloat)fontSize {
    titleLabel.text = titleLabel.text ? titleLabel.text : @"";
    titleLabel.numberOfLines = 0;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
    NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.paragraphSpacing = 0;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleLabel.text.length)];
    [titleLabel setAttributedText:attributeString];
    CGRect rect = [ToolHelper stringRectWithSize:CGSizeMake(titleLabel.width, 0) fontSize:fontSize withString:titleLabel.text];
    CGFloat labelHeight = rect.size.height+(rect.size.height/(fontSize)-1)*lineSpace;

    return labelHeight;
}

+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace boldFontSize:(CGFloat)fontSize {
    titleLabel.text = titleLabel.text ? titleLabel.text : @"";
    titleLabel.numberOfLines = 0;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
    NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.paragraphSpacing = 0;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paragraphStyle.alignment = NSTextAlignmentJustified;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleLabel.text.length)];
    [titleLabel setAttributedText:attributeString];
    CGRect rect = [ToolHelper stringRectWithSize:CGSizeMake(titleLabel.width, 0) boldFontSize:fontSize withString:titleLabel.text];
    CGFloat labelHeight = rect.size.height+(rect.size.height/(fontSize)-1)*lineSpace;
    
    return labelHeight;
}

+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace frontStr:(NSString *)frontStr frontFont:(UIFont *)frontFont backFont:(UIFont *)backFont {
    titleLabel.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
    [attributeString addAttribute:NSFontAttributeName value:frontFont range:NSMakeRange(0, frontStr.length)];
    [attributeString addAttribute:NSFontAttributeName value:backFont range:NSMakeRange(frontStr.length, titleLabel.text.length - frontStr.length)];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleLabel.text.length)];
    [titleLabel setAttributedText:attributeString];
    CGSize size = [titleLabel sizeThatFits:CGSizeMake(titleLabel.width, MAXFLOAT)];
    return size.height;
}

+ (CGFloat)caculateTotalHeight:(UILabel *)titleLabel lineSpace:(CGFloat)lineSpace {
    titleLabel.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:titleLabel.text];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleLabel.text.length)];
    [titleLabel setAttributedText:attributeString];
    CGSize size = [titleLabel sizeThatFits:CGSizeMake(titleLabel.width, MAXFLOAT)];
    return size.height;
}


+ (BOOL)filterArr:(NSArray *)arr1 andArr2:(NSArray *)arr2 {
    if (arr1.count == arr2.count) {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
        //得到两个数组中不同的数据
        NSArray *reslutFilteredArray = [arr2 filteredArrayUsingPredicate:filterPredicate];
        if (reslutFilteredArray.count > 0) {
            return YES;
        }
        return NO;
    }
    return YES;
}

//////

+ (void)controlNewEditColumn {
    NSDictionary *dic =  [PanGuUserDefault objectForKey:NEWEditColumn];
    if (![[dic allKeys] containsObject:K_VERSION_SHORT]) {
        [PanGuUserDefault setObject:@{} forKey:NEWEditColumn];
        [PanGuUserDefault synchronize];
    }
}

+ (void)saveNewEditColumnUserDefaults:(NSArray *)arr {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:arr forKey:K_VERSION_SHORT];
    [PanGuUserDefault setObject:dic forKey:NEWEditColumn];
    [PanGuUserDefault synchronize];
}

+ (NSArray *)queryNewEditColumnUserDefaults {
    NSDictionary *dic =  [PanGuUserDefault objectForKey:NEWEditColumn];
    NSArray *arr = dic[K_VERSION_SHORT];
    return arr;
}

+ (void)removeNewEditColumnUserDefaults {
    [PanGuUserDefault removeObjectForKey:NEWEditColumn];
    [PanGuUserDefault synchronize];
}

+ (void)updateNewEditColumnUserDafaults:(NSArray *)arr {
    NSMutableArray *isSelectedArr = [[NSMutableArray alloc]init];
    NSMutableArray *titleArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < arr.count; i ++ ) {
        [titleArr addObject:arr[i]];
        [isSelectedArr addObject:[NSNumber numberWithBool:YES]];
    }
    NSMutableArray *titleAndIsSelectedArr = @[titleArr,isSelectedArr].mutableCopy;
    [InfoCalculate saveNewEditColumnUserDefaults:titleAndIsSelectedArr];
}



@end
