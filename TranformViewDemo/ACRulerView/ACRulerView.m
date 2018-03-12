//
//  ACRulerView.m
//  TranformViewDemo
//
//  Created by NicoLin on 2018/3/9.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACRulerView.h"
#import "ACRulerShowView.h"
#import "ACRulerScrollView.h"

@interface ACRulerView()
@property (nonatomic,strong)UILabel *degreeLabel;
@property (nonatomic,strong)ACRulerShowView * rulerShowView;
@property (nonatomic,strong)UIView      *currentPointView;
@property (nonatomic,weak)id <ACRulerViewRotateDelegate> delegate;
@end

@implementation ACRulerView

- (instancetype)initWithFrame:(CGRect)frame target:(id<ACRulerViewRotateDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {

        self.delegate = delegate;
        [self addSubview:self.degreeLabel];
        [self addSubview:self.rulerShowView];
        [self addSubview:self.currentPointView];
    }
    return self;
}


- (void)layoutSubviews {
    
    self.degreeLabel.center = CGPointMake(self.bounds.size.width/2.0f, self.degreeLabel.center.y);
    self.rulerShowView.frame = CGRectMake(0, CGRectGetMaxY(self.degreeLabel.frame), self.bounds.size.width, self.bounds.size.height - 36);
    self.currentPointView.frame = CGRectMake(0, CGRectGetMaxY(self.rulerShowView.frame)+10, 6, 6);
    self.currentPointView.center = CGPointMake(self.bounds.size.width/2.0f, self.currentPointView.center.y);
    
}

- (UILabel*)degreeLabel {
    if (!_degreeLabel) {
        _degreeLabel = [UILabel new];
        _degreeLabel.frame = CGRectMake(0, 0, 100, 20);
        _degreeLabel.textAlignment = NSTextAlignmentCenter;
        _degreeLabel.textColor = [UIColor whiteColor];
        
    }
    return _degreeLabel;
}

- (ACRulerShowView*)rulerShowView {
    if (!_rulerShowView) {
        __weak typeof(self) weakSelf = self;
        _rulerShowView = [[ACRulerShowView alloc] init];
        _rulerShowView.rulerScrollView.degreeChangeBlock = ^(int degree) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(rulerViewRotateWithDegree:)]) {
                weakSelf.degreeLabel.text = [[NSString stringWithFormat:@"%d",degree] stringByAppendingString:@"°"];
                [weakSelf.delegate rulerViewRotateWithDegree:degree];
            }
        };
    }
    return _rulerShowView;
}
- (UIView*)currentPointView {
    if (!_currentPointView) {
        _currentPointView = [UIView new];
        _currentPointView.backgroundColor = [UIColor redColor];
        _currentPointView.layer.cornerRadius = 3.0f;
        _currentPointView.layer.masksToBounds = YES;
    }
    return _currentPointView;
}

- (void)reloadData {
    [self layoutIfNeeded];
    ACRulerScrollView * scrollView = (ACRulerScrollView*)self.rulerShowView.rulerScrollView;
    [scrollView drawRulerLineWithCount:[self.delegate rulerCount] signaleDegreeCount:[self.delegate rulerSignalDegreeCount]];
    [self.rulerShowView drawClearLayer];
}

- (void)reSet {
    [self.rulerShowView.rulerScrollView reSetOffSet];
}
@end
