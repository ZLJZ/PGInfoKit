//
//  TradePDFController.h
//  PanGu
//
//  Created by 王玉 on 2016/11/9.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "BaseViewController.h"

@interface TradePDFController : BaseViewController
- (void)reloadWithString:(NSString *)url;
- (void)reloadWithFileName:(NSString *)name;
@end
