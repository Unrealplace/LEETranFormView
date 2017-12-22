//
//  ACTranformViewManager.m
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACTranformViewManager.h"
#import "ACTranformView.h"
 
@interface ACTranformViewManager ()<ACTranformViewMovDelegate>
@end

@implementation ACTranformViewManager

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
    
}

/**
 创建变形视图

 @param points 顶点坐标
 */
- (void)creatTranFormViewWithPoints:(ACMeshVetex)meshVertex {
    
    NSMutableArray * points  = [NSMutableArray array];
    ACTranformPoint * point1 = [[ACTranformPoint alloc] init];
    ACTranformPoint * point2 = [[ACTranformPoint alloc] init];
    ACTranformPoint * point3 = [[ACTranformPoint alloc] init];
    ACTranformPoint * point4 = [[ACTranformPoint alloc] init];
    point1.point             = meshVertex.L_T;
    point2.point             = meshVertex.R_T;
    point3.point             = meshVertex.R_B;
    point4.point             = meshVertex.L_B;
    
    point1.pointId           = 0;
    point2.pointId           = 1;
    point3.pointId           = 2;
    point4.pointId           = 3;
    
    [points addObjectsFromArray:@[point1,point2,point3,point4]];

    ACTranformView * tranformView = [[ACTranformView alloc] initWithFrame:self.bounds andPoints:points];
    tranformView.delegate = self;
    self.currentView = tranformView;
    [self addSubview:tranformView];
    
}

- (void)showTheCenterPoint:(BOOL)isCenterHidden andPointPoint:(BOOL)isPointHidden {
    self.currentView.centerHidden = isCenterHidden;
    self.currentView.pointHidden  = isPointHidden;
}

#pragma mark ACTranformViewMovDelegate 代理方法
- (void)tranFormViewMovingWithView:(ACTranformView*)tranformView andPoints:(ACMeshVetex)vertex {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchMovWithAllPoints:)]) {
        [self.delegate touchMovWithAllPoints:vertex];
    }
    
}
- (void)tranFormViewStopWithView:(ACTranformView*)tranformView andPoints:(ACMeshVetex)vertex {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchEndWithAllPoints:)]) {
        [self.delegate touchEndWithAllPoints:vertex];
    }
    
}
 
@end
