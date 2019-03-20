//
//  TradePDFController.m
//  PanGu
//
//  Created by 王玉 on 2016/11/9.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "TradePDFController.h"
#import "PDFWebView.h"


@interface TradePDFController ()
{
    WKWebView *wView;
}
@end

@implementation TradePDFController
- (void)viewDidLoad{
    [super viewDidLoad];

    
}

- (void)reloadWithString:(NSString *)url{
    UIScrollView *backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT)];
    [self.view addSubview:backView];
    backView.minimumZoomScale=0.5;//设置最小缩放比例
    backView.maximumZoomScale=2.5;//设置最大的缩放比例
    PDFWebView *pdf = [[PDFWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT)];
    [backView addSubview:pdf];
    
    [pdf loadFileWithFilePath:url];
}

- (void)reloadWithFileName:(NSString *)name{//tpyzqjjkhyy
    UIScrollView *backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT)];
    [self.view addSubview:backView];
    backView.minimumZoomScale=0.5;//设置最小缩放比例
    backView.maximumZoomScale=2.5;//设置最大的缩放比例
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    wView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NAV_HEIGHT) configuration:config];
    [backView addSubview:wView];
    
    NSArray *titleArr = [name componentsSeparatedByString:@"."];
    NSString *PATH = [[NSBundle mainBundle] pathForResource:titleArr[0] ofType:titleArr.count > 1? titleArr[1]:@""];
    NSURL *url = [NSURL fileURLWithPath:PATH];

    if (iOS9orLater) {
        [wView loadFileURL:url allowingReadAccessToURL:url];
    } else {
        NSURL *fileURL = [ToolHelper fileURLForBuggyWKWebView8:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [wView loadRequest:request];
    }
}

@end
