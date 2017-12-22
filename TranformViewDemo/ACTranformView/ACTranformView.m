//
//  ACTranformView.m
//  TranformViewDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACTranformView.h"
#import "ACTranformButton.h"

const static CGFloat ACPointButtonSize    = 45;
const static CGFloat ACCenterButtonSize   = 45;

#define pi 3.14159265358979323846
#define degreesToRadian(x) (pi * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / pi)
//static inline CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
//    CGFloat deltaX = second.x - first.x;
//    CGFloat deltaY = second.y - first.y;
//    return sqrt(deltaX*deltaX + deltaY*deltaY );
//};
static inline CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return radiansToDegrees(rads);
}
//static inline CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
//
//    CGFloat a = line1End.x - line1Start.x;
//    CGFloat b = line1End.y - line1Start.y;
//    CGFloat c = line2End.x - line2Start.x;
//    CGFloat d = line2End.y - line2Start.y;
//    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
//    return radiansToDegrees(rads);
//
//}
@interface ACTranformView()<ACTranformButtonMovDelegate>
@property (nonatomic, strong) UIBezierPath       *path;
@property (nonatomic, strong) UIColor            *fillColor;
@property (nonatomic, strong) UIColor            *strokColor;
@property (nonatomic, assign) int                      lineWidth;
@property (nonatomic, strong) NSMutableArray     *allPointsArray; // 顶点的数组
@property (nonatomic, strong) NSMutableArray     *allCenterPointsArray;// 中心点点数组
@property (nonatomic, strong) NSMutableArray     *allPointsBtnArray;//所有顶点的按钮
@property (nonatomic, strong) NSMutableArray     *allCenterPointsBtnArray;//所有的中点点按钮

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
    _path.lineCapStyle =  kCGLineCapRound;
    _path.lineJoinStyle = kCGLineJoinRound;
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

- (void)setCenterHidden:(BOOL)centerHidden {
    for (ACTranformButton * btn in self.allCenterPointsBtnArray) {
        btn.hidden = centerHidden;
    }
    _centerHidden = centerHidden;
}

- (void)setPointHidden:(BOOL)pointHidden {
    for (ACTranformButton * btn in self.allPointsBtnArray) {
        btn.hidden = pointHidden;
    }
    _pointHidden  = pointHidden;
}


