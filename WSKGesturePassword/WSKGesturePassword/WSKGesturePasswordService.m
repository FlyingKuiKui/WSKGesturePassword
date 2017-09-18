//
//  WSKGesturePasswordService.m
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "WSKGesturePasswordService.h"

#define kGesturePassword @"keyGesturePassword"

@implementation WSKGesturePasswordService

/*!
 @abstract 是否已经设置
 */
+ (BOOL)isHaveBeenSet{
    NSString *pass = [self getGesturePassword];
    if (pass.length > 3) {
        return YES;
    }else{
        return NO;
    }
}
/*!
 @abstract 设置/更改密码
 */
+ (void)setOrResetGesturePassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kGesturePassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*!
 @abstract 获取密码
 */
+ (NSString *)getGesturePassword{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kGesturePassword];
}



@end
