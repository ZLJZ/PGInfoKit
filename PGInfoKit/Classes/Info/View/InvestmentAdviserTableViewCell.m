//
//  InvestmentAdviserTableViewCell.m
//  PanGu
//  投顾view
//  Created by 吴肖利 on 2018/12/13.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "InvestmentAdviserTableViewCell.h"

@interface InvestmentAdviserTableViewCell ()

@end
@implementation InvestmentAdviserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.investmentAdviserView = [[InvestmentAdviserView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [self.contentView addSubview:self.investmentAdviserView];
}

+ (id)initWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"investmentAdviserCellId";
    InvestmentAdviserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InvestmentAdviserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sakura.backgroundColor(CommonListContentContentBackColor);
        cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    }
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@interface InvestmentAdviserView ()

@property (nonatomic, strong) UILabel *titleLabel;

//@property (nonatomic, strong) MsgShadowView *shadowView;

@property (nonatomic, strong) UIImageView *backImageView;
//头像
@property (nonatomic, strong) UIImageView *headPortraitImageView;
//名称
@property (nonatomic, strong) UILabel *nameLabel;
//投资风格
@property (nonatomic, strong) UILabel *styleLabel;
//资质证书
@property (nonatomic, strong) UILabel *cerLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@end
@implementation InvestmentAdviserView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    
//    self.shadowView = [[MsgShadowView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 90) backColor:CommonListContentContentBackColor shadowColor:MineMsgShadowColor shadowOffset:CGSizeMake(0, 2) shadowRadius:2 shadowOpacity:0.2 cornerRadius:3 superView:self];
//    self.backImageView = [UIImageView addImageView:CGRectMake(0, 0, self.shadowView.width, self.shadowView.height) image:ImageNamed(@"") superView:self.shadowView];
//    self.headPortraitImageView = [UIImageView addImageView:CGRectMake(14, 10, 70, 70) image:nil superView:self.backImageView];
//    self.nameLabel = [UILabel addLabel:CGRectMake(self.headPortraitImageView.right + 14, 12, kScreenWidth - 98, 17) text:@"" textColor:COLOR_DARKGREY UIFont:[UIFont systemFontOfSize:17] aligment:NSTextAlignmentLeft backColor:nil superView:self.backImageView];
//    self.rightLabel = [UILabel addLabel:CGRectMake(self.backImageView.width - 115, 0, 100, 13) text:@"首席投资顾问" textColor:COLOR_DARKGREY UIFont:[UIFont systemFontOfSize:13] aligment:NSTextAlignmentRight backColor:nil superView:self.backImageView];
//    self.rightLabel.centerY = self.nameLabel.centerY;
//    self.styleLabel = [UILabel addLabel:CGRectMake(self.nameLabel.left, self.backImageView.height - 41, kScreenWidth - 98, 12) text:@"投资风格：" textColor:COLOR_DARKGREY UIFont:[UIFont systemFontOfSize:12] aligment:NSTextAlignmentLeft backColor:nil superView:self.backImageView];
//    self.cerLabel = [UILabel addLabel:CGRectMake(self.nameLabel.left, self.styleLabel.bottom + 7, kScreenWidth - 98, 12) text:@"资质证书：" textColor:COLOR_DARKGREY UIFont:[UIFont systemFontOfSize:12] aligment:NSTextAlignmentLeft backColor:nil superView:self.backImageView];


}

- (void)configData:(InvestmentAdviserModel *)model {
    self.headPortraitImageView.backgroundColor = COLOR_BACK;
    self.headPortraitImageView.layer.cornerRadius = self.headPortraitImageView.height/2.0;
    self.headPortraitImageView.layer.sakura.borderColor(CommonSpaceLineUnfullColor);
    self.headPortraitImageView.layer.borderWidth = KSINGLELINE_WIDTH;
    self.headPortraitImageView.clipsToBounds = YES;
    
    self.nameLabel.text = AssignmentStr(model.name);
    self.styleLabel.text = kString_Format(@"投资风格：%@",AssignmentStr(model.style));
    self.cerLabel.text = kString_Format(@"资质证书：%@",AssignmentStr(model.cer));
}

@end
