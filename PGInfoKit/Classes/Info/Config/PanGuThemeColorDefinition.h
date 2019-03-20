//
//  PanGuThemeColorDefinition.h
//  PanGu
//
//  Created by guanqiang on 2018/5/24.
//  Copyright © 2018年 Security Pacific Corporation. All rights reserved.
//

#ifndef PanGuThemeColorDefinition_h
#define PanGuThemeColorDefinition_h

#pragma mark =========== ********* 公用颜色 ******** ===========

// H5头部导航
static NSString *const CommonNavHtmlTextColor = @"color.common.navigationhtml5.text";//H5专用标题文字
static NSString *const CommonNavHtmlBackColor = @"color.common.navigationhtml5.back";//H5专用标题背景

// 功能切换导航
static NSString *const CommonPageLabelUnTextColor1 = @"color.common.pagelabelnav.pagelabelnav1.unseltext";//未选中文字1
static NSString *const CommonPageLabelTextColor1 = @"color.common.pagelabelnav.pagelabelnav1.seltext";//已选中文字1
static NSString *const CommonPageLabelLineColor1 = @"color.common.pagelabelnav.pagelabelnav1.line";//文字选中下划线1
static NSString *const CommonPageLabelBackColor1 = @"color.common.pagelabelnav.pagelabelnav1.back";//背景1
static NSString *const CommonPageLabelUnTextColor2 = @"color.common.pagelabelnav.pagelabelnav2.unseltext";//未选中文字2
static NSString *const CommonPageLabelTextColor2 = @"color.common.pagelabelnav.pagelabelnav2.seltext";//已选中文字2
static NSString *const CommonPageLabelLineColor2 = @"color.common.pagelabelnav.pagelabelnav2.line";//文字选中下划线2
static NSString *const CommonPageLabelBackColor2 = @"color.common.pagelabelnav.pagelabelnav2.back";//背景2

// 分割
static NSString *const CommonSpaceLineNavColor = @"color.common.separationline.navshadow";//顶部分割线
static NSString *const CommonSpaceLineBarColor = @"color.common.separationline.barshadow";//底部分割线
static NSString *const CommonSpaceLineFullColor = @"color.common.separationline.fullscreen";//满屏分割线
static NSString *const CommonSpaceLineUnfullColor = @"color.common.separationline.unfullscreen";//非满屏分割线
static NSString *const CommonSpaceLineVerticalColor = @"color.common.separationline.verticalline";//竖条分割线
static NSString *const CommonSpaceLineBorderColor = @"color.common.separationline.border";//边框分割线

// 列表
static NSString *const CommonListContentTextColor = @"color.common.list.contenttext";//列表内容文字
static NSString *const CommonListContentRemarkTextColor = @"color.common.list.remarktext";//内容备注文字
static NSString *const CommonListContentContentBackColor = @"color.common.list.contentback";//内容背景
static NSString *const CommonListContentUnTitleColor = @"color.common.list.titleunenabletext";//数据标题不可点击文字
static NSString *const CommonListContentTitleColor = @"color.common.list.titleenabletext";//数据标题可点击文字
static NSString *const CommonListContentBackColor = @"color.common.list.back";//数据标题背景

// 业务色
static NSString *const CommonBusinessRiseColor = @"color.common.business.rise";//涨
static NSString *const CommonBusinessFlatColor = @"color.common.business.flat";//平
static NSString *const CommonBusinessFallColor = @"color.common.business.fall";//跌

// 全局
static NSString *const CommonGlobalIconTextColor        = @"color.common.global.icontext";//图标字
static NSString *const CommonGlobalTextColor            = @"color.common.global.text";//缺省主文字
static NSString *const CommonGlobalRemarkTextColor      = @"color.common.global.remarktext";//缺省备注文字
static NSString *const CommonGlobalLinkTextColor        = @"color.common.global.linktext";//链接文字
static NSString *const CommonGlobalBackColor            = @"color.common.global.back";//背景
static NSString *const CommonGlobalTargetTextColor      = @"color.common.global.targetLabel";// 全局指标值颜色  白色/金色
static NSString *const CommonGlobalWhiteColor           = @"color.common.global.whiteLabel";// 全局 白色/白色
static NSString *const CommonGlobaLindicatorStyleColor  = @"color.common.global.indicatorStyle";// 菊花颜色

