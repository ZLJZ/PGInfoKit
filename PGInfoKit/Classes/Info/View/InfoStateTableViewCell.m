//
//  InfoStateTableViewCell.m
//  PanGu
//
//  Created by 张琦 on 2017/7/26.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoStateTableViewCell.h"

@implementation InfoStateTableViewCell

+ (id)infoStateTableView:(UITableView *)tableView {
    static NSString *cellId = @"infoStateCellId";
    InfoStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InfoStateTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
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

- (void)customUI {
    
    _stateLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:13] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    _stateLabel.width = kScreenWidth - 30;

    _sourceLabel = [UILabel addLabel:CGRectZero text:@"" textColor:CommonListContentRemarkTextColor UIFont:[UIFont systemFontOfSize:13] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
}

- (void)configData:(InfoNewsDetailModel *)model type:(InfoDetailType)type {
    _stateLabel.text = AssignmentStr(model.statement);
    CGFloat height = [InfoCalculate caculateTotalHeight:_stateLabel lineSpace:5 fontSize:13];

    if (type == InfoDetailTypePacificInstitute ||
               type == InfoDetailTypeOrdinary ||
               type == InfoDetailTypeMall ||
               type == InfoDetailTypeMallDigest ||
               type == InfoDetailTypeStockNewsDetail ||
               type == InfoDetailTypeOptionalOnly ||
               type == InfoDetailTypeInvestment) {
        
        _stateLabel.frame = CGRectMake(15, 14, kScreenWidth - 30, height);

    } else {
        _sourceLabel.text = kString_Format(@"信息来源：%@",AssignmentStr(model.source));
        CGFloat sourceHeight = [InfoCalculate caculateTotalHeight:_sourceLabel lineSpace:5 fontSize:13];
        _sourceLabel.frame = CGRectMake(15, 14, kScreenWidth - 30, sourceHeight);
        
        _stateLabel.frame = CGRectMake(15, _sourceLabel.bottom + 10, kScreenWidth - 30, height);
    }
    
    model.stateHeight = _stateLabel.bottom + 13;
}

@end

