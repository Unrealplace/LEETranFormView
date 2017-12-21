//
//  ACRectPointButton.h
//
//  Created by andong on 10/12/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACRectPointButton;
@protocol ACRectPointButtonDelegate <NSObject>

@required
- (void)touchMoveButton:(ACRectPointButton *)rectPointButton WithTag:(NSInteger)tag WithPoint:(CGPoint)point;
- (void)touchEndButton:(ACRectPointButton *)rectPointButton WithTag:(NSInteger)tag WithPoint:(CGPoint)point;

@end

@interface ACRectPointButton : UIButton

@property (nonatomic,weak) id <ACRectPointButtonDelegate> delegete ;


@end
