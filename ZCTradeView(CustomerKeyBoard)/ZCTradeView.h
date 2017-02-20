//
//  ZCTradeView.h
//  直销银行
//
//  Created by 2016年 lianghuigui.
//  Copyright (c) 2016年 lianghuigui. All rights reserved.
//  交易密码视图\负责整个项目的交易密码输入

#import <UIKit/UIKit.h>

@class ZCTradeKeyboard;

@protocol ZCTradeViewDelegate <NSObject>

@optional
- (void)finish:(NSString *)pwd;

@end

@interface ZCTradeView : UIView

@property (nonatomic, weak) id<ZCTradeViewDelegate> delegate;

/** 完成的回调block */
@property (nonatomic, copy) void (^finish) (NSString *passWord);
@property (nonatomic,strong)NSString * titleStr;
@property (nonatomic,strong)NSString * payType;
@property (nonatomic,strong)NSString * payMoney;
@property (nonatomic,strong)NSString * cardInfo;
@property (nonatomic,strong)UIView * bgView;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleStr payType:(NSString *)payType money:(NSString *)payMoney cardInfo:(NSString *)cardInfo;

/** 快速创建 */
+ (instancetype)tradeView;

/** 弹出 */
- (void)show;
- (void)showInView:(UIView *)view;

@end