// 功能块
static NSString *const CommonFuncBlockTextColor = @"color.common.funcblock.text";//功能块标题文字
static NSString *const CommonFuncBlockTitleBackColor = @"color.common.funcblock.titleback";//功能块标题背景
static NSString *const CommonFuncBlockContentBackColor = @"color.common.funcblock.contentback";//内容背景

// 主功能底部导航(TabBar)
static NSString *const CommonTabBarUnSelTextColor = @"color.common.tabbar.unseltext";//未选中文字
static NSString *const CommonTabBarSelTextColor = @"color.common.tabbar.seltext";//已选中文字
static NSString *const CommonTabBarBackColor = @"color.common.tabbar.back";//背景

// 下拉菜单
static NSString *const CommonPullTextColor = @"color.common.pull.text";//文字
static NSString *const CommonPullBackColor = @"color.common.pull.back";//背景

// 吐司提示
static NSString *const CommonToastTextColor = @"color.common.toast.text";//文字
static NSString *const CommonToastBackColor = @"color.common.toast.back";//背景

// 可操作提示框
static NSString *const CommonAlertMaskColor = @"color.common.alert.mask";//遮罩层
static NSString *const CommonAlertBackColor = @"color.common.alert.back";//提示框背景
static NSString *const CommonAlertTitleColor = @"color.common.alert.title";//标题文字

// 按钮
static NSString *const CommonButtonSearchTextColor = @"color.common.button.search.text";//搜索按钮文字颜色
static NSString *const CommonButtonSearchBackColor = @"color.common.button.search.back";//搜索按钮背景颜色
static NSString *const CommonButtonSearchWidth = @"color.common.button.search.width";//搜索按钮宽度
static NSString *const CommonButtonSearchHeight = @"color.common.button.search.height";//搜索按钮高度

static NSString *const CommonButtonEnableTextColor = @"color.common.button.enabletext";//可用按钮文字
static NSString *const CommonButtonEnableBackColor = @"color.common.button.enableback";//可用按钮背景
static NSString *const CommonButtonAlertUnTextColor = @"color.common.button.alertunenabletext";//提示框禁用按钮文字
static NSString *const CommonButtonAlertUnBackColor = @"color.common.button.alertback";//提示框禁用按钮背景
static NSString *const CommonButtonUnTextColor = @"color.common.button.unenabletext";//页面禁用按钮文字
static NSString *const CommonButtonUnBackColor = @"color.common.button.unenableback";//页面禁用按钮背景

static NSString *const CommonButtonCancelTextColor = @"color.common.button.canceltext";//取消按钮文字
static NSString *const CommonButtonCancelBackColor = @"color.common.button.cancelback";//取消按钮背景

// 刷新
static NSString *const CommonRefreshTextColor = @"color.common.refreshtext";//下拉刷新文字

// 极端状态
static NSString *const CommonUnsualTextColor = @"color.unusual.text";//三无文字
static NSString *const CommonUnsualToastTextColor = @"color.unusual.toasttext";//断网文字
static NSString *const CommonUnsualToastBackColor = @"color.unusual.toastback";//断网背景

// 双列信息功能块
static NSString *const CommonDoubleListTitleColor = @"color.common.doublelist.title";//内容信息标题
static NSString *const CommonDoubleListContentColor = @"color.common.doublelist.content";//内容文字

// 文章详情
static NSString *const CommonContentTitleColor = @"color.common.content.title";//文章标题
static NSString *const CommonContentDetailColor = @"color.common.content.detail";//文章内容
static NSString *const CommonContentRemarkColor = @"color.common.content.remark";//文章备注文字
static NSString *const CommonContentBackColor = @"color.common.content.back";//背景色
static NSString *const CommonContentContentBackColor = @"color.common.content.contentback";//内容背景
static NSString *const CommonContentContentTextColor = @"color.common.content.contenttext";//内容文字


// 功能列表1
static NSString *const CommonFuncListOneTextColor = @"color.common.funclist1.text";//文字
static NSString *const CommonFuncListOneBackColor = @"color.common.funclist1.back";//背景

