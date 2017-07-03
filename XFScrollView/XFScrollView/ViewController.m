//
//  ViewController.m
//  XFScrollView
//
//  Created by yang on 17/6/30.
//  Copyright © 2017年 xinfu. All rights reserved.
//

#import "ViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg"];
    [self.view addSubview:self.scrollView];
    [self addImageToImageView];
}

- (void)scrollViewChangeImage {
    
    if (self.pageControl.currentPage < self.pageControl.numberOfPages-1) {
        self.pageControl.currentPage ++;
    }else if(self.pageControl.currentPage == self.pageControl.numberOfPages-1){
        self.pageControl.currentPage = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(WIDTH*(self.pageControl.currentPage+1), 0) animated:YES];
}

- (void)addImageToImageView {
    [self.scrollView setContentSize:CGSizeMake((self.imageArray.count+2)*WIDTH, self.view.frame.size.height*0.5)];
    [self.scrollView setContentOffset:CGPointMake(WIDTH, 0)];
    for (int i = 0; i < self.imageArray.count+2; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, self.scrollView.frame.size.height)];
        if (i == 0) {
            imgView.image = [UIImage imageNamed:[self.imageArray lastObject]];
        }else if(i == self.imageArray.count+1){
            imgView.image = [UIImage imageNamed:[self.imageArray firstObject]];
        }else {
            imgView.image = [UIImage imageNamed:self.imageArray[i-1]];
        }
        [self.scrollView addSubview:imgView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor greenColor];
        [imgView addSubview:label];
    }
    [self.view addSubview:self.pageControl];
    //使用这个timer不需要手动去启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewChangeImage) userInfo:nil repeats:YES];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.2, WIDTH, self.view.frame.size.height*0.5)];
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH*0.2, self.view.frame.size.height*0.7-20, WIDTH*0.6, 20)];
        _pageControl.backgroundColor = [UIColor redColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];//圆点的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];//当前圆点的颜色
    }
    return _pageControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//scrollView正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.timer invalidate];
//    self.timer = nil;
}
// 将要结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}
//已经结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (self.timer == nil) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollViewChangeImage) userInfo:nil repeats:YES];
//    }
}
//将开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {

}
//减速完成，视图停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.imageArray.count <= 1) {
        return;
    }
    
    if (scrollView.contentOffset.x <= 0.0) {
        [scrollView setContentOffset:CGPointMake(WIDTH*self.imageArray.count, 0)];
    }
    if (scrollView.contentOffset.x >= self.scrollView.contentSize.width-WIDTH){
        [scrollView setContentOffset:CGPointMake(WIDTH, 0)];
    }
    self.pageControl.currentPage = (scrollView.contentOffset.x-WIDTH)/WIDTH;
}
//滚动动画已经停止执行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

}
//设置放大缩小的视图，是UIScrollView的Subview
- ( UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}
//视图将要开始放大或缩小
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {

}
//scrollView正在放大或缩小
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}
//视图完成放大或缩小
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {

}
//轻点状态栏，滚动视图会一直滚动到顶部，那是默认行为YES，你可以通过该方法返回NO来关闭它
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}
//视图已经滚动到顶部调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {

}

@end
