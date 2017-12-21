//
//  ACTranformButton.m
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACTranformButton.h"

@implementation ACTranformButton

- (instancetype)initWithFrame:(CGRect)frame andButtonType:(ACButtonShape)buttonType {
    if (self = [super initWithFrame:frame]) {
        switch (buttonType) {
            case ACButtonShape_Point:{
                [self setBackgroundImage:[UIImage imageNamed:@"tranform_point"] forState:UIControlStateNormal];
            }
                break;
            case ACButtonShape_Center:{
                [self setBackgroundImage:[UIImage imageNamed:@"tranform_rect"] forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}
/**
 回调 按钮 的touch 事件

 @param touches 事件集和
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches.allObjects lastObject];
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchMovButton:withBtnTag:andBtnPoint:)]) {
        [self.delegate touchMovButton:self withBtnTag:self.tag andBtnPoint:[touch locationInView:self.superview]];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches.allObjects lastObject];
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchEndButton:withBtnTag:andBtnPoint:)]) {
        [self.delegate touchEndButton:self withBtnTag:self.tag andBtnPoint:[touch locationInView:self.superview]];
    }
}


@end
