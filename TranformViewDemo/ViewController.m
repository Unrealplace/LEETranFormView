//
//  ViewController.m
//  transformationDemo
//
//  Created by NicoLin on 2017/12/21.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ViewController.h"
#import "ACRectViewsManager.h"

@interface ViewController ()<ACRectViewsManagerDelegate>

@property (nonatomic,strong)ACRectViewsManager * viewManager;

@property  (nonatomic,strong)UIImageView * showImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.showImageView];
    [self.view addSubview:self.viewManager];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //test date
    CGPoint pointOne = CGPointMake(self.showImageView.frame.origin.x, self.showImageView.frame.origin.y);
    CGPoint pointTwo = CGPointMake(self.showImageView.frame.origin.x+self.showImageView.frame.size.width, self.showImageView.frame.origin.y);
    CGPoint pointThree = CGPointMake( self.showImageView.frame.origin.x +self.showImageView.frame.size.width, self.showImageView.frame.origin.y+self.showImageView.frame.size.height);
    CGPoint pointFour = CGPointMake(self.showImageView.frame.origin.x, self.showImageView.frame.origin.y+self.showImageView.frame.size.height);
    
    ACRectPoint *rectPoint1  = [ACRectViewsManager createACRectPointWithPoint:pointOne];
    rectPoint1.pointId = 0;
    ACRectPoint *rectPoint2 = [ACRectViewsManager createACRectPointWithPoint:pointTwo];
    rectPoint2.pointId = 1;
    ACRectPoint *rectPoint3 = [ACRectViewsManager createACRectPointWithPoint:pointThree];
    rectPoint3.pointId = 2;
    ACRectPoint *rectPoint4 = [ACRectViewsManager createACRectPointWithPoint:pointFour];
    rectPoint4.pointId = 3;
    
    NSArray *pointArray = @[rectPoint1,rectPoint2,rectPoint3,rectPoint4];
    [self.viewManager createRectViewWithPoints:pointArray];
    
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
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 100, 100, 120)];
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



@end