// 功能列表2
static NSString *const CommonFuncListTwoTextColor = @"color.common.funclist2.text";//主文字
static NSString *const CommonFuncListTwoRemarkColor = @"color.common.funclist2.remark";//备注
static NSString *const CommonFuncListTwoBackColor = @"color.common.funclist2.back";//背景

// 输入框
static NSString *const CommonTextFieldPlaceholderColor = @"color.common.textfield.placeholder";//占位文字
static NSString *const CommonTextFieldTitleColor = @"color.common.textfield.title";//标题文字
static NSString *const CommonTextFieldContentColor = @"color.common.textfield.content";//输入文字
static NSString *const CommonTextFieldBackColor = @"color.common.textfield.back";//背景

// 头部导航（除交易模块外）
static NSString *const CommonNavigationTitleColor = @"color.common.navigation.title";//主标题文字
static NSString *const CommonNavigationSubtitleColor = @"color.common.navigation.subtitle";//副标题文字
static NSString *const CommonNavigationUnSelTextColor = @"color.common.navigation.unseltext";//未选中文字
static NSString *const CommonNavigationSelTextColor = @"color.common.navigation.seltext";//已选中文字
static NSString *const CommonNavigationBackColor = @"color.common.navigation.back";//背景
static NSString *const CommonNavbarTitleColor =
    @"color.common.navBarTitleColor";
//状态栏
static NSString *const CommonWhiteStatusBarStyle = @"color.common.whiteStatusBar.style";//白色状态栏
static NSString *const CommonBlackStatusBarStyle = @"color.common.blackStatusBar.style";//黑色状态栏


#pragma mark =========== ********* 首页特殊颜色 ******** ===========
static NSString *const HomeSudokuUsedBackColor = @"color.home.sudoku.usedBackColor";//九宫格最近使用cell背景颜色
static NSString *const HomeSudokuBackColor = @"color.home.sudoku.backColor"; //九宫格全部cell背景颜色

#pragma mark =========== ********* 行情特殊颜色 ******** ===========
//搜索页面顶部视图
static NSString *const MarketSearchPageTopViewBackColor =
    @"color.market.searchPageTopView.back";//背景
static NSString *const MarketSearchPageTopViewTitleColor =
    @"color.market.searchPageTopView.title";//文字颜色

static NSString *const MarketSearchNavigationBackColor = @"color.market.searchNavigation.back";//搜索导航背景
static NSString *const MarketListBackColor = @"color.market.common.listback";//行情列表背景

// 底部菜单
static NSString *const MarketToolBarTextColor = @"color.market.toolbar.text";//文字
static NSString *const MarketToolBarBackColor = @"color.market.toolbar.back";//背景

// 个股波浪颜色
static NSString *const MarketDetailWaveRiseColor = @"color.market.detail.wave.rise";// 涨
static NSString *const MarketDetailWaveFlatColor = @"color.market.detail.wave.flat";// 平
static NSString *const MarketDetailWaveFallColor = @"color.market.detail.wave.fall";// 跌
static NSString *const MarketDetailTransparencyRiseColor = @"color.market.detail.wave.transparencyRise";// 波浪透明度
static NSString *const MarketDetailTransparencyFlatColor = @"color.market.detail.wave.transparencyFlat";// 波浪透明度
static NSString *const MarketDetailTransparencyFallColor = @"color.market.detail.wave.transparencyFall";// 波浪透明度

// 个股价格颜色
static NSString *const MarketDetailTextRiseColor = @"color.market.detail.text.rise";// 涨
static NSString *const MarketDetailTextFlatColor = @"color.market.detail.text.flat";// 平
static NSString *const MarketDetailTextFallColor = @"color.market.detail.text.fall";// 跌

#pragma mark =========== ********* 交易特殊颜色 ******** ===========

// 下拉列表
static NSString *const TradePullListBackColor = @"color.trade.pulllist.back";//内容背景色
static NSString *const TradePullListSeparationColor = @"color.trade.pulllist.separation";//分割条
static NSString *const TradePullListFoldColor = @"color.trade.pulllist.fold";//收起条

// 普通持仓头部持仓盈亏颜色
static NSString *const TradePositionGainLossRiseColor = @"color.trade.position.gainloss.rise";//涨
static NSString *const TradePositionGainLossFlatColor = @"color.trade.position.gainloss.flat";//平
static NSString *const TradePositionGainLossFallColor = @"color.trade.position.gainloss.fall";//跌

