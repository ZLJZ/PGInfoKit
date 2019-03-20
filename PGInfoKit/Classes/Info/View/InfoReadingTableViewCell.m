//
//  InfoReadingTableViewCell.m
//  PanGu
//
//  Created by 张琦 on 2017/7/11.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoReadingTableViewCell.h"
#import "PGInfo.h"

#define FONT_SYSTEM                     @"Helvetica"
@implementation InfoReadingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customCell];
    }
    return self;
}

- (void)customCell {
    
    _calendarImageView = [[UIImageView alloc]init];
    _calendarImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_calendarImageView];
    
    _calendarTopLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _calendarImageView.width, 5)];
    _calendarTopLabel.textColor = COLOR_WHITE;
    _calendarTopLabel.font = [UIFont systemFontOfSize:5];
    _calendarTopLabel.hidden = YES;
    _calendarTopLabel.textAlignment = NSTextAlignmentCenter;
    [_calendarImageView addSubview:_calendarTopLabel];
    
    _calendarBottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _calendarTopLabel.bottom, _calendarImageView.width, _calendarImageView.height - _calendarTopLabel.height)];
    _calendarBottomLabel.textColor = COLOR_YELLOW;
    _calendarBottomLabel.font = [UIFont systemFontOfSize:12];
    _calendarBottomLabel.hidden = YES;
    _calendarBottomLabel.textAlignment = NSTextAlignmentCenter;
    [_calendarImageView addSubview:_calendarBottomLabel];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(52, _calendarImageView.centerY - 5, 130, 10)];
    _dateLabel.sakura.textColor(CommonListContentRemarkTextColor);
    _dateLabel.font = [UIFont systemFontOfSize:13];
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_dateLabel];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.left, _dateLabel.bottom + 10, kScreenWidth - 15 - _dateLabel.left, 15)];
    _titleLabel.sakura.textColor(CommonListContentTextColor);
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + 10, _titleLabel.width, 15)];
    _contentLabel.sakura.textColor(CommonListContentTextColor);
    _contentLabel.font = [UIFont fontWithName:FONT_SYSTEM size:15];
    [self.contentView addSubview:_contentLabel];
    
    _bottomSingleView = [[UIView alloc]initWithFrame:CGRectMake(26, _calendarImageView.bottom, KSINGLELINE_WIDTH, 0)];
    _bottomSingleView.sakura.backgroundColor(CommonSpaceLineUnfullColor);
    [self.contentView addSubview:_bottomSingleView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (id)infoReadingTableViewCell:(UITableView *)tableView {
    static NSString *cellId = @"infoReadingCellId";
    InfoReadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InfoReadingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    cell.sakura.backgroundColor(CommonListContentContentBackColor);
    return cell;
}


@end
