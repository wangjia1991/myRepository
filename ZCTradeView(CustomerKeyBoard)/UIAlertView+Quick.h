//
//  UIAlertView+Quick.h
//  直销银行
//
//  Created by lianghuigui on lianghuigui.
//  Copyright (c) 2016年 lianghuigui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Quick)

+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

@end
