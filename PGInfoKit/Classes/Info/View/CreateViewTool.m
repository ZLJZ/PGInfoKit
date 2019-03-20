//
//  CreateViewTool.m
//  PanGu
//
//  Created by guanqiang on 2017/12/29.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "CreateViewTool.h"

@implementation CreateViewTool

@end

@implementation UIView (CreateViewTool)

+ (UIView *)adddView:(CGRect)rect backColor:(id)backColor superView:(UIView *)superView {
    UIView *view = [[UIView alloc] init];
    view.frame = rect;
    if (backColor) {
        if ([backColor isKindOfClass:[UIColor class]]) {
            view.backgroundColor = backColor;
        }else {
            view.sakura.backgroundColor(backColor);
        }
    }

    if (superView) {
        [superView addSubview:view];
    }
    return view;
}

- (void)setLayerBorderWidth:(CGFloat)borderWidth borderColor:(id)borderColor cornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    if (borderColor) {
        if ([borderColor isKindOfClass:[UIColor class]]) {
            self.layer.borderColor = ((UIColor *)borderColor).CGColor;
        }else {
            self.layer.sakura.borderColor(borderColor);
        }
    }
    self.layer.borderWidth = borderWidth;
}

@end

@implementation UILabel (CreateViewTool)

+ (UILabel *)addLabel:(CGRect)rect text:(NSString *)text textColor:(id)textColor font:(CGFloat)font aligment:(NSTextAlignment)aligment backColor:(id)backColor superView:(UIView *)superView {
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    label.textAlignment = aligment;
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    if (text) {
        label.text = text;
    }
    if (textColor) {
        if ([textColor isKindOfClass:[UIColor class]]) {
            label.textColor = textColor;
        }else {
            label.sakura.textColor(textColor);
        }
    }
    if (backColor) {
        if ([backColor isKindOfClass:[UIColor class]]) {
            label.backgroundColor = backColor;
        }else {
            label.sakura.backgroundColor(backColor);
        }
    }
    if (superView) {
        [superView addSubview:label];
    }
    return label;
}

+ (UILabel *)addLabel:(CGRect)rect text:(NSString *)text textColor:(id)textColor UIFont:(UIFont *)font aligment:(NSTextAlignment)aligment backColor:(id)backColor superView:(UIView *)superView {
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    label.textAlignment = aligment;
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    if (textColor) {
        if ([textColor isKindOfClass:[UIColor class]]) {
            label.textColor = textColor;
        }else {
            label.sakura.textColor(textColor);
        }
    }
    if (backColor) {
        if ([backColor isKindOfClass:[UIColor class]]) {
            label.backgroundColor = backColor;
        }else {
            label.sakura.backgroundColor(backColor);
        }
    }
    if (superView) {
        [superView addSubview:label];
    }
    return label;
}
@end

@implementation UIButton (CreateViewTool)

+ (UIButton *)addBtn:(CGRect)rect font:(CGFloat)font title:(NSString *)title titleColor:(id)titleColor backColor:(id)backgroundColor superView:(UIView *)superView {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    if (font) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:font]];
    }
    if (title) {
        [button setTitle:title forState:(UIControlStateNormal)];
    }
    if (titleColor) {
        if ([titleColor isKindOfClass:[UIColor class]]) {
            [button setTitleColor:titleColor forState:(UIControlStateNormal)];
        }else {
            button.sakura.titleColor(titleColor,UIControlStateNormal);
        }
    }
    if (backgroundColor) {
        if ([backgroundColor isKindOfClass:[UIColor class]]) {
            button.backgroundColor = backgroundColor;
        }else {
            button.sakura.backgroundColor(backgroundColor);
        }
    }
    if (superView) {
        [superView addSubview:button];
    }
    return button;
}

+ (UIButton *)addBtn:(CGRect)rect UIFont:(UIFont *)font title:(NSString *)title titleColor:(id)titleColor backColor:(id)backgroundColor superView:(UIView *)superView {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    if (font) {
        [button.titleLabel setFont:font];
    }
    if (title) {
        [button setTitle:title forState:(UIControlStateNormal)];
    }
    if (titleColor) {
        if ([titleColor isKindOfClass:[UIColor class]]) {
            [button setTitleColor:titleColor forState:(UIControlStateNormal)];
        }else {
            button.sakura.titleColor(titleColor,UIControlStateNormal);
        }
    }
    if (backgroundColor) {
        if ([backgroundColor isKindOfClass:[UIColor class]]) {
            button.backgroundColor = backgroundColor;
        }else {
            button.sakura.backgroundColor(backgroundColor);
        }
    }
    if (superView) {
        [superView addSubview:button];
    }
    return button;
}

+ (UIButton *)addBtn:(CGRect)rect image:(id)image selectImage:(id)selectImage superView:(UIView *)superView {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    
    if ([image isKindOfClass:[NSString class]]) {
        button.sakura.image(image,UIControlStateNormal);
    }else {
        [button setImage:image forState:(UIControlStateNormal)];
    }
    
    if ([selectImage isKindOfClass:[NSString class]]) {
        button.sakura.image(selectImage,UIControlStateSelected);
    }else {
        [button setImage:selectImage forState:(UIControlStateSelected)];
    }
    
    if (superView) {
        [superView addSubview:button];
    }
    return button;
}

