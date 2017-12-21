//
//  ACTranformViewManager.m
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACTranformViewManager.h"
#import "ACTranformView.h"
#import "ACTranformPoint.h"

@interface ACTranformViewManager ()<ACTranformViewMovDelegate>
@property (nonatomic,strong)ACTranformView * currentView;
@end

@implementation ACTranformViewManager

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
    
}
- (void)creatTranFormViewWithPoints:(NSArray<ACTranformPoint *> *)points {
    
    ACTranformView * tranformView = [[ACTranformView alloc] initWithFrame:self.bounds andPoints:points];
    tranformView.delegate = self;
    self.currentView = tranformView;
    [self addSubview:tranformView];
    
}

- (void)tranFormViewMovingWithView:(ACTranformView*)tranformView andPoints:(ACRectVetrex)vertex {
    
}
- (void)tranFormViewStopWithView:(ACTranformView*)tranformView andPoints:(ACRectVetrex)vertex {
    
}
 
@end
