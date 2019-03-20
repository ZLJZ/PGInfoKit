//
//  AccessoryTableViewCell.m
//  PanGu
//
//  Created by 张琦 on 2017/8/30.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "AccessoryTableViewCell.h"
#import "InfoCalculate.h"
#import "PGInfo.h"

@implementation AccessoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customCell];
    }
    return self;
}

- (void)customCell {
    _accessoryLabel = [UILabel addLabel:CGRectMake(15, 0, kScreenWidth - 30, 60) text:@"" textColor:COLOR_BLUE UIFont:[UIFont systemFontOfSize:16] aligment:NSTextAlignmentLeft backColor:nil superView:self.contentView];
    
    _singleView = [UIView adddView:CGRectMake(15, 60 - KSINGLELINE_WIDTH, kScreenWidth, KSINGLELINE_WIDTH) backColor:CommonSpaceLineUnfullColor superView:self.contentView];
}

- (void)configData:(InfoAttachmentModel *)model {
    _accessoryLabel.text = [AssignmentStr(model.name) hasSuffix:@".pdf"] ? AssignmentStr(model.name) : kString_Format(@"%@.pdf",AssignmentStr(model.name));
    CGFloat height = [InfoCalculate caculateTotalHeight:_accessoryLabel lineSpace:5];
    model.height = _accessoryLabel.height = height < 32 ? 60 : (height + 20);
    _singleView.top = model.height - KSINGLELINE_WIDTH;
}

+ (id)accessoryTableViewCell:(UITableView *)tableView {
    static NSString *cellId = @"accessoryTableViewCellId";
    AccessoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AccessoryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sakura.backgroundColor(CommonListContentContentBackColor);
        cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
