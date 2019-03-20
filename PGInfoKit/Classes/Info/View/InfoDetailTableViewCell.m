
//
//  InfoDetailTableViewCell.m
//  PanGu
//
//  Created by 张琦 on 2017/7/19.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoDetailTableViewCell.h"
#import "PGInfo.h"

@interface InfoDetailTableViewCell ()

@property (nonatomic, assign) InfoDetailType type;

@end
@implementation InfoDetailTableViewCell

+ (id)infoDetailTableView:(UITableView *)tabelView {
    static NSString *cellId = @"infoDetailCellId";
    InfoDetailTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InfoDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sakura.backgroundColor(CommonListContentContentBackColor);
        cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    }
    return cell;
}

+ (id)infoDetailTableView:(UITableView *)tabelView reusableCellId:(NSString *)cellId {
    InfoDetailTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InfoDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sakura.backgroundColor(CommonListContentContentBackColor);
        cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customUI];
    }
    return self;
}

- (void)configTitleWithModel:(InfoNewsDetailModel *)model font:(NSInteger)fontAdd {
    
    _titleLabel.font = [UIFont systemFontOfSize:24 + fontAdd];
    _titleLabel.text = model.title;
    CGFloat titleLabelHeight = [InfoCalculate caculateTotalHeight:_titleLabel lineSpace:5 fontSize:24 + fontAdd];
    _titleLabel.frame = CGRectMake(15, 22, kScreenWidth - 30, titleLabelHeight);
    
    _dateLabel.font = [UIFont systemFontOfSize:14 + (fontAdd == 4 ? 2 : 0)];
    _dateLabel.text = model.time;
    _dateLabel.frame = CGRectMake(15, _titleLabel.bottom+10, kScreenWidth - 30, 14 + (fontAdd == 4 ? 2 : 0));
    
    _sourceLabel.font = [UIFont systemFontOfSize:14 + (fontAdd == 4 ? 2 : 0)];
    _sourceLabel.text = [NSString stringWithFormat:@"来源：%@",model.source];
    _sourceLabel.frame = CGRectMake(15, _dateLabel.top, _dateLabel.width, _dateLabel.height);
    
    _bottomLine.frame = CGRectMake(15, _dateLabel.bottom + 15, kScreenWidth - 30, KSINGLELINE_WIDTH);
    model.titleHeight = _bottomLine.bottom;
}

