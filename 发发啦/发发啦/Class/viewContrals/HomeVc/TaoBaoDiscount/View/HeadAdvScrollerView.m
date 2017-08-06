//
//  HeadAdvScrollerView.m
//  TCN三屏复用
//
//  Created by macos on 2017/8/6.
//  Copyright © 2017年 macos. All rights reserved.
//

#import "HeadAdvScrollerView.h"

#define Screen_H [UIScreen mainScreen].bounds.size.height
#define Screen_W [UIScreen mainScreen].bounds.size.width

@interface HeadAdvScrollerView()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)UIImageView * firstImageView;
@property (nonatomic,strong)UIImageView * middleImageView;
@property (nonatomic,strong)UIImageView * thirdImageView;

@property (nonatomic,strong)NSMutableArray * imageViewArr;

@property (nonatomic,strong)NSTimer * timer;

@property (nonatomic,assign)NSInteger pageNumber_0;
@property (nonatomic,assign)NSInteger pageNumber_1;
@property (nonatomic,assign)NSInteger pageNumber_2;

@property (nonatomic,strong)UIPageControl * pageControl;

@property (nonatomic,assign)NSInteger lastPage;
@end

@implementation HeadAdvScrollerView



- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[ UIColor whiteColor];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    self.pageNumber_0 = 0;
    self.pageNumber_1 = 1;
    self.pageNumber_2 = 2;
    self.lastPage = 1;
    
    [self addSubview:self.scrollView];

    [self addSubview:self.pageControl];
    
    [self scrollerViewAddImageView];
    
    [self setScrollViewContOffSetCenter];
    
    
    [self addTimer];
}


#pragma mark- 改变scrollView位置-刷新图片
- (void)reFreshImageViewImageAndChangeScrollViewContOffSet{
    
    NSInteger currentPage = self.scrollView.contentOffset.x/Screen_W;
    CGFloat currentOffset = self.scrollView.contentOffset.x;
    
    NSLog(@"%ld------",currentPage);
    
    if (self.lastPage == currentPage) {
        
        return;
    }
    
    
    NSInteger imageCount = self.imageArr.count;
    
       //向右滑动
    if (currentOffset > Screen_W) {
        
        self.pageNumber_1 = (self.pageNumber_1 + 1) % imageCount;
    
    }else if(currentOffset < Screen_W){
        
        self.pageNumber_1 = (self.pageNumber_1 + imageCount - 1)%imageCount;
    }
    
    
    self.pageNumber_0 = (self.pageNumber_1 + imageCount - 1)%imageCount;
    self.pageNumber_2 = (self.pageNumber_1 + 1)%imageCount;
    
    self.lastPage = 1;

    self.firstImageView.image = self.imageArr[self.pageNumber_0];
    self.middleImageView.image = self.imageArr[self.pageNumber_1];
    self.thirdImageView.image = self.imageArr[self.pageNumber_2];
    
    [self setScrollViewContOffSetCenter];
    
    self.pageControl.currentPage = self.pageNumber_1;
}

//scrollView中心
- (void)setScrollViewContOffSetCenter{
    
    if (self.imageArr.count > 1) {
    
        self.scrollView.contentOffset = CGPointMake(Screen_W, 0);
    }
}


#pragma maek- scrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self reFreshImageViewImageAndChangeScrollViewContOffSet];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    [self reFreshImageViewImageAndChangeScrollViewContOffSet];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self addTimer];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self stopTimer];
}



//============================
- (void)addImageViewToArray{


    NSInteger imageCount = self.imageArr.count;
    
    if (imageCount ==1) {
        
        self.imageViewArr = [NSMutableArray arrayWithArray:@[self.firstImageView]];
        
    }else if (imageCount > 1){
    
        self.imageViewArr = [NSMutableArray arrayWithArray:@[self.firstImageView,self.middleImageView,self.thirdImageView]];

    }
    
    
    if (self.imageArr.count ==2) {
        
        self.firstImageView.image = self.imageArr[0];
        self.middleImageView.image = self.imageArr[1];
        self.thirdImageView.image = self.imageArr[0];
        
    }else{
    
        for (int i = 0 ;i  < self.imageViewArr.count ; i++) {
        
            UIImageView * imageView = self.imageViewArr[i];
            imageView.image = self.imageArr[i];
        }
    }

}



- (void)scrollerViewAddImageView{

    [self addImageViewToArray];
    
    for (UIImageView * imageView in self.imageViewArr) {
        
        [self.scrollView addSubview:imageView];
    }

   
}



- (UIPageControl *)pageControl{

    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, Screen_W - 20, Screen_W, 20)];
        _pageControl.currentPage = 1;
        
        _pageControl.numberOfPages = self.imageArr.count;
    }
    return _pageControl;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_W)];
        
        NSInteger count = 0;
        
        if (self.imageArr.count == 1) {
            count = 1;
            
        }else if (self.imageArr.count > 1){
            count = 3;
        
        }
        _scrollView.contentSize = CGSizeMake(Screen_W * count, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)firstImageView{

    if (!_firstImageView) {
        
        _firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_W)];
    }
    return _firstImageView;
}

- (UIImageView *)middleImageView{
    if (!_middleImageView) {
        
        _middleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_W, 0, Screen_W, Screen_W)];
    }
    return _middleImageView;
}


- (UIImageView *)thirdImageView{

    if (!_thirdImageView) {
        
        _thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_W *2, 0, Screen_W, Screen_W)];
    }
    return _thirdImageView;
}



- (void)addTimer{

    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerRepeatAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}


#pragma mark- 响应定时器调用的方法
- (void)timerRepeatAction{

    [self.scrollView setContentOffset:CGPointMake(Screen_W * 2, 0) animated:YES];
}


- (void)stopTimer{

    [self.timer invalidate];
    self.timer = nil;
}






@end
