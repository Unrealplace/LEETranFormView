//
//  ACRulerScrollView.h
//  TranformViewDemo
//
//  Created by NicoLin on 2018/3/9.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ACScrollViewDegreeChangeBlock)(int degree);

@interface ACRulerScrollView : UIScrollView

- (void)drawRulerLineWithCount:(int)degreeCount signaleDegreeCount:(int)signalDegreeCount;
- (void)reSetOffSet ;
- (void)changeOffsetWith:(CGPoint)offset;

@property (nonatomic,copy)ACScrollViewDegreeChangeBlock degreeChangeBlock;

@end