- (void)configDetailWithModel:(InfoNewsDetailModel *)model font:(NSInteger)fontAdd type:(InfoDetailType)type {
    _contentLabel.width = kScreenWidth - 30;
    NSString *contentStrT;
    if (type == InfoDetailTypeInvestment) { //* 投顾不显示摘要(1.7开会说的) */
        contentStrT = @"";
    } else {
        contentStrT = model.content;
    }
    contentStrT = [contentStrT stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    contentStrT = [contentStrT stringByReplacingOccurrencesOfString:@"\n\r\n" withString:@"\n"];
    contentStrT = [contentStrT stringByReplacingOccurrencesOfString:@"\n \n" withString:@"\n"];
    _contentLabel.text = contentStrT;
    _contentLabel.font = [UIFont systemFontOfSize:17 + (fontAdd==4 ? 5 : 0)];
    CGFloat height = [InfoCalculate caculateAlignmentTotalHeight:_contentLabel lineSpace:10 fontSize:(17+(fontAdd==4 ? 5 : 0))];
    _contentLabel.frame = CGRectMake(15, 16, kScreenWidth - 30, height);
    [_contentLabel sizeToFit];
    if (type == InfoDetailTypeOrdinary) {
        model.contentHeight = _contentLabel.bottom + 16;
    } else if (type == InfoDetailTypeInvestment) {
        model.contentHeight = _contentLabel.bottom + 13;
    }
}

- (void)customUI {
    
    _titleLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonContentTitleColor UIFont:[UIFont systemFontOfSize:24] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    _titleLabel.width = kScreenWidth - 30;

    //默认左
    _dateLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:15] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    
    //默认右
    _sourceLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:15] aligment:NSTextAlignmentRight backColor:nil superView:self.contentView];
    
    _contentLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentTextColor UIFont:[UIFont systemFontOfSize:17] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    
    _bottomLine = [UIView adddView:CGRectZero backColor:CommonSpaceLineUnfullColor superView:self.contentView];
    
    _stateLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:11] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    _stateLabel.numberOfLines = 0;
    _stateLabel.width = kScreenWidth - 56;
    
    _iconImageView = [UIImageView addImageView:CGRectZero image:nil superView:self.contentView];
    _iconImageView.contentMode = UIViewContentModeCenter;
    
    _investmentAdviserView = [[InvestmentAdviserView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [self.contentView addSubview:_investmentAdviserView];
    _investmentAdviserView.hidden = YES;
    
    _optionalRelatedView = [[InfoOptionalRelatedView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_optionalRelatedView];
}

- (void)configData:(InfoNewsDetailModel *)model fontAdd:(NSInteger)fontAdd type:(InfoDetailType)type {
    
    _titleLabel.font = [UIFont systemFontOfSize:24 + fontAdd];
    _dateLabel.font = [UIFont systemFontOfSize:15 + fontAdd];
    _sourceLabel.font = [UIFont systemFontOfSize:15 + fontAdd];
    
    _titleLabel.text = AssignmentStr(model.title);
    _dateLabel.text = AssignmentStr(model.time);
    
    CGFloat titleLabelHeight = [InfoCalculate caculateTotalHeight:_titleLabel lineSpace:5 fontSize:24 + fontAdd];
    _titleLabel.frame = CGRectMake(15, 22, kScreenWidth - 30, titleLabelHeight);
    
    if (type == InfoDetailTypeMall ||
        type == InfoDetailTypeMallDigest ||
        type == InfoDetailTypeOrdinary ||
        type == InfoDetailTypeStockNewsDetail) {
        _sourceLabel.text = kString_Format(@"来源：%@",AssignmentStr(model.source));
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.textAlignment = NSTextAlignmentRight;
        
        _sourceLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + 8 , (kScreenWidth - 30)/2.0, 15 + fontAdd);
        _dateLabel.frame = CGRectMake(_sourceLabel.right, _sourceLabel.top, _sourceLabel.width, _sourceLabel.height);
        _bottomLine.frame = CGRectMake(15, _dateLabel.bottom + 15, kScreenWidth - 30, KSINGLELINE_WIDTH);        
        model.titleHeight = _bottomLine.bottom;
        
    } else if (type == InfoDetailTypeDefault) {
        
        _dateLabel.frame = CGRectMake(15, _titleLabel.bottom + 10, kScreenWidth - 30, 15 + fontAdd);
        _bottomLine.frame = CGRectMake(15, _dateLabel.bottom + 15, kScreenWidth - 30, KSINGLELINE_WIDTH);
        
        model.titleHeight = _bottomLine.bottom;
        
    } else if (type == InfoDetailTypePacificInstitute) {
        _sourceLabel.text = AssignmentStr(model.source);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _iconImageView.image = ImageNamed(@"infoPacificInstitute");
        _iconImageView.frame = CGRectMake(15, _titleLabel.bottom + 8, 22, 22);
        _sourceLabel.frame = CGRectMake(_iconImageView.right + 4, _iconImageView.bottom - (15 + fontAdd) - 2 , kScreenWidth/2.0, 15 + fontAdd);
        _dateLabel.frame = CGRectMake(kScreenWidth/2.0, _sourceLabel.top, (kScreenWidth - 30)/2.0, 15 + fontAdd);
        _bottomLine.frame = CGRectMake(15, _dateLabel.bottom + 15, kScreenWidth - 30, KSINGLELINE_WIDTH);

        model.titleHeight = _bottomLine.bottom;
    
    } else if (type == InfoDetailTypeInvestment) {
        _sourceLabel.text = kString_Format(@"来源：%@",AssignmentStr(model.source));
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _sourceLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + 8 , kScreenWidth/2.0, 15 + fontAdd);
        _dateLabel.frame = CGRectMake(kScreenWidth/2.0, _sourceLabel.top, (kScreenWidth - 30)/2.0, _sourceLabel.height);
        _bottomLine.frame = CGRectMake(15, _sourceLabel.bottom + 15, kScreenWidth - 30, KSINGLELINE_WIDTH);

        model.titleHeight = _bottomLine.bottom;
        /*
        //如果有投顾信息
        _investmentAdviserView.hidden = NO;
        _investmentAdviserView.top = _sourceLabel.bottom + 10;
        //测试测试🙄🙄🙄🙄🙄🙄🙄🙄
        InvestmentAdviserModel *subModel = [[InvestmentAdviserModel alloc]init];
        subModel.name = @"知了";
        subModel.style = @"稳健稳健";
        subModel.cer = @"s111111111";
        [_investmentAdviserView configData:subModel];
        _bottomLine.hidden = YES;
        model.titleHeight = _investmentAdviserView.bottom + 10;
        */
        
//        if (1) {
//            _investmentAdviserView.hidden = NO;
//            _investmentAdviserView.top = _sourceLabel.bottom + 10;
//            _bottomLine.hidden = YES;
//            model.titleHeight = _investmentAdviserView.bottom + 10;
//        } else {
//            _investmentAdviserView.hidden = YES;
//            _bottomLine.hidden = NO;
//            _bottomLine.top = _sourceLabel.bottom + 15;
//            model.titleHeight = _bottomLine.bottom;
//        }
        
        
    } else if (type == InfoDetailTypeOptionalOnly) {
        _sourceLabel.text = AssignmentStr(model.source);
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.textAlignment = NSTextAlignmentRight;
        
        _sourceLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + 8 , (kScreenWidth - 30)/2.0, 15 + fontAdd);
        _dateLabel.frame = CGRectMake(_sourceLabel.right, _sourceLabel.top, _sourceLabel.width, _sourceLabel.height);
        
        _optionalRelatedView.frame = CGRectMake(15, _dateLabel.bottom + 15, kScreenWidth - 30, 0);
        _optionalRelatedView.height = [_optionalRelatedView configData:model];
        
        _bottomLine.frame = CGRectMake(15, _optionalRelatedView.bottom + 15, kScreenWidth - 30, KSINGLELINE_WIDTH);
        model.titleHeight = _bottomLine.bottom;
    }
}

