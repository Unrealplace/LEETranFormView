//
//  ACRectPoint.h
//
//  Created by oliver on 21/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ACRectPoint : NSObject

@property (nonatomic,assign) NSInteger pointId;

@property (nonatomic,assign) CGPoint point;

@property (nonatomic,assign) BOOL isInnerAngleLess180;

@end
