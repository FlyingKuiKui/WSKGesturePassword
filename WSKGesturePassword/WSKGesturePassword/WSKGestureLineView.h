//
//  WSKGestureLineView.h
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSKGestureLineView;
@protocol WSKGestureLineViewDelgate <NSObject>

/*!
 @abstract 校验密码相关
 */
- (BOOL)gestureLineView:(WSKGestureLineView *)gestureLineView isSuccessOrErrorPassword:(NSString *)password;

@end


@interface WSKGestureLineView : UIView

@property (nonatomic, copy) NSArray *roundViewArray;

@property (nonatomic, weak) id<WSKGestureLineViewDelgate> delegate;

/*!
 @abstract 重新绘制
 */
- (void)restartDrawing;

@end
