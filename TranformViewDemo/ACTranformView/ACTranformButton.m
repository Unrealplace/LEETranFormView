//
//  ACTranformButton.m
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACTranformButton.h"

@implementation ACTranformButton


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
