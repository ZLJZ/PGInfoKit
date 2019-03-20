//
//  PDFWebView.h
//  PanGu
//
//  Created by 王玉 on 2016/12/2.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface PDFWebView : WKWebView

@property (nonatomic,strong) UILabel * loadLabel;
- (void)loadFileWithFilePath:(NSString *)path;
- (void)loadFileWithFileUrlString:(NSString *)path;
@end
