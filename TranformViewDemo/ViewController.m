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
#import "ACRulerView.h"

@interface ViewController ()<ACRectViewsManagerDelegate,ACTranformViewmanagerTouchDelegate,ACRulerViewRotateDelegate>

@property (nonatomic,strong)ACRectViewsManager * viewManager;

@property (nonatomic, strong) ACTranformViewManager    *tranFromViewManager;

@property  (nonatomic,strong)UIImageView * showImageView;

@property (nonatomic,strong)ACRulerView * rulerView;

@property  (nonatomic,assign)BOOL showCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.showImageView];
////    [self.view addSubview:self.viewManager];
//    [self.view addSubview:self.tranFromViewManager];
    
    
    //test date
    CGPoint pointOne = CGPointMake(self.showImageView.frame.origin.x-40, self.showImageView.frame.origin.y-30);
    CGPoint pointTwo = CGPointMake(self.showImageView.frame.origin.x+self.showImageView.frame.size.width, self.showImageView.frame.origin.y);
    CGPoint pointThree = CGPointMake( self.showImageView.frame.origin.x +self.showImageView.frame.size.width, self.showImageView.frame.origin.y+self.showImageView.frame.size.height);
    CGPoint pointFour = CGPointMake(self.showImageView.frame.origin.x  , self.showImageView.frame.origin.y+self.showImageView.frame.size.height);
    
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
    
    
    
    self.showCenter = NO;
    
    ACMeshVertex meshVertex =  {
        pointOne,
        pointTwo,
        pointFour,
        pointThree,
    };
    
//    [self.tranFromViewManager creatTranFormViewWithPoints:meshVertex];
    
//    [self.tranFromViewManager showTheCenterPoint:self.showCenter andPointPoint:!self.showCenter];

    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.rulerView = [[ACRulerView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 80) target:self ];
    
    [self.view addSubview:self.rulerView];
    
    [self.rulerView reloadData];
    
    UIButton * btn = [UIButton new];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.rulerView.frame), 100, 100);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)btnClick:(id)sender {
    [self.rulerView reSet];
}

- (int)rulerCount {
    return 60;
}

- (int)rulerSignalDegreeCount {
    return 5;
}
- (void)rulerViewRotateWithDegree:(int)degree {
    
    NSLog(@"%d",degree);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.showCenter = !self.showCenter;
    [self.tranFromViewManager showTheCenterPoint:self.showCenter andPointPoint:!self.showCenter];

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

- (void)touchMovWithAllPoints:(ACMeshVertex)vertex {
    NSLog(@"mov---%@--->%@",NSStringFromCGPoint(vertex.L_B),NSStringFromCGPoint(vertex.R_B));
}

- (void)touchEndWithAllPoints:(ACMeshVertex)vertex {
    NSLog(@"end---%@--->%@",NSStringFromCGPoint(vertex.L_B),NSStringFromCGPoint(vertex.R_B));

}
 
@end

