//
//  PanGuMallListTableViewHeaderView.h
//  PanGu
//
//  Created by guanqiang on 2018/10/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PanGuMallListTableViewHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *redLineView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *detailImageView;

@property (nonatomic, strong) UILabel *remarkLabel;

+ (instancetype)mallListHeaderWithTableView:(UITableView *)tableView;

//* 点击回调 */
- (void)setNameText:(NSString *)text clickedBlock:(void(^)(void))clickedBlock;

@end

NS_ASSUME_NONNULL_END
