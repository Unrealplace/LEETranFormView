//
//  ACTranformButton.h
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACTranformButton;

@protocol ACTranformButtonMovDelegate<NSObject>

@required

- (void)touchMovButton:(ACTranformButton*)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point;

- (void)touchEndButton:(ACTranformButton *)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point;

@end

@interface ACTranformButton : UIButton

@property (nonatomic,weak)id <ACTranformButtonMovDelegate> delegate ;


@end
