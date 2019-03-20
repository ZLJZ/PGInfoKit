//
//  EditColumnTableViewCell.m
//  PanGu
//
//  Created by 吴肖利 on 16/9/18.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "EditColumnTableViewCell.h"

@implementation EditColumnTableViewCell

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
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (55-30)/2, 24, 30)];
    _leftImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_leftImageView];
    
    _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftImageView.right+10, 0, kScreenWidth-(_leftImageView.right+10+20), 55)];
    _topLabel.sakura.textColor(CommonListContentTextColor);
    _topLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_topLabel];
    
    _leftImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftImageButton.frame = CGRectMake(0, 0, kScreenWidth-60, 55);
    [self.contentView addSubview:_leftImageButton];
    [UIView adddView:CGRectMake(15, 55 - KSINGLELINE_WIDTH, kScreenWidth - 15, KSINGLELINE_WIDTH) backColor:CommonSpaceLineUnfullColor superView:self.contentView];

    
}

+ (id)editColumnTableViewCell:(UITableView *)tableView {
    static NSString *cellId = @"editColumnCellId";
    EditColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EditColumnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.contentView.sakura.backgroundColor(CommonListContentContentBackColor);
    cell.sakura.backgroundColor(CommonListContentContentBackColor);
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing: editing animated: YES];
    if (editing) {
        for (UIView * view in self.subviews) {
            if ([NSStringFromClass([view class]) rangeOfString:@"Reorder"].location != NSNotFound) {
                for (UIView * subview in view.subviews) {
                    if ([subview isKindOfClass: [UIImageView class]]) {
                        subview.size = CGSizeMake(20, 15);
                        ((UIImageView *)subview).sakura.image(PGImageMarketHqOptionaleditSort);
                        return;
                    }
                }
            }
        }
    }
}

@end
