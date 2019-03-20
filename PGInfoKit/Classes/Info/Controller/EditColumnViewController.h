//
//  EditColumnViewController.h
//  PanGu
//
//  Created by 吴肖利 on 16/9/18.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^editBlock)(BOOL isEdit);

@interface EditColumnViewController : BaseViewController

@property (nonatomic, copy) editBlock EditBlock;


@end
