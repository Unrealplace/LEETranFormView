//
//  ACRectView.h
//
//  Created by andong on 10/11/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACRectPointButton.h"
#import "ACRectPoint.h"



/*
 point tag
     0         0       1        0    1
    /\         ---------         ____
   /  \        |       |      5 /    \ 2
  /    \       |       |        \____/
 --------      ---------        4     3
 2      1      3       2
*/


typedef NS_ENUM(NSUInteger, ACViewShape) {
    ACViewShape_triangle = 3,
    ACViewShape_Rect = 4
};
/*
    RectView是一个画布全部frame，拖动pointButton是拖动rectView上的layer
 */

@protocol ACRectViewDelegate <NSObject>

- (void)savePathWithRectView:(id)rect;

- (void)rectPointMoveing:(id)rect;
- (void)rectPointStop:(id)rect;

@end

@interface ACRectView : UIView

//init
- (instancetype)initWithSuperViewBounds:(CGRect)superViewBounds shape:(ACViewShape)shape;

- (instancetype)initWithSuperViewBounds:(CGRect)superViewBounds PointArray:(NSArray <ACRectPoint *> *)points;

//option
- (NSArray *)savePath;
- (void)beginEditPath;
- (void)deletePath;


@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong)NSMutableArray <ACRectPoint *> * allPointArray;
@property (nonatomic,strong)NSMutableArray <ACRectPointButton *> * allPointButtonArray;

@property (nonatomic,assign) BOOL canSave;

//properyies
@property (nonatomic,assign,readonly)CGPoint          rectTopPoint;
@property (nonatomic,assign,readonly)CGPoint          rectBottomPoint;

@property (nonatomic,strong)UIColor *originalFillColor;
@property (nonatomic,strong)UIColor  *fillColor;         //default gray
@property (nonatomic,strong)UIColor  *strokeColor;       //default red
@property (nonatomic,assign)NSInteger lineWidth;         //default 2

@property (nonatomic,strong)NSString *buttonBackgroundImage_defaultStr;
@property (nonatomic,strong)NSString *buttonBackgroundImage_highlightedStr;

@property (nonatomic,weak) id <ACRectViewDelegate> delegate;

@end
