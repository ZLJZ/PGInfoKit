//
//  InfoTagTableViewCell.m
//  PanGu
//
//  Created by 张琦 on 2017/7/20.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoTagTableViewCell.h"

@implementation InfoTagTableViewCell

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
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.width = kScreenWidth - 30;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.sakura.textColor(CommonListContentTextColor);
    [self.contentView addSubview:_titleLabel];
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont systemFontOfSize:13];
    _dateLabel.sakura.textColor(CommonListContentRemarkTextColor);
    [self.contentView addSubview:_dateLabel];
    _singleView = [[UIView alloc]init];
    _singleView.sakura.backgroundColor(CommonSpaceLineUnfullColor);
    [self.contentView addSubview:_singleView];
}

+(id)infoTagTableView:(UITableView *)tableView {
    static NSString *cellId = @"infoTagCellId";
    InfoTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InfoTagTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
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
