//
//  ACRectViewsManager.h
//  ACdrawRect
//
//  Created by andong on 10/13/16.
//  Copyright © 2016 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACRectView.h"

@protocol ACRectViewsManagerDelegate <NSObject>

- (void)beginEditWithRectView:(ACRectView *)rect;
- (void)endEditWithRectView:(ACRectView *)rect;

- (void)rectPointMoving:(ACRectView *)rect;
- (void)rectPointMoveStop:(ACRectView *)rect;

@end




@interface ACRectViewsManager : UIView

@property (nonatomic,strong,readonly)ACRectView *currentView;

@property (nonatomic,weak) id <ACRectViewsManagerDelegate> delegate;

- (void)createRectViewWithShape:(ACViewShape)shape;
- (void)createRectViewWithPoints:(NSArray <ACRectPoint *>*)points;

- (void)editRectView:(ACRectView *)rect;
- (void)deleteRectView:(ACRectView *)rect;
- (NSArray *)saveRectView:(ACRectView *)rect;

+ (ACRectPoint *)createACRectPointWithPoint:(CGPoint)point;

- (NSInteger)getMinID;
@end
