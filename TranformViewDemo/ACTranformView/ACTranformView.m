//
//  ACTranformView.m
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACTranformView.h"
#import "ACTranformButton.h"

const static CGFloat ACPointButtonSize   = 45;
const static CGFloat ACCenterButtonSize   = 45;

#define pi 3.14159265358979323846
#define degreesToRadian(x) (pi * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / pi)
static inline CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};
static inline CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return radiansToDegrees(rads);
    //degs = degrees(atan((top - bottom)/(right - left)))
}
static inline CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    return radiansToDegrees(rads);
    
}
@interface ACTranformView()<ACTranformButtonMovDelegate>
@property (nonatomic, strong) UIBezierPath    *path;
@property (nonatomic, strong) UIColor            *fillColor;
@property (nonatomic, strong) UIColor            *strokColor;
@property (nonatomic, assign) int                      lineWidth;
@property (nonatomic, strong) NSMutableArray    *allPointsArray; // 顶点的数组
@property (nonatomic, strong) NSMutableArray    *allCenterPointsArray;// 中心点点数组
@property (nonatomic, strong) NSMutableArray    *allPointsBtnArray;//所有顶点的按钮
@property (nonatomic, strong) NSMutableArray    *allCenterPointsBtnArray;//所有的中点点按钮

@end

@implementation ACTranformView

- (instancetype)initWithFrame:(CGRect)frame andPoints:(NSArray<ACTranformPoint *> *)points {
    
    if (self = [super initWithFrame:frame]) {
        [self defaultSetup];
        [self creatPointBtnAndLineWithPoints:points];
    }
    return self;
}

- (void)defaultSetup {
    _path = [UIBezierPath bezierPath];
    _fillColor = [UIColor clearColor];
    _strokColor  = [UIColor blueColor];
    _lineWidth   = 2.0f;
    self.backgroundColor = [UIColor clearColor];
    
}

#pragma getter 方法 初始化容器变量
- (NSMutableArray*)allPointsArray {
    if (!_allPointsArray) {
        _allPointsArray = [NSMutableArray array];
    }
    return _allPointsArray;
}
- (NSMutableArray*)allCenterPointsArray {
    if (!_allCenterPointsArray) {
        _allCenterPointsArray = [NSMutableArray array];
    }
    return _allCenterPointsArray;
}
- (NSMutableArray *)allPointsBtnArray {
    if (!_allPointsBtnArray) {
        _allPointsBtnArray = [NSMutableArray array];
    }
    return _allPointsBtnArray;
}
- (NSMutableArray*)allCenterPointsBtnArray {
    if (!_allCenterPointsBtnArray) {
        _allCenterPointsBtnArray = [NSMutableArray array];
    }
    return _allCenterPointsBtnArray;
}

#pragma mark 创建顶点和 线段的方法
- (void)creatPointBtnAndLineWithPoints:(NSArray<ACTranformPoint*>*)points {
//    NSAssert(points.count != 4, @"points count must be four ");
    for (int i = 0 ; i < [points count]; i++) {
        
        ACTranformPoint * prePoint = points[i];
        ACTranformPoint * backPoint = points[(i + 1)==points.count?0:(i + 1)];
        ACTranformPoint * centerPoint = [[ACTranformPoint alloc] init];
        CGFloat   rotateAngle = angleBetweenPoints(prePoint.point, backPoint.point);
        
        centerPoint.point   = CGPointMake((prePoint.point.x + backPoint.point.x) / 2.0f,(prePoint.point.y + backPoint.point.y) /2.0f);
        [self.allCenterPointsArray addObject:centerPoint];
        
        
        ACTranformButton * pointBtn = [[ACTranformButton alloc] initWithFrame:CGRectMake(0, 0, ACPointButtonSize, ACPointButtonSize) andButtonType:ACButtonShape_Point];
        ACTranformButton * centerBtn = [[ACTranformButton alloc] initWithFrame:CGRectMake(0, 0, ACCenterButtonSize, ACCenterButtonSize) andButtonType:ACButtonShape_Center];
        pointBtn.center = prePoint.point;
        centerBtn.center = centerPoint.point;
        CGAffineTransform transform= CGAffineTransformMakeRotation(-rotateAngle * M_PI / 180.0f);
        centerBtn.transform = transform;
        pointBtn.delegate = self;
        centerBtn.delegate = self;
        
        [self addSubview:pointBtn];
        [self addSubview:centerBtn];
        [self.allPointsBtnArray addObject:pointBtn];
        [self.allCenterPointsBtnArray addObject:centerBtn];
    }
    self.allPointsArray = points.mutableCopy;
}

// 画图的方法
- (void)drawRect:(CGRect)rect {
    [self.path removeAllPoints];
    
    //set path
    CGPoint firstPoint = CGPointZero;
    for (ACTranformPoint *rectPoint in self.allPointsArray) {
        if (rectPoint.pointId == 0) { // 找到第一个点开始画点
            [self.path moveToPoint:rectPoint.point];
            firstPoint = rectPoint.point;// 下面闭合用
        } else {
            [self.path addLineToPoint:rectPoint.point];
        }
    }
    
    [self.path addLineToPoint:firstPoint];
    [self.path closePath];
    [self.fillColor setFill];
    [self.strokColor setStroke];
    [self.path setLineWidth:self.lineWidth];
    [self.path fill];
    [self.path stroke];
    
}

#pragma mark ACTranformButton 代理方法
- (void)touchMovButton:(ACTranformButton*)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point{
    
    ACRectVetrex vertex = {
        CGPointMake(0, 0),
        CGPointMake(0, 0),
        CGPointMake(0, 0),
        CGPointMake(0, 0),
    };
    if (self.delegate && [self.delegate respondsToSelector:@selector(tranFormViewMovingWithView:andPoints:)]) {
        [self.delegate tranFormViewMovingWithView:self andPoints:vertex];
    }
    
}

- (void)touchEndButton:(ACTranformButton *)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point{
    
    ACRectVetrex vertex = {
        CGPointMake(0, 0),
        CGPointMake(0, 0),
        CGPointMake(0, 0),
        CGPointMake(0, 0),
    };
    if (self.delegate && [self.delegate respondsToSelector:@selector(tranFormViewStopWithView:andPoints:)]) {
        [self.delegate tranFormViewStopWithView:self andPoints:vertex];
    }
    
}

@end

