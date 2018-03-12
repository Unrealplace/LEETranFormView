//
//  ACRulerShowView.m
//  TranformViewDemo
//
//  Created by NicoLin on 2018/3/9.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACRulerShowView.h"
#import "ACRulerScrollView.h"

@interface ACRulerShowView()<UIScrollViewDelegate>

@end

@implementation ACRulerShowView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.rulerScrollView];
    }
    return self;
}

- (void)layoutSubviews {
    self.rulerScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (ACRulerScrollView *)rulerScrollView {
    if (!_rulerScrollView) {
        _rulerScrollView = [[ACRulerScrollView alloc] init];
        _rulerScrollView.showsHorizontalScrollIndicator = NO;
        _rulerScrollView.bounces = NO;
        _rulerScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        _rulerScrollView.delegate = self;
        _rulerScrollView.backgroundColor = [UIColor clearColor];
    }
    return _rulerScrollView;
}

//绘制左右渐变
- (void)drawClearLayer {
    // 渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame  = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    gradient.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:1.f].CGColor,
                        (id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor clearColor] colorWithAlphaComponent:1.f].CGColor];
    gradient.locations = @[[NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:0.5f]];
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint = CGPointMake(1, .5);
    [self.layer addSublayer:gradient];
    
}

#pragma mark scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [(ACRulerScrollView*)scrollView changeOffsetWith:scrollView.contentOffset];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [(ACRulerScrollView*)scrollView changeOffsetWith:scrollView.contentOffset];
}


@end
