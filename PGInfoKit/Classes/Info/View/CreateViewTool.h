//
//  CreateViewTool.h
//  PanGu
//
//  Created by guanqiang on 2017/12/29.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CreateViewTool : NSObject

@end

@interface UIView (CreateViewTool)

/**
 创建 UIView
 
 @param rect      位置
 @param backColor 背景色
 @param superView 父视图
 @return UIView
 */
+ (UIView *)adddView:(CGRect)rect backColor:(id)backColor superView:(UIView *)superView;

- (void)setLayerBorderWidth:(CGFloat)borderWidth borderColor:(id)borderColor cornerRadius:(CGFloat)cornerRadius;

@end

@interface UILabel (CreateViewTool)

/**
 创建UILabel
 
 @param rect      位置
 @param text      文字
 @param textColor 文字颜色
 @param font      文字大小
 @param aligment  对齐方式
 @param backColor 背景颜色
 @param superView 父视图
 @return UILabel
 */
+ (UILabel *)addLabel:(CGRect)rect text:(NSString *)text textColor:(id)textColor font:(CGFloat)font aligment:(NSTextAlignment)aligment backColor:(id)backColor superView:(UIView *)superView;

+ (UILabel *)addLabel:(CGRect)rect text:(NSString *)text textColor:(id)textColor UIFont:(UIFont *)font aligment:(NSTextAlignment)aligment backColor:(id)backColor superView:(UIView *)superView;
@end

@interface UIButton (CreateViewTool)

/**
 创建UIButton
 
 @param rect            位置
 @param font            文字大小
 @param title           文字
 @param titleColor      文字颜色
 @param backgroundColor 背景颜色
 @param superView       父视图
 @return UIButton
 */
+ (UIButton *)addBtn:(CGRect)rect font:(CGFloat)font title:(NSString *)title titleColor:(id)titleColor backColor:(id)backgroundColor superView:(UIView *)superView;

+ (UIButton *)addBtn:(CGRect)rect UIFont:(UIFont *)font title:(NSString *)title titleColor:(id)titleColor backColor:(id)backgroundColor superView:(UIView *)superView;

/**
 创建UIButton
 
 @param rect          位置
 @param image         图片
 @param selectedImage 选中的图片
 @param superView     父视图
 @return UIButton
 */
+ (UIButton *)addBtn:(CGRect)rect image:(id)image selectImage:(id)selectImage superView:(UIView *)superView;


/**
 创建空白UIButton
 
 @param rect      位置
 @param superView 父视图
 @return UIButton
 */
+ (UIButton *)addBlankBtn:(CGRect)rect superView:(UIView *)superView;


/**
 添加事件
 
 @param target target
 @param sel    SEL
 */
- (void)target:(id)target sel:(SEL)sel;

@end

@interface UIImageView (extension)


/**
 创建UIImageView
 
 @param rect      位置
 @param image     图片
 @param superView 父视图
 @return UIImageView
 */
+ (UIImageView *)addImageView:(CGRect)rect image:(id)image superView:(UIView *)superView;

@end

@interface UITableView (CreateViewTool)

+ (UITableView *)addTableViewFrame:(CGRect)rect style:(UITableViewStyle)style delegate:(id)delegate emptyDelegate:(id)emptyDelegate superView:(UIView *)superView;

+ (UITableView *)addTableViewFrame:(CGRect)rect delegate:(id)delegate emptyDelegate:(id)emptyDelegate backColor:(id)backColor registerCell:(NSArray<NSString *>*)registerCells superView:(UIView *)superView;

- (void)registerTableCell:(NSArray<NSString *> *)registerCells;
- (void)registerHeaderFooterViwe:(NSArray<NSString *> *)views;

@end


@interface UICollectionView (CreateViewTool)

+ (UICollectionView *)addCollectionViewLayout:(UICollectionViewLayout *)layout frame:(CGRect)rect delegate:(id)delegate emptyDelegate:(id)emptyDelegate backColor:(id)backColor registerCell:(NSArray<NSString *>*)registerCells superView:(UIView *)superView;

- (void)registerHeaderView:(NSArray<NSString *> *)headerViewArr;

- (void)registerFooterView:(NSArray<NSString *> *)footerViewArr;

@end

@interface UITableViewCell (CreateViewTool)

+ (instancetype)dequeueReusableCellWithTableView:(UITableView *)tableView;

@end
