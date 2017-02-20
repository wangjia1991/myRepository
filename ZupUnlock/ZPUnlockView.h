//
//  ZPUnlockView.h
//  手势密码解锁
//
//  Created by lianghuigui on 16-04-20.
//  Copyright (c) 2016年 lianghuigui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZpUnlockViewDelegate <NSObject>

@optional
-(void)zpunlockViewEndshow:(NSString *)passWord;
-(void)zpunlockViewEWsShoWscrollEnable:(BOOL)isorEnable;
@end



@interface ZPUnlockView : UIView

@property(nonatomic,assign)id<ZpUnlockViewDelegate> delegate;
@property (nonatomic,assign)BOOL isorFirstSetPassword;
@property (nonatomic,assign)BOOL  isorScrollEnable;
@end
