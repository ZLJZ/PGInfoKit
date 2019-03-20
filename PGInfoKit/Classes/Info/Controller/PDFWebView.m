//
//  PDFWebView.m
//  PanGu
//
//  Created by 王玉 on 2016/12/2.
//  Copyright © 2016年 Security Pacific Corporation. All rights reserved.
//

#import "PDFWebView.h"

@interface PDFWebView ()
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UIProgressView * progress;
@property (nonatomic,strong) UIView * blackView;
@property (nonatomic,copy) NSString * type;

@end

@implementation PDFWebView
- (void)loadFileWithFilePath:(NSString *)path{
    _type = @"dealloc";
    [self createProgressView];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    [self loadRequest:request];
    
    
}
- (void)loadFileWithFileUrlString:(NSString *)path{
    NSURL *url1 = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    [self loadRequest:request];
    
}

- (void)createProgressView{
    _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _blackView.backgroundColor = COLOR_DARKGREY;
    _blackView.alpha = 0.5;
    [self addSubview:_blackView];
    _backView = [[UIView alloc]init];
    _backView.size = CGSizeMake(kScreenWidth - 84, kScreenWidth/3);
    _backView.backgroundColor = COLOR_WHITE;
    _backView.center = self.center;
    _backView.layer.cornerRadius = 10;
    _backView.layer.masksToBounds = YES;
    _loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _backView.height/3, _backView.width, 15)];
    _loadLabel.textAlignment = NSTextAlignmentCenter;
    _loadLabel.textColor = COLOR_DARKGREY;
    _loadLabel.font = [UIFont systemFontOfSize:15];
    _loadLabel.text = @"文档已下载100%";
    [_backView addSubview:_loadLabel];
    _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(27, _backView.height/3 * 2, _backView.width - 54, 5)];
    [_backView addSubview:_progress];
    _progress.transform = CGAffineTransformMakeScale(1, 3);
    _progress.layer.cornerRadius = 3;
    _progress.layer.masksToBounds = YES;
    _progress.progressTintColor = COLOR_BLUE;
    [self addSubview:_backView];
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [_progress setProgress:[change[@"new"] floatValue]];
    [_loadLabel setText:[NSString stringWithFormat:@"文档已下载%.0f%%",[change[@"new"] floatValue] * 100]];
    if (self.estimatedProgress >= 1.0f) {
        [UIView animateWithDuration:1 animations:^{
            _backView.alpha = 0;
            _blackView.alpha = 0;
        }];
        
    }else{
        _backView.alpha = 1.0;
        _blackView.alpha = 0.5;
    }
}

- (void)dealloc{
    if ([_type isEqualToString:@"dealloc"]) {
         [self removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}
@end