+ (UIButton *)addBlankBtn:(CGRect)rect superView:(UIView *)superView {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    button.backgroundColor = [UIColor clearColor];
    if (superView) [superView addSubview:button];
    return button;
}

- (void)target:(id)target sel:(SEL)sel {
    [self addTarget:target action:sel forControlEvents:(UIControlEventTouchUpInside)];
}

@end

@implementation UIImageView (CreateViewTool)

+ (UIImageView *)addImageView:(CGRect)rect image:(id)image superView:(UIView *)superView {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:rect];
    if (image) {
        if ([image isKindOfClass:[NSString class]]) {
            imageV.sakura.image(image);
        }else {
            imageV.image = image;
        }
    }
    if (superView) {
        [superView addSubview:imageV];
    }
    return imageV;
}

@end

@implementation UITableView (CreateViewTool)

+ (UITableView *)addTableViewFrame:(CGRect)rect style:(UITableViewStyle)style delegate:(id)delegate emptyDelegate:(id)emptyDelegate superView:(UIView *)superView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:style];
    if (delegate) {
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
    }
    if (emptyDelegate) {
        tableView.emptyDataSetDelegate = emptyDelegate;
        tableView.emptyDataSetSource = emptyDelegate;
    }
    
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.sakura.backgroundColor(CommonListContentBackColor);
    tableView.backgroundView = [UIView adddView:tableView.bounds backColor:CommonListContentBackColor superView:nil];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    
    if (superView) {
        [superView addSubview:tableView];
    }
    return tableView;
}

+ (UITableView *)addTableViewFrame:(CGRect)rect delegate:(id)delegate emptyDelegate:(id)emptyDelegate backColor:(id)backColor registerCell:(NSArray<NSString *>*)registerCells superView:(UIView *)superView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:(UITableViewStylePlain)];
    if (delegate) {
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
    }
    if (emptyDelegate) {
        tableView.emptyDataSetDelegate = emptyDelegate;
        tableView.emptyDataSetSource = emptyDelegate;
    }
    if (backColor) {
        if ([backColor isKindOfClass:[UIColor class]]) {
            tableView.backgroundColor = backColor;
        }else {
            tableView.sakura.backgroundColor(backColor);
        }
    }
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.backgroundView = [UIView adddView:tableView.bounds backColor:backColor superView:nil];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    
    for (NSString *cell in registerCells) {
        [tableView registerClass:NSClassFromString(cell) forCellReuseIdentifier:cell];
    }
    if (superView) {
        [superView addSubview:tableView];
    }
    return tableView;
}

- (void)registerTableCell:(NSArray<NSString *> *)registerCells {
    for (NSString *cell in registerCells) {
        [self registerClass:NSClassFromString(cell) forCellReuseIdentifier:cell];
    }
}

- (void)registerHeaderFooterViwe:(NSArray<NSString *> *)views {
    for (NSString *cell in views) {
        [self registerClass:NSClassFromString(cell) forHeaderFooterViewReuseIdentifier:cell];
    }
}

@end


@implementation UICollectionView (CreateViewTool)

+ (UICollectionView *)addCollectionViewLayout:(UICollectionViewLayout *)layout frame:(CGRect)rect delegate:(id)delegate emptyDelegate:(id)emptyDelegate backColor:(id)backColor registerCell:(NSArray<NSString *>*)registerCells superView:(UIView *)superView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    collectionView.alwaysBounceVertical = YES;
    if (delegate) {
        collectionView.delegate = delegate;
        collectionView.dataSource = delegate;
    }
    if (emptyDelegate) {
        collectionView.emptyDataSetDelegate = emptyDelegate;
        collectionView.emptyDataSetSource = emptyDelegate;
    }
    if (backColor) {
        if ([backColor isKindOfClass:[UIColor class]]) {
            collectionView.backgroundColor = backColor;
        }else {
            collectionView.sakura.backgroundColor(backColor);
        }
    }
    collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    collectionView.backgroundView = [UIView adddView:collectionView.bounds backColor:backColor superView:nil];
    for (NSString *cell in registerCells) {
        [collectionView registerClass:NSClassFromString(cell) forCellWithReuseIdentifier:cell];
    }
    if (superView) {
        [superView addSubview:collectionView];
    }
    return collectionView;
}

- (void)registerHeaderView:(NSArray<NSString *> *)headerViewArr {
    for (NSString *item in headerViewArr) {
        [self registerClass:NSClassFromString(item) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:item];
    }
}

- (void)registerFooterView:(NSArray<NSString *> *)footerViewArr {
    for (NSString *item in footerViewArr) {
        [self registerClass:NSClassFromString(item) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:item];
    }
}

@end

@implementation UITableViewCell (CreateViewTool)

+ (instancetype)dequeueReusableCellWithTableView:(UITableView *)tableView {
    const char *name = class_getName(self);
    NSString *cellIdentifier = [NSString stringWithUTF8String:name];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
        cell.sakura.backgroundColor(CommonListContentContentBackColor);
    }
    return cell;
}

@end
