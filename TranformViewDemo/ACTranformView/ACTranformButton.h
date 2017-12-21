//
//  ACTranformButton.h
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ACButtonShape) {
    ACButtonShape_Point  = 0,
    ACButtonShape_Center ,
};
@class ACTranformButton;

@protocol ACTranformButtonMovDelegate<NSObject>

@required

- (void)touchMovButton:(ACTranformButton*)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point;

- (void)touchEndButton:(ACTranformButton *)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point;

@end

@interface ACTranformButton : UIButton

@property (nonatomic,weak)id <ACTranformButtonMovDelegate> delegate ;
- (instancetype)initWithFrame:(CGRect)frame andButtonType:(ACButtonShape)buttonType;

@end
