//
//  ACRulerView.h
//  TranformViewDemo
//
//  Created by NicoLin on 2018/3/9.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACRulerViewRotateDelegate <NSObject>

/**
 微调了角度回调

 @param degree 角度值
 */
- (void)rulerViewRotateWithDegree:(int)degree;

/**
 角度刻度尺的最大量程

 @return 量程值
 */
- (int)rulerCount;


/**
 单位刻度尺的值

 @return 单位值
 */
- (int)rulerSignalDegreeCount;

@end

@interface ACRulerView : UIView

- (instancetype)initWithFrame:(CGRect)frame target:(id<ACRulerViewRotateDelegate>)delegate ;

/**
 刷新数据源
 */
- (void)reloadData;

/**
 重置刻度尺
 */
- (void)reSet;

@end