// 银证转账渐变背景
static NSString *const TradeGradientColorFirst = @"color.trade.gradientColor.first";
static NSString *const TradeGradientColorSecond = @"color.trade.gradientColor.second";

// 网络投票按钮默认颜色
static NSString *const TradeVoteButtonDefultColor = @"color.trade.vote.buttonDefult";

// 普通交易首页渐变颜色
static NSString *const TradeHomeNormalGradientColorFirst = @"color.trade.normalGradientColor.first";
static NSString *const TradeHomeNormalGradientColorSecond = @"color.trade.normalGradientColor.second";

// 信用交易首页渐变颜色
static NSString *const TradeHomeCreditGradientColorFirst = @"color.trade.creditGradientColor.first";
static NSString *const TradeHomeCreditGradientColorSecond = @"color.trade.creditGradientColor.second";

static NSString *const TradeRemarkTextColor = @"color.trade.remarkText";// 白色/灰色(999999)
static NSString *const TradeHomeRemarkTextColor = @"color.trade.homeRemarkText";// 白色/灰色(dcdcdc)

static NSString *const TradeBuySellLimitOrderUnBackColor = @"color.trade.buysell.limitorder.unback";//限价委托禁用按钮背景
static NSString *const TradeBuySellLimitOrderBackColor = @"color.trade.buysell.limitorder.back";//限价委托按钮背景

// 开放式基金 -- 基金份额 -- 涨跌平
static NSString *const TradeFundShareBusinessRiseColor = @"color.trade.fundshare.rise";//涨
static NSString *const TradeFundShareBusinessFlatColor = @"color.trade.fundshare.flat";//平
static NSString *const TradeFundShareBusinessFallColor = @"color.trade.fundshare.fall";//跌

#pragma mark =========== ********* 理财特殊颜色 ******** ===========

static NSString *const MallListHyperlinksTextColor      = @"color.mall.listHyperlinks";// 理财模块列表文字可点击颜色  蓝色/金色
static NSString *const MallBusinessTextRiseColor        = @"color.mall.businessRise";// 理财模块业务色 涨   红色/金色
static NSString *const MallBusinessTextFlatColor        = @"color.mall.businessFlat";// 理财模块业务色 平   绿色/金色
static NSString *const MallBusinessTextFallColor        = @"color.mall.businessFall";// 理财模块业务色 跌   灰色/金色
static NSString *const MallHomeNavBackColor             = @"color.mall.homeNav";// 理财模块首页导航背景颜色  红色/黑色
static NSString *const MallHotSearchTextBackColor       = @"color.mall.hotSearch";// 理财模块搜索热搜按钮背景颜色  浅灰/深灰
static NSString *const MallSearchBackColor              = @"color.mall.searchBack";// 理财模块搜索框背景颜色  浅灰/深灰, 有透明度
static NSString *const MallHomeSearchBackColor          = @"color.mall.homeSearchBack";// 理财模块首页搜索框背景颜色  浅灰/深灰, 有透明度
static NSString *const MallLineChartFillColor           = @"color.mall.lineChartFillColor";//理财模块详情折线图填充颜色
static NSString *const MallHomeStatementBackColor       = @"color.mall.homeStatement";// 理财首页底部免责声明

#pragma mark =========== ********* 我的特殊颜色 ******** ===========

static NSString *const MineHomeShadowColor              = @"color.mine.home.shadowColor";//我的首页阴影

static NSString *const MineMsgShadowColor               = @"color.mine.msg.shadowColor";//我的消息阴影
static NSString *const MineMsgMaskColor                 = @"color.mine.msg.maskColor";//我的消息蒙版
static NSString *const MineMsgDateTextColor             = @"color.mine.msg.dateTextColor";//我的消息蒙版
static NSString *const MineMsgBubbleTextColor           = @"color.mine.msg.bubbleTextColor";//我的消息蒙版

#pragma mark =========== ********* 首页主页特殊颜色 ******** ===========

#pragma mark =========== ********* 行情主页特殊颜色 ******** ===========

#pragma mark =========== ********* 交易主页特殊颜色 ******** ===========

#pragma mark =========== ********* 我的主页特殊颜色 ******** ===========

#endif /* PanGuThemeColorDefinition_h */

