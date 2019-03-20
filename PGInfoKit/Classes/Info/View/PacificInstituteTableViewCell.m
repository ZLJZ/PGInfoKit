//
//  PacificInstituteTableViewCell.m
//  PanGu
//
//  Created by 吴肖利 on 2018/12/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "PacificInstituteTableViewCell.h"
#import "InfoCalculate.h"
#import "InvestmentAdviserTableViewCell.h"

@implementation PacificInstituteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customUI];
    }
    return self;
}

- (void)customUI {
    _titleLabel = [UILabel addLabel:CGRectMake(10, 14, kScreenWidth - 20, 17) text:@"" textColor:CommonListContentTextColor UIFont:[UIFont systemFontOfSize:17] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    
    _dateLabel = [UILabel addLabel:CGRectMake(kScreenWidth/2.0, 0, (kScreenWidth - 20)/2.0, 13) text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:13] aligment:NSTextAlignmentRight backColor:nil superView:self.contentView];
    
    _sourceLabel = [UILabel addLabel:CGRectMake(10, 0, (kScreenWidth - 20)/2.0, 13) text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:13] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    
    _singleView = [UIView adddView:CGRectMake(10, 0, kScreenWidth - 10, KSINGLELINE_WIDTH) backColor:CommonSpaceLineUnfullColor superView:self.contentView];
}

- (void)configData:(InfoReadingModel *)model type:(InfoListType)type {
    
    if (type == InfoListTypeCPGG ||
        type == InfoListTypePacificInstitute ||
        type == InfoListTypeInvestmentProfessor) {
        
        _titleLabel.text = AssignmentStr(model.title);
        _sourceLabel.text = AssignmentStr(model.source);
        _dateLabel.text = AssignmentStr(model.time);
        
        CGFloat titleLabelHeight = [InfoCalculate caculateHeight:_titleLabel lineSpace:5 fontSize:17 row:2];
        _titleLabel.height = titleLabelHeight;
        _dateLabel.top = _sourceLabel.top = _titleLabel.bottom + 10;
        model.height = _dateLabel.bottom + 14;
        _singleView.top = model.height - KSINGLELINE_WIDTH;
    }
    
}

+ (id)initWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"pacificInstituteCellId";
    PacificInstituteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PacificInstituteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
        cell.sakura.backgroundColor(CommonListContentContentBackColor);
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end

@interface ProfessorHeaderView ()


//内容
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) InvestmentAdviserView *professorView;
//展开收起箭头
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *backView;
//底部view
@property (nonatomic, strong) UIView *bottomView;
//
@property (nonatomic, strong) InvestmentAdviserModel *model;
//
@property (nonatomic, copy) void(^eventBlock)(CGFloat height);

@end

@implementation ProfessorHeaderView

- (instancetype)initWithEventBlock:(void(^)(CGFloat height))block {
    if (self = [super init]) {
        self.eventBlock = block;
        self.sakura.backgroundColor(CommonListContentContentBackColor);
        self.frame = CGRectMake(0, 0, kScreenWidth, 195);
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.professorView = [[InvestmentAdviserView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 100)];
    [self addSubview:self.professorView];
    self.backView = [UIView adddView:CGRectMake(0, self.professorView.bottom + 10, kScreenWidth, 91) backColor:CommonListContentContentBackColor superView:self];
    self.bottomLabel = [UILabel addLabel:CGRectMake(10, 0, kScreenWidth - 20, 56) text:@"" textColor:CommonListContentTextColor UIFont:[UIFont systemFontOfSize:13] aligment:NSTextAlignmentLeft backColor:nil superView:self.backView];
    self.bottomLabel.userInteractionEnabled = YES;
    self.imageView = [UIImageView addImageView:CGRectMake((kScreenWidth - 100)/2.0, self.bottomLabel.bottom, 100, 20) image:ImageNamed(@"up") superView:self.backView];
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.hidden = YES;
    self.bottomView = [UIView adddView:CGRectMake(0, self.imageView.bottom, kScreenWidth, 5) backColor:CommonGlobalBackColor superView:self.backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.backView addGestureRecognizer:tap];
}

- (void)configData:(InvestmentAdviserModel *)model {
    _model = model;
    [self.professorView configData:model];
    self.bottomLabel.text = AssignmentEmptyStr(model.content);
    [self dealWithUnfoldLabel];
    self.height = self.backView.bottom;
    if (self.eventBlock) {
        self.eventBlock(self.height);
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    CGFloat height = [InfoCalculate caculateTotalHeight:self.bottomLabel lineSpace:5];
    if (height <= 57) return;
    _model.isUnfold = !_model.isUnfold;
    [self dealWithUnfoldLabel];
    self.height = self.backView.bottom;
    if (self.eventBlock) {
        self.eventBlock(self.height);
    }
}

- (void)dealWithUnfoldLabel {
    self.professorView.top = 5;
    CGFloat height = [InfoCalculate caculateTotalHeight:self.bottomLabel lineSpace:5];
    if (_model.isUnfold) {
        self.bottomLabel.height = height;
        self.imageView.hidden = NO;
        self.imageView.transform = CGAffineTransformMakeRotation(0);
        self.imageView.top = self.bottomLabel.bottom;
        self.bottomView.top = self.imageView.bottom;
        self.backView.height = self.bottomView.bottom;
    } else {
        if (height > 57) {
            self.bottomLabel.height = 57;
            self.imageView.hidden = NO;
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            self.imageView.top = self.bottomLabel.bottom;
            self.bottomView.top = self.imageView.bottom;
            self.backView.height = self.bottomView.bottom;
        } else {
            self.imageView.hidden = YES;
            self.bottomLabel.height = height;
            self.bottomView.top = self.bottomLabel.bottom + (height == 0 ? : 10);
            self.backView.height = self.bottomView.bottom;
        }
    }
}


@end
