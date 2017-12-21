//
//  ViewController.m
//  transformationDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ViewController.h"
#import "ACRectViewsManager.h"
#import "ACTranformViewManager.h"
@interface ViewController ()<ACRectViewsManagerDelegate,ACTranformViewmanagerTouchDelegate>

@property (nonatomic,strong)ACRectViewsManager * viewManager;

@property (nonatomic, strong) ACTranformViewManager    *tranFromViewManager;

@property  (nonatomic,strong)UIImageView * showImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.showImageView];
//    [self.view addSubview:self.viewManager];
    [self.view addSubview:self.tranFromViewManager];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //test date
    CGPoint pointOne = CGPointMake(self.showImageView.frame.origin.x, self.showImageView.frame.origin.y);
    CGPoint pointTwo = CGPointMake(self.showImageView.frame.origin.x+self.showImageView.frame.size.width, self.showImageView.frame.origin.y-20);
    CGPoint pointThree = CGPointMake( self.showImageView.frame.origin.x +self.showImageView.frame.size.width-6, self.showImageView.frame.origin.y+self.showImageView.frame.size.height);
    CGPoint pointFour = CGPointMake(self.showImageView.frame.origin.x + 40 , self.showImageView.frame.origin.y+self.showImageView.frame.size.height + 60);
    
    ACRectPoint *rectPoint1  = [ACRectViewsManager createACRectPointWithPoint:pointOne];
    rectPoint1.pointId = 0;
    ACRectPoint *rectPoint2 = [ACRectViewsManager createACRectPointWithPoint:pointTwo];
    rectPoint2.pointId = 1;
    ACRectPoint *rectPoint3 = [ACRectViewsManager createACRectPointWithPoint:pointThree];
    rectPoint3.pointId = 2;
    ACRectPoint *rectPoint4 = [ACRectViewsManager createACRectPointWithPoint:pointFour];
    rectPoint4.pointId = 3;
    
//    NSArray *pointArray = @[rectPoint1,rectPoint2,rectPoint3,rectPoint4];
//    [self.viewManager createRectViewWithPoints:pointArray];
    
    
    ACTranformPoint * point1 = [[ACTranformPoint alloc] init];
    ACTranformPoint * point2 = [[ACTranformPoint alloc] init];
    ACTranformPoint * point3 = [[ACTranformPoint alloc] init];
    ACTranformPoint * point4 = [[ACTranformPoint alloc] init];

    point1.point = pointOne;
    point2.point = pointTwo;
    point3.point = pointThree;
    point4.point = pointFour;
    point1.pointId = 0;
    point2.pointId = 1;
    point3.pointId = 2;
    point4.pointId = 3;

    NSArray * tranformPointArray = @[point1,point2,point3,point4];
    
    [self.tranFromViewManager creatTranFormViewWithPoints:tranformPointArray];
    
    
}


- (ACTranformViewManager*)tranFromViewManager {
    if (!_tranFromViewManager) {
        _tranFromViewManager = [[ACTranformViewManager alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
        _tranFromViewManager.delegate = self;
    }
    return _tranFromViewManager;
}

- (ACRectViewsManager*)viewManager {
    if (!_viewManager) {
        _viewManager = [[ACRectViewsManager alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
        _viewManager.delegate = self;
    }
    return _viewManager;
}

- (UIImageView*)showImageView {
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 100, 200, 120)];
        _showImageView.image = [UIImage imageNamed:@"test"];
    }
    return _showImageView;
}

#pragma mark ACRectViewsManagerDelegate
- (void)beginEditWithRectView:(ACRectView *)rect{
    NSLog(@"begin--->%@",rect);
}
- (void)endEditWithRectView:(ACRectView *)rect{
    NSLog(@"end--->%@",rect);
    
}
- (void)rectPointMoving:(ACRectView *)rect{
    NSLog(@"moving--->%@",rect);
    
}
- (void)rectPointMoveStop:(ACRectView *)rect{
    NSLog(@"stop--->%@",rect);
    
}

- (void)touchMovWith:(ACTranformViewManager*)viewManager andAllPoints:(ACRectVetrex)vexterx {
    
    
}

- (void)touchEndWith:(ACTranformViewManager *)viewManager andAllPoints:(ACRectVetrex)vexterx {
    
}


@end

