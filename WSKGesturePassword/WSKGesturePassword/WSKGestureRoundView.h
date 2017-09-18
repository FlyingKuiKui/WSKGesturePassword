//
//  WSKGestureRoundView.h
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WSKGestureRoundViewModel) {
    WSKGestureRoundViewModel_NoSelect = 0, /**< 未选中 */
    WSKGestureRoundViewModel_Error,      /**< 错误 */
    WSKGestureRoundViewModel_Success,      /**< 正确 */
};
@interface WSKGestureRoundView : UIView

@property (nonatomic, assign) WSKGestureRoundViewModel gestureRoundModel;

@end