#pragma mark 创建顶点和 线段的方法
- (void)creatPointBtnAndLineWithPoints:(NSArray<ACTranformPoint*>*)points {

    for (int i = 0 ; i < [points count]; i++) {
        
        ACTranformPoint * prePoint    = points[i]; // 计算前一个点
        ACTranformPoint * backPoint   = points[(i + 1)==points.count?0:(i + 1)];// 计算后一个点
        ACTranformPoint * centerPoint = [[ACTranformPoint alloc] init]; // 计算二者中点
        CGFloat   rotateAngle         = angleBetweenPoints(prePoint.point, backPoint.point); //计算两个点间的斜率，用来纠正中点的按钮方向
        centerPoint.point             = CGPointMake((prePoint.point.x + backPoint.point.x) / 2.0f,(prePoint.point.y + backPoint.point.y) /2.0f);// 计算中点
        [self.allCenterPointsArray addObject:centerPoint];
        
        // 按坐标点创建顶点和中点按钮
        ACTranformButton * pointBtn  = [[ACTranformButton alloc] initWithFrame:CGRectMake(0, 0, ACPointButtonSize, ACPointButtonSize) andButtonType:ACButtonShape_Point];
        ACTranformButton * centerBtn = [[ACTranformButton alloc] initWithFrame:CGRectMake(0, 0, ACCenterButtonSize, ACCenterButtonSize) andButtonType:ACButtonShape_Center];
        pointBtn.tag                 = i;
        centerBtn.tag                = 100+i;
        pointBtn.center              = prePoint.point;
        centerBtn.center             = centerPoint.point;
        // 给中点按钮设置旋转角度
        CGAffineTransform transform  = CGAffineTransformMakeRotation(-rotateAngle * M_PI / 180.0f);
        centerBtn.transform          = transform;
        pointBtn.delegate  = self;
        centerBtn.delegate = self;
        
        [self addSubview:pointBtn];
        [self addSubview:centerBtn];
        [self.allPointsBtnArray addObject:pointBtn];
        [self.allCenterPointsBtnArray addObject:centerBtn];
    }
    self.allPointsArray = points.mutableCopy;
    self.centerHidden   = NO;
    self.pointHidden    = YES;
    
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
    
    
    
    if (!self.centerHidden) {
        ACTranformPoint * centerPoint = [self.allCenterPointsArray objectAtIndex:tag-100];// 获取当前的中心点
       __block CGFloat  kCenterPointMov     ;
       __block CGFloat  offsetCenterY   =0  ;
       __block CGFloat  offsetCenterX   =0  ;
       __block NSInteger  centerIdx         ;
       __block ACTranformPoint * leftPoint  ;
       __block ACTranformPoint * rightPoint ;
       __block CGPoint          newLeftPoint;
       __block CGPoint          newRightPoint;
       __block BOOL isKMax                  = NO;
       __block BOOL isKZero                 = NO;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            if((point.x - centerPoint.point.x) == 0)isKMax  = YES;
            if((point.y - centerPoint.point.y) == 0)isKZero = YES;
            kCenterPointMov      = (point.y - centerPoint.point.y) / (point.x - centerPoint.point.x);// 计算要移动的方向的斜率
            offsetCenterY        = point.y - centerPoint.point.y;// 计算Y轴偏移量
            centerIdx            = tag - 100;//得到中心点点index
            leftPoint   = self.allPointsArray[centerIdx];//中心点的左边点
            rightPoint  = self.allPointsArray[(centerIdx+1)==4?0:(centerIdx+1)];//中心点的右边点
            // 下面兼容斜率为 0  和 斜率 为 无穷大的情况
            newLeftPoint = CGPointMake((isKMax || isKZero)? 0:offsetCenterY / kCenterPointMov   + leftPoint.point.x + offsetCenterX, leftPoint.point.y + offsetCenterY);// 新的左边的点
            newRightPoint= CGPointMake((isKMax || isKZero)? 0:offsetCenterY / kCenterPointMov  + rightPoint.point.x+ offsetCenterX, rightPoint.point.y + offsetCenterY);//新的右边的点
            
            NSLog(@"k--->%lf----newLeft--%@----newRight--%@",kCenterPointMov,NSStringFromCGPoint(newLeftPoint),NSStringFromCGPoint(newRightPoint));
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                
                CGPoint detectionLeftPoint  =  [self boundaryDetectionWithPoint:newLeftPoint];
                CGPoint detectionRightPoint =  [self boundaryDetectionWithPoint:newRightPoint];
                if([self reachBoundaryDeteactionWithPoint:detectionLeftPoint] || [self reachBoundaryDeteactionWithPoint:detectionRightPoint])return;
                // 下面修改数据源
                leftPoint.point               = detectionLeftPoint;
                rightPoint.point              = detectionRightPoint;
                centerPoint.point             = CGPointMake((detectionRightPoint.x + detectionLeftPoint.x)/2.0f, (detectionRightPoint.y + detectionLeftPoint.y)/2.0f);
                
                
                [self.allCenterPointsArray removeAllObjects];
                for (int i = 0 ; i < [self.allPointsArray count]; i++) {
                    
                    ACTranformPoint * prePoint    = _allPointsArray[i]; // 计算前一个点
                    ACTranformPoint * backPoint   = _allPointsArray[(i + 1)==_allPointsArray.count?0:(i + 1)];// 计算后一个点
                    ACTranformPoint * centerPoint = [[ACTranformPoint alloc] init]; // 计算二者中点
                    CGFloat   rotateAngle         = angleBetweenPoints(prePoint.point, backPoint.point); //计算两个点间的斜率，用来纠正中点的按钮方向
                    centerPoint.point             = CGPointMake((prePoint.point.x + backPoint.point.x) / 2.0f,(prePoint.point.y + backPoint.point.y) /2.0f);// 计算中点
                    [self.allCenterPointsArray addObject:centerPoint];
                    ACTranformButton * pointBtn   = self.allPointsBtnArray[i];
                    pointBtn.center               = prePoint.point;
                    ACTranformButton * oneBtn     = self.allCenterPointsBtnArray[i];
                    oneBtn.center                 = centerPoint.point;
                    // 给中点按钮设置旋转角度
                    CGAffineTransform transform   = CGAffineTransformMakeRotation(-rotateAngle * M_PI / 180.0f);
                    oneBtn.transform              = transform;
                    
                }
            });
            
            
        });
       
    }
    
    if (!self.pointHidden) { //判断这个点是否超出了父视图的view 范围内
        ACTranformPoint * btnPoint = [self.allPointsArray objectAtIndex:tag];
        CGPoint newPoint = [self boundaryDetectionWithPoint:point];
        btnPoint.point = newPoint;
        [tranformBtn setCenter:newPoint];
        [self.allCenterPointsArray removeAllObjects];
        for (int i = 0 ; i < [self.allPointsArray count]; i++) {
            
            ACTranformPoint * prePoint    = _allPointsArray[i]; // 计算前一个点
            ACTranformPoint * backPoint   = _allPointsArray[(i + 1)==_allPointsArray.count?0:(i + 1)];// 计算后一个点
            ACTranformPoint * centerPoint = [[ACTranformPoint alloc] init]; // 计算二者中点
            CGFloat   rotateAngle         = angleBetweenPoints(prePoint.point, backPoint.point); //计算两个点间的斜率，用来纠正中点的按钮方向
            centerPoint.point             = CGPointMake((prePoint.point.x + backPoint.point.x) / 2.0f,(prePoint.point.y + backPoint.point.y) /2.0f);// 计算中点
            [self.allCenterPointsArray addObject:centerPoint];
            ACTranformButton * oneBtn     = self.allCenterPointsBtnArray[i];
            oneBtn.center                 = centerPoint.point;
            // 给中点按钮设置旋转角度
            CGAffineTransform transform   = CGAffineTransformMakeRotation(-rotateAngle * M_PI / 180.0f);
            oneBtn.transform              = transform;
            
        }
        
    }
    
    [self setNeedsDisplay];
    ACMeshVertex vertex = {
        [_allPointsArray[0] point],
        [_allPointsArray[1] point],
        [_allPointsArray[3] point],
        [_allPointsArray[2] point],

    };

    if (self.delegate && [self.delegate respondsToSelector:@selector(tranFormViewMovingWithView:andPoints:)]) {
        [self.delegate tranFormViewMovingWithView:self andPoints:vertex];
    }
    
}


