//
//  ACTranformPoint.h
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ACTranformPoint : NSObject


/**
 当前点的坐标
 */
@property (nonatomic,assign)CGPoint point;

/**
 当前点的标识
 */
@property (nonatomic,assign)int     pointId;


@end
