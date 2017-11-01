//
//  WSKGestureRoundView.m
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "WSKGestureRoundView.h"

@implementation WSKGestureRoundView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.width/2;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    if (self.gestureRoundModel == WSKGestureRoundViewModel_NoSelect) {
        CGContextSetRGBStrokeColor(context, 0.773, 0.773, 0.773, 1);//线条颜色
    }else{
        if (self.gestureRoundModel == WSKGestureRoundViewModel_Success) {
            CGContextSetRGBStrokeColor(context, 0.263, 0.675, 0.918, 1);//线条颜色
            CGContextSetRGBFillColor(context, 0.263, 0.675, 0.918, 1);
        }else{
            CGContextSetRGBStrokeColor(context, 0.988, 0.361, 0.388, 1);//线条颜色
            CGContextSetRGBFillColor(context, 0.988, 0.361, 0.388, 1);
        }
        CGFloat roundRadius = bounds.size.width/8;
        CGRect frame = CGRectMake(bounds.size.width/2-roundRadius, bounds.size.height/2-roundRadius, roundRadius*2, roundRadius*2);
        CGContextAddEllipseInRect(context,frame);
        CGContextFillPath(context);
    }
    CGFloat lineWidth = 2.0;
    CGContextSetLineWidth(context,lineWidth);
    CGRect frame = CGRectMake(lineWidth/2, lineWidth/2, bounds.size.width-lineWidth, bounds.size.height-lineWidth);
    CGContextAddEllipseInRect(context,frame);
    CGContextStrokePath(context);
    /*
     // 设置填充色
     if (self.gestureRoundModel == Gesture_RoundView_Model_Success) {
     CGContextSetRGBFillColor(context,30/255.f, 175/255.f, 235/255.f,0.3);
     }else {
     CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,0.3);
     }
     CGContextAddEllipseInRect(context,frame);
     if (self.gestureRoundModel != Gesture_RoundView_Model_NoSelect) {
     CGContextFillPath(context);
     }
     */
}


@end
