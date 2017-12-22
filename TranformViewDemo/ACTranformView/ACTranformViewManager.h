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

@required

- (void)touchMovWithAllPoints:(ACMeshVetex)vertex;

- (void)touchEndWithAllPoints:(ACMeshVetex)vertex;

@end

@interface ACTranformViewManager : UIView

@property (nonatomic,weak)id <ACTranformViewmanagerTouchDelegate> delegate ;


/**
  持有的 转换视图
 */
@property (nonatomic,strong)ACTranformView * currentView;


/**
 初始化变形视图

 @param meshVertex 传入要画的坐标点
 */
- (void)creatTranFormViewWithPoints:(ACMeshVetex)meshVertex;


/**
 控制中点和顶点的显示 隐藏

 @param isCenterHidden 中点
 @param isPointHidden 顶点
 */
- (void)showTheCenterPoint:(BOOL)isCenterHidden andPointPoint:(BOOL)isPointHidden;

@end
