//
//  WSKGesturePasswordService.h
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSKGesturePasswordService : NSObject
/*!
 @abstract 是否已经设置
 */
+ (BOOL)isHaveBeenSet;
/*!
 @abstract 设置/更改密码
 */
+ (void)setOrResetGesturePassword:(NSString *)password;

/*!
 @abstract 获取密码
 */
+ (NSString *)getGesturePassword;
@end
