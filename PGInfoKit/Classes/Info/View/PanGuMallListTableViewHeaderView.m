//
//  PanGuMallListTableViewHeaderView.m
//  PanGu
//
//  Created by guanqiang on 2018/10/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "PanGuMallListTableViewHeaderView.h"

@interface PanGuMallListTableViewHeaderView()

@property (nonatomic, copy) void (^clickedBlock)(void);

@end

@implementation PanGuMallListTableViewHeaderView

+ (instancetype)mallListHeaderWithTableView:(UITableView *)tableView {
    static NSString *const headerIdentifier = @"PanGuMallListTableViewHeaderView";
    PanGuMallListTableViewHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [[PanGuMallListTableViewHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.sakura.backgroundColor(CommonListContentBackColor);
        self.contentView.sakura.backgroundColor(CommonListContentBackColor);
        [self addViews];
    }
    return self;
}

//* 点击回调 */
- (void)setNameText:(id)text clickedBlock:(void(^)(void))clickedBlock {
    if ([text isKindOfClass:[NSString class]]) {
        self.nameLabel.text = text;
    }else if ([text isKindOfClass:[NSAttributedString class]]) {
        self.nameLabel.attributedText = text;
    }
    self.clickedBlock = clickedBlock;
}

- (void)addViews {
    
    self.redLineView = [UIView adddView:CGRectZero backColor:CommonPageLabelLineColor1 superView:self];
    
    self.nameLabel =  [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentTitleColor font:13 aligment:(NSTextAlignmentLeft) backColor:nil superView:self];
    
    self.detailImageView = [UIImageView addImageView:CGRectZero image:ImageNamed(@"ListArrow") superView:self];
    
    self.remarkLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentUnTitleColor font:13 aligment:NSTextAlignmentRight backColor:nil superView:self];
    
    self.lineView = [UIView adddView:CGRectZero backColor:CommonSpaceLineFullColor superView:self];
    
    UIButton *button =  [UIButton addBlankBtn:CGRectZero superView:self];
    [button addTarget:self action:@selector(clicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.redLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(9);
        make.width.offset(2);
        make.height.offset(10);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redLineView.mas_right).offset(5);
        make.right.bottom.top.offset(0);
    }];
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-9);
        make.width.offset(7);
        make.height.offset(14);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.detailImageView.mas_left).offset(-5);
        make.left.bottom.top.offset(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(KSINGLELINE_WIDTH);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)clicked {
    if (self.clickedBlock) {
        self.clickedBlock();
    }
}

@end
