//
//  ACTranformViewManager.h
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTranformPoint.h"

@class ACTranformViewManager;
@class ACTranformView;

@protocol ACTranformViewmanagerTouchDelegate <NSObject>

- (void)touchMovWith:(ACTranformViewManager*)viewManager andAllPoints:(ACRectVetrex)vexterx;

- (void)touchEndWith:(ACTranformViewManager *)viewManager andAllPoints:(ACRectVetrex)vexterx;

@end

@interface ACTranformViewManager : UIView

@property (nonatomic,weak)id <ACTranformViewmanagerTouchDelegate> delegate ;


/**
  持有的 转换视图
 */
@property (nonatomic,strong,readonly)ACTranformView * currentView;


/**
 初始化变形视图

 @param points 传入要画的坐标点
 */
- (void)creatTranFormViewWithPoints:(NSArray<ACTranformPoint*>*)points;

@end
