//
//  InfoImportantNewsTableViewCell.m
//  PanGu
//
//  Created by 张琦 on 2017/7/10.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoImportantNewsTableViewCell.h"

@implementation InfoImportantNewsTableViewCell

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
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (120 - 90)/2, 120, 90)];
    _leftImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftImageView.right + 12, 29, kScreenWidth - 15 - (_leftImageView.right + 12), 40)];
    _titleLabel.sakura.textColor(CommonListContentTextColor);
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + 10, _titleLabel.width, 13)];
    _dateLabel.sakura.textColor(CommonListContentRemarkTextColor);
    _dateLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_dateLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)infoImportantNewsTableViewCell:(UITableView *)tableView {
    static NSString *cellId = @"infoImportantNewsCellId";
    InfoImportantNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[InfoImportantNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    cell.sakura.backgroundColor(CommonListContentContentBackColor);
    return cell;
}

@end
