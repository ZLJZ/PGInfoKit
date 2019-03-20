//
//  PacificInstituteViewController.h
//  PanGu
//  独家研报
//  Created by 吴肖利 on 2018/12/12.
//  Copyright © 2018 Security Pacific Corporation. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoHeaderDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface PacificInstituteViewController : BaseViewController

- (instancetype)initWithType:(PacificInstituteType)type;

@end

@interface PacificInstituteListViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithType:(PacificInstituteType)type curIdx:(NSInteger)curIdx;

@end

NS_ASSUME_NONNULL_END
