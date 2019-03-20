//
//  PanGu_ConfigBase_Bms.h
//  PanGu
//
//  Created by 陈伟平 on 16/6/24.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#ifndef PanGu_ConfigBase_Bms_h
#define PanGu_ConfigBase_Bms_h

#define K_VERSION_SHORT  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define TOAST_DURATION 3.0 // 弹框消失时间
#define PUBLIC_REQUEST_TIMEOUT 30.0 // 网络请求超时时间(行情除外)
#define REQUEST_TIMEOUT_INTERVAL    [[defaults objectForKey:REQUEST_TIMEOUT] doubleValue]
#define PING_TIMEOUT_INTERVAL   [[defaults objectForKey:PING_TIMEOUT] doubleValue]


#define MARKET_URL @"http://test-tnhq.tpyzq.com:8082" //行情

#define AssignmentStr(str)  [ToolHelper isBlankString:str] ? @"--" : str
#define ERROR_LOADING(error) [ToolHelper isShowDLLoading:error.code]?[DLLoading DLToolTipInWindow:kString_Format(@"%ld — 连接失败",error.code)]:[ToolHelper isShowDLLoading:error.code];

#define multiple  kScreenHeight/667 //倍数

//获取物理屏幕尺寸
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)


//系统
#define iOS7orLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS8orLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS9orLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS10orLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define iOS11orLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
//设备设备
#define isiPhone5 CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)
#define isiPhoneX CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)

// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT (isiPhoneX ? 44 : 20)

// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATIONBAR_HEIGHT (44)

#define NAV_HEIGHT (SYS_STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT)

//navigationBar高度
#define kNavigationHeight (SYS_STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT)

//轻量缓存
#define defaults [NSUserDefaults standardUserDefaults]

//定义UIImage对象
#define ImageNamed(picName) [UIImage yh_imageNamed:[@"InfoResource.bundle" stringByAppendingPathComponent:picName]]

//1像素线宽的宏。
#define KSINGLELINE_WIDTH  1.0f/([UIScreen mainScreen].scale)

#define FONT_SYSTEM                     @"Helvetica"


//----------------------颜色相关----------------------------
#define COLOR_DARKBLACK     [ToolHelper colorWithHexString:@"#000000"]//000000（大标题黑）
#define COLOR_BLUE          [ToolHelper colorWithHexString:@"#368DE7"]//368DE7（主色）
#define COLOR_RED           [ToolHelper colorWithHexString:@"#E84342"]//E84342（涨）
#define COLOR_YELLOW        [ToolHelper colorWithHexString:@"#F2AD27"]//F2AD27（按钮）
#define COLOR_DARKGREY      [ToolHelper colorWithHexString:@"#4A4A4A"]//4A4A4A（小文字灰）
#define COLOR_LINE          [ToolHelper colorWithHexString:@"#C7C7C7"]//C7C7C7（线灰）
#define COLOR_LIGHTGRAY     [ToolHelper colorWithHexString:@"#999999"]//999999（时间／简介灰）
#define COLOR_BACK          [ToolHelper colorWithHexString:@"#f0f0f0"]//F0F0F0（底色灰）
#define COLOR_WHITE         [ToolHelper colorWithHexString:@"#ffffff"]//FFFFFF (白色)
#define COLOR_DESCRIPTION   [ToolHelper colorWithHexString:@"#cccccc"]//cccccc (描述灰)

#define uWeakSelf typeof(self) __weak weakSelf = self;
#define uStrongSelf typeof(self) __block strongSelf = self;

#define kString_Format(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

#ifdef DEBUG
#define P_Log(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__]);
#else
#define P_Log(...);
#endif

//主题取色用
#define TXSakuraColor(color) [TXSakuraManager tx_colorWithPath:color]

#define AssignmentStr(str)       [ToolHelper isBlankString:str] ? @"--" : str
#define AssignmentEmptyStr(str)  [ToolHelper isBlankString:str] ? @"" : str
//判断字典
#define AssignmentDic(obj1,obj2)    [obj1 isKindOfClass:[NSDictionary class]] ? obj1[obj2] : @"";

#define PanGuUserDefault [NSUserDefaults standardUserDefaults]


#endif /* PanGu_ConfigBase_Bms_h */
