//
//  ACRulerScrollView.m
//  TranformViewDemo
//
//  Created by NicoLin on 2018/3/9.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACRulerScrollView.h"

#define DISTANCE_TOP_BOTTOM  10.0f
#define DISTANCE_OFFSET 30.0f

@interface ACRulerScrollView ()

@property (nonatomic,assign)int sinaleDegreeCount;
@property (nonatomic,assign)int centerCount;

@end

@implementation ACRulerScrollView

- (void)drawRulerLineWithCount:(int)degreeCount signaleDegreeCount:(int)signalDegreeCount{

    int rulerCount = [self getRulerCountWithDegreeCount:degreeCount siganlDegreeCount:signalDegreeCount];
    int centerCount = rulerCount / 2;
    self.centerCount = centerCount;
    self.sinaleDegreeCount = signalDegreeCount;
    
    for (int i = 0; i < rulerCount; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.tag = i+100;
        if (i == centerCount) {
            lineView.frame = CGRectMake(DISTANCE_OFFSET * i - 0.5, DISTANCE_TOP_BOTTOM+2, 2, self.bounds.size.height - (DISTANCE_TOP_BOTTOM+2)*2);
            lineView.backgroundColor = [UIColor blueColor];
        }else {
            lineView.frame = CGRectMake(DISTANCE_OFFSET * i, DISTANCE_TOP_BOTTOM, 1, self.bounds.size.height - DISTANCE_TOP_BOTTOM*2);
            lineView.backgroundColor = [UIColor whiteColor];
        }
        [self addSubview:lineView];
        self.contentSize = CGSizeMake(CGRectGetMaxX(lineView.frame), self.bounds.size.height);
    }
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, self.bounds.size.width / 2.f , 0, self.bounds.size.width / 2.f);
    self.contentInset = edge;
    self.contentOffset = CGPointMake(centerCount * DISTANCE_OFFSET - self.bounds.size.width/2.0f, 0);

}

- (void)changeOffsetWith:(CGPoint)offset {
//    NSLog(@"%@---%f",NSStringFromCGPoint(offset),offset.x - (self.centerCount * DISTANCE_OFFSET - self.bounds.size.width/2.0f));
    float newOffset = offset.x - (self.centerCount * DISTANCE_OFFSET - self.bounds.size.width/2.0f);
    float signal_offset =  newOffset/DISTANCE_OFFSET;
    int degree = signal_offset * self.sinaleDegreeCount;
    if (self.degreeChangeBlock) {
        self.degreeChangeBlock(degree);
    }
    
}

/**
 获取所有的刻度

 @param degreeCount 最大刻度范围
 @param signalDegreeCoutnt 单元刻度值
 @return 共有多少刻度
 */
- (int)getRulerCountWithDegreeCount:(int)degreeCount siganlDegreeCount:(int)signalDegreeCoutnt {
    
    return (degreeCount / signalDegreeCoutnt)+1;
}

/**
 重置偏移到0 刻度
 */
- (void)reSetOffSet {
    self.contentOffset = CGPointMake(self.centerCount * DISTANCE_OFFSET - self.bounds.size.width/2.0f, 0);
}



@end
