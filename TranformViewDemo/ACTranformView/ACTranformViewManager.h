//
//  ACTranformViewManager.h
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
// 回调的点的坐标
typedef struct ACRectVetrex {
    CGPoint L_T;
    CGPoint R_T;
    CGPoint L_B;
    CGPoint R_B;
} ACRectVetrex;

@class ACTranformViewManager;
@class ACTranformView;
@class ACTranformPoint;

@protocol ACTranformViewmanagerTouchDelegate <NSObject>

- (void)touchMovWith:(ACTranformViewManager*)viewManager andAllPoints:(ACRectVetrex)vexterx;

- (void)touchEndWith:(ACTranformViewManager *)viewManager andAllPoints:(ACRectVetrex)vexterx;

@end

@interface ACTranformViewManager : UIView

@property (nonatomic,weak)id <ACTranformViewmanagerTouchDelegate> delegate ;


/**
  持有的 转换视图
 */
@property (nonatomic,strong)ACTranformView * currentView;


/**
 初始化变形视图

 @param points 传入要画的坐标点
 */
- (void)creatTranFormViewWithPoints:(NSArray<ACTranformPoint*>*)points;





@end
