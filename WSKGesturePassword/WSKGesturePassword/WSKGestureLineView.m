//
//  WSKGestureLineView.m
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "WSKGestureLineView.h"
#import "WSKGestureRoundView.h"

@interface WSKGestureLineView (){
    CGPoint LineEndPoint;
    NSMutableArray *touchPointArray; // 存储所有选中的点
    NSMutableArray *touchNumberArray;// 存储选中点的num值
    
    BOOL isSuccess;
}
@end
@implementation WSKGestureLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        touchPointArray = [NSMutableArray array];
        touchNumberArray = [NSMutableArray array];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        isSuccess = YES;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [touchPointArray removeAllObjects];
    [touchNumberArray removeAllObjects];
    isSuccess = YES;
    
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
        for (WSKGestureRoundView *temp in self.roundViewArray) {
            temp.gestureRoundModel = WSKGestureRoundViewModel_NoSelect;
            if (CGRectContainsPoint(temp.frame, touchPoint)) {
                CGRect tempFrame = temp.frame;
                
                CGPoint point = CGPointMake(tempFrame.origin.x+tempFrame.size.width/2,tempFrame.origin.y+tempFrame.size.height/2);
                
                NSDictionary *dict = @{@"x":[NSString stringWithFormat:@"%f",point.x],@"y":[NSString stringWithFormat:@"%f",point.y]};
                
                [touchPointArray addObject:dict];
            }
            [temp setNeedsDisplay];
        }
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
        for (WSKGestureRoundView *temp in self.roundViewArray) {
            int i = (int)[self.roundViewArray indexOfObject:temp];
            if (CGRectContainsPoint(temp.frame, touchPoint)) {
                //已经设置过的
                if ([touchNumberArray containsObject:[NSString stringWithFormat:@"number%d",i]]) {
                    LineEndPoint = touchPoint;
                    [self setNeedsDisplay];
                    return;
                }
                [touchNumberArray addObject:[NSString stringWithFormat:@"number%d",i]];
                temp.gestureRoundModel = WSKGestureRoundViewModel_Success;
                [temp setNeedsDisplay];
                CGRect frameTemp = temp.frame;
                CGPoint point = CGPointMake(frameTemp.origin.x+frameTemp.size.width/2,frameTemp.origin.y+frameTemp.size.height/2);
                
                NSDictionary *dict = @{@"x":[NSString stringWithFormat:@"%f",point.x],@"y":[NSString stringWithFormat:@"%f",point.y],@"number":[NSString stringWithFormat:@"%d",i]};
                [touchPointArray addObject:dict];
                break;
            }
            [temp setNeedsDisplay];
        }
        LineEndPoint = touchPoint;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSDictionary *last = [touchPointArray lastObject];
    CGPoint point = CGPointMake([last[@"x"] floatValue],[last[@"y"] floatValue]);
    LineEndPoint = point;
    
    NSMutableString *resultString = [NSMutableString string];
    for (NSDictionary *temp in touchPointArray ){
        if(![temp objectForKey:@"number"])break;
        [resultString appendString:[temp objectForKey:@"number"]];
    }
    
    if (resultString.length > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(gestureLineView: isSuccessOrErrorPassword:)]) {
            isSuccess = [self.delegate gestureLineView:self isSuccessOrErrorPassword:resultString];
        }
    }else{
        isSuccess = YES;
    }
    
    for (int i=0; i<touchPointArray.count; i++) {
        NSInteger selection = [[[touchPointArray objectAtIndex:i] objectForKey:@"number"]intValue];
        WSKGestureRoundView *roundTemp = ((WSKGestureRoundView *)[self.roundViewArray objectAtIndex:selection]);
        if (isSuccess) {
            roundTemp.gestureRoundModel = WSKGestureRoundViewModel_Success;
        }else{
            roundTemp.gestureRoundModel = WSKGestureRoundViewModel_Error;
        }
        [roundTemp setNeedsDisplay];
    }
    [self setNeedsDisplay];
}
#pragma mark - 重新绘制
- (void)restartDrawing{
    [touchPointArray removeAllObjects];
    [touchNumberArray removeAllObjects];
    for (WSKGestureRoundView *temp in self.roundViewArray) {
        temp.gestureRoundModel = WSKGestureRoundViewModel_NoSelect;
        [temp setNeedsDisplay];
    }
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    for (int i = 0; i < touchPointArray.count; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (![[touchPointArray objectAtIndex:i] objectForKey:@"number"]) { //防止过快滑动产生垃圾数据
            [touchPointArray removeObjectAtIndex:i];
            continue;
        }
        if (isSuccess) {
            CGContextSetRGBStrokeColor(context, 0.263, 0.675, 0.918, 1);//蓝色
        }else {
            CGContextSetRGBStrokeColor(context, 0.988, 0.361, 0.388, 1);//红色
        }
        
        CGContextSetLineWidth(context,2);
        
        CGContextMoveToPoint(context, [[[touchPointArray objectAtIndex:i] objectForKey:@"x"] floatValue], [[[touchPointArray objectAtIndex:i] objectForKey:@"y"] floatValue]);
        if (i<touchPointArray.count-1) {
            CGContextAddLineToPoint(context, [[[touchPointArray objectAtIndex:i+1] objectForKey:@"x"] floatValue],[[[touchPointArray objectAtIndex:i+1] objectForKey:@"y"] floatValue]);
        }else{
            if (isSuccess) {
                CGContextAddLineToPoint(context, LineEndPoint.x,LineEndPoint.y);
            }
        }
        CGContextStrokePath(context);
    }
}

@end