/**
 检测是否到达边界

 @param point 要检测的坐标点
 @return 是否到达边界
 */
- (BOOL)reachBoundaryDeteactionWithPoint:(CGPoint)point {
    BOOL reach = NO;
    if (point.y >= self.bounds.size.height)reach=YES;
    if (point.x >= self.bounds.size.width )reach=YES;
    if (point.y <= 0)reach=YES;
    if (point.x <= 0)reach=YES;
    return reach;
}
/**
 顶点边界检测

 @param point 要检测的点
 @return 检测完成的点
 */
- (CGPoint)boundaryDetectionWithPoint:(CGPoint)point{
    if (point.y >= self.bounds.size.height)point.y  = self.bounds.size.height;
    if (point.x >= self.bounds.size.width )point.x  =  self.bounds.size.width;
    if (point.y <= 0)point.y = 0;
    if (point.x <= 0)point.x = 0;
    return CGPointMake(point.x, point.y);
}
- (void)touchEndButton:(ACTranformButton *)tranformBtn withBtnTag:(NSInteger)tag andBtnPoint:(CGPoint)point{
    
    ACMeshVertex vertex = {
        [_allPointsArray[0] point],
        [_allPointsArray[1] point],
        [_allPointsArray[3] point],
        [_allPointsArray[2] point],
        
    };
    if (self.delegate && [self.delegate respondsToSelector:@selector(tranFormViewStopWithView:andPoints:)]) {
        [self.delegate tranFormViewStopWithView:self andPoints:vertex];
    }
    
}

@end

