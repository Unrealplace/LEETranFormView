//
//  ACRulerShowView.h
//  TranformViewDemo
//
//  Created by NicoLin on 2018/3/9.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACRulerScrollView;

@interface ACRulerShowView : UIView

@property (nonatomic,strong)ACRulerScrollView *rulerScrollView;

- (void)drawClearLayer ;

@end
