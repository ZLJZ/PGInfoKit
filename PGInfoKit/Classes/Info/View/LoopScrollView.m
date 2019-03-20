 //
//  LoopScrollView.m
//  PanGu
//
//  Created by 张琦 on 2017/7/10.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "LoopScrollView.h"
#import "InfoImportantNewsModel.h"
#import "PGInfo.h"

@interface LoopScrollView()<UIScrollViewDelegate>


@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, strong) UIView *pageView;
@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation LoopScrollView

#pragma mark --- 懒加载数据数组
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void) makeCoreUI:(CGRect)frame
{
    self.coreView = [[UIScrollView alloc]initWithFrame:frame];
    self.coreView.sakura.backgroundColor(CommonListContentContentBackColor);
    self.coreView.showsHorizontalScrollIndicator = NO;
    self.coreView.delegate = self;
    [self addSubview:self.coreView];
}

-(void) makePageUI:(CGRect)frame
{
    
    CGFloat pageViewWidth = 21 * 3 + 3 * 2;
    _pageView = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width - pageViewWidth, frame.size.height - 21, pageViewWidth, 2)];
    [self addSubview:_pageView];
    for(int i = 0;i < 3;i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage getImageWithColor:[ToolHelper colorWithHexString:@"#cacaca"]]];
        imageView.frame = CGRectMake(i * (3 + 21), 0, 21, 2);
        if(i == 0)
        {
            imageView.image = [UIImage getImageWithColor:[ToolHelper colorWithHexString:@"#4796e7"]];
        }
        [_pageView addSubview:imageView];
        
    }
}

-(void) makeTimeLabelUI:(CGRect)frame
{
    //
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 21, 130, 12)];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.sakura.textColor(CommonListContentRemarkTextColor);
    [self addSubview:_dateLabel];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sakura.backgroundColor(CommonListContentContentBackColor);
        [self makeCoreUI:frame];
        [self makePageUI:frame];
        [self makeTimeLabelUI:frame];
    }
    return self;
}

-(void)reloadData
{
    [self.dataArray removeAllObjects];
    NSArray *data = nil;
    if ([self.dataSource respondsToSelector:@selector(loopScroll:)]) {
        data = [self.dataSource loopScroll:self];
    }
    
    if (data == nil) {
        return;
    }
    
    id firstImage = data.firstObject;
    id lastImage = data.lastObject;
    [self.dataArray addObject:lastImage];
    [self.dataArray addObjectsFromArray:data];
    [self.dataArray addObject:firstImage];
    
    [self reloadCoreUI:self.dataArray];
    
}

-(void) reloadCoreUI:(NSMutableArray *)dataArray
{
    if (dataArray.count != 0) {
        
        for (int i = 0; i < dataArray.count; i++) {
            
            CGFloat imageW = self.frame.size.width;
            CGFloat imageH = self.frame.size.height;
            CGFloat imageY = 0;
            CGFloat imageX = i * self.frame.size.width;
            CGRect frame = CGRectMake(imageX, imageY, imageW, imageH);
            
            UIView *realView = [self.dataSource loopScroll:self carouselFrame:frame data:dataArray viewForItemAtIndex:i];
            realView.tag = i + 100;
            [self.coreView addSubview:realView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
            [realView addGestureRecognizer:tap];
            
            
        }
        
        //设置轮播器的滚动范围
        self.coreView.contentSize = CGSizeMake(dataArray.count * self.frame.size.width, 0);
        self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
//        if (self.coreView.contentOffset.x < 0) {
//            self.coreView.contentOffset = CGPointMake(self.bounds.size.width * (self.dataArray.count - 2), 0);
//        }else if (self.coreView.contentOffset.x >= self.bounds.size.width * (self.dataArray.count - 1))
//        {
//            self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
//        }else {
//            self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
//        }
        
        //打开分页功能
        self.coreView.pagingEnabled = YES;
    
        [_timer invalidate];
        _timer = nil;
        //添加定时器
        [self createTimer];
    }
    
}

/*
 *  创建定时器
 */

- (void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_carouseScrollTimeInterval target:self selector:@selector(autoCarouselScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/*
 * 执行定时器方法
 */

- (void)autoCarouselScroll
{
    CGFloat offsetX;
    NSInteger result = (int)self.coreView.contentOffset.x % (int)self.bounds.size.width;
    NSInteger positionNum = (int)self.coreView.contentOffset.x / (int)self.bounds.size.width;
    if (result != 0) {
        offsetX = self.bounds.size.width * positionNum + self.bounds.size.width;
    }else
    {
        offsetX = self.coreView.contentOffset.x + self.bounds.size.width;
    }
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.coreView setContentOffset:offset animated:YES];
    
}

-(void)Tapped:(UIGestureRecognizer *) gesture
{
    
    NSInteger index = gesture.view.tag-101;
    
    if ([self.delegate respondsToSelector:@selector(loopScroll:didSelectItemAtIndex:)]) {
        [self.delegate loopScroll:self didSelectItemAtIndex:index];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int page = (self.coreView.contentOffset.x + self.bounds.size.width * 0.5) / self.bounds.size.width - 1;
    NSInteger selectedPage = 0;
    if (self.coreView.contentOffset.x > self.bounds.size.width * (self.dataArray.count - 1.5)) {
        selectedPage = 0;
    }else if (self.coreView.contentOffset.x < self.bounds.size.width * 0.5)
    {
        selectedPage = self.dataArray.count - 3;
        
    } else {
        selectedPage = page;
    }
    for (NSInteger i = 0; i < _pageView.subviews.count; i ++ ) {
        if (i == selectedPage) {
            UIImageView *imageViewSelected = [_pageView.subviews objectAtIndex:i];
            imageViewSelected.image = [UIImage getImageWithColor:[ToolHelper colorWithHexString:@"#4796e7"]];
        } else {
            UIImageView *imageViewSelected = [_pageView.subviews objectAtIndex:i];
            imageViewSelected.image = [UIImage getImageWithColor:[ToolHelper colorWithHexString:@"#cacaca"]];
        }
    }
    if (self.coreView.contentOffset.x <= 0) {
        self.coreView.contentOffset = CGPointMake(self.bounds.size.width * (self.dataArray.count - 2), 0);
    }else if (self.coreView.contentOffset.x >= self.bounds.size.width * (self.dataArray.count - 1))
    {
        self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    InfoImportantNewsModel *model = _dataArray[selectedPage];
    _dateLabel.text = model.time;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}



@end