- (void)configSwitchData:(InfoReadingModel *)model isPre:(BOOL)isPre {
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.sakura.textColor(CommonListContentTextColor);
    _titleLabel.text = kString_Format(@"%@：%@",(isPre ? @"上一篇" : @"下一篇"),AssignmentStr(model.title));
    CGFloat height = [InfoCalculate caculateTotalHeight:_titleLabel lineSpace:5];
    model.switchHeight = _titleLabel.height = height < 32 ? 60 : (height + 20);
    _titleLabel.frame = CGRectMake(10, 0, kScreenWidth - 20, _titleLabel.height);
    _bottomLine.frame = CGRectMake(10, model.switchHeight - KSINGLELINE_WIDTH, kScreenWidth - 10, KSINGLELINE_WIDTH);

}

@end

@interface InfoOptionalRelatedView ()

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *rightLabel;;

@end

@implementation InfoOptionalRelatedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.sakura.backgroundColor(HomeSudokuBackColor);
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.leftLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonPageLabelTextColor2 UIFont:[UIFont systemFontOfSize:10 weight:UIFontWeightMedium] aligment:NSTextAlignmentCenter backColor:nil superView:self];
    self.rightLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentTextColor UIFont:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] aligment:NSTextAlignmentLeft backColor:nil superView:self];
}
- (CGFloat)configData:(InfoNewsDetailModel *)model {
    self.leftLabel.text = @"自选相关个股";
    self.leftLabel.layer.sakura.borderColor(CommonPageLabelTextColor2);
    self.leftLabel.layer.borderWidth = KSINGLELINE_WIDTH;
    self.leftLabel.layer.cornerRadius = 2;
    self.leftLabel.frame = CGRectMake(10, 10, 70, 16);
    
    self.rightLabel.text = AssignmentStr(model.relatedStock);
    self.rightLabel.frame = CGRectMake(self.leftLabel.right + 5, self.leftLabel.top, self.width - self.rightLabel.left - 10, 0);
    CGFloat height = [ToolHelper sizeForNoticeTitle:self.rightLabel.text font:[UIFont systemFontOfSize:12]].height;
    if (height < 24) {
        height = 16;
        self.rightLabel.height = height;
        self.rightLabel.centerY = self.leftLabel.centerY;
    } else {
        self.rightLabel.top = self.leftLabel.top;
        self.rightLabel.height = [InfoCalculate caculateTotalHeight:self.rightLabel lineSpace:5 fontSize:12];
    }
    return self.rightLabel.bottom + 10;
}

@end
