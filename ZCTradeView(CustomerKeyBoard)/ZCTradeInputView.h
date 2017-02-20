//
//  ZCTradeInputView.h
//  直销银行
//
//  Created by 2016年 lianghuigui.
//  Copyright (c) 2016年 lianghuigui. All rights reserved.
//  交易输入视图

#import <Foundation/Foundation.h>

static NSString *ZCTradeInputViewCancleButtonClick = @"ZCTradeInputViewCancleButtonClick";
static NSString *ZCTradeInputViewOkButtonClick = @"ZCTradeInputViewOkButtonClick";
static NSString *ZCTradeInputViewPwdKey = @"ZCTradeInputViewPwdKey";

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class ZCTradeInputView;

@protocol ZCTradeInputViewDelegate <NSObject>

@optional
/** 确定按钮点击 */
- (void)tradeInputView:(ZCTradeInputView *)tradeInputView okBtnClick:(UIButton *)okBtn;
/** 取消按钮点击 */
- (void)tradeInputView:(ZCTradeInputView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtn;

@end

@interface ZCTradeInputView : UIView
@property (nonatomic, weak) id<ZCTradeInputViewDelegate> delegate;
@property (nonatomic,strong)NSString * titleStr;
@property (nonatomic,strong)NSString * payType;
@property (nonatomic,strong)NSString * payMoney;
@property (nonatomic,strong)NSString * cardInfo;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleStr payType:(NSString *)payType money:(NSString *)payMoney cardInfo:(NSString *)cardInfo;
@end
