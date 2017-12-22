//
//  ACTranformView.h
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTranformPoint.h"

@class ACTranformView;
@protocol ACTranformViewMovDelegate <NSObject>
@required

- (void)tranFormViewMovingWithView:(ACTranformView*)tranformView andPoints:(ACMeshVetex)vertex;
- (void)tranFormViewStopWithView:(ACTranformView*)tranformView andPoints:(ACMeshVetex)vertex;

@end
@interface ACTranformView : UIView

@property (nonatomic, weak) id <ACTranformViewMovDelegate> delegate ;


@property (nonatomic,assign)BOOL centerHidden;

@property (nonatomic,assign)BOOL pointHidden;


/**
 以定点初始化变形时图

 @param frame 父试图
 @param points 定点数组
 @return 对象
 */
- (instancetype)initWithFrame:(CGRect)frame andPoints:(NSArray<ACTranformPoint*>*)points;



@end
