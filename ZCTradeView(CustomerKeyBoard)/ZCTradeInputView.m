//
//  ZCTradeInputView.m
//  直销银行
//
//  Created by 2016年 lianghuigui.
//  Copyright (c) 2016年 lianghuigui. All rights reserved.
//

#define ZCTradeInputViewNumCount 6

// 快速生成颜色
#define ZCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

typedef enum {
    ZCTradeInputViewButtonTypeWithCancle = 10000,
    ZCTradeInputViewButtonTypeWithOk = 20000,
}ZCTradeInputViewButtonType;

#import "ZCTradeInputView.h"
#import "ZCTradeKeyboard.h"
#import "NSString+Extension.h"

@interface ZCTradeInputView ()
/** 数字数组 */
@property (nonatomic, strong) NSMutableArray *nums;
/** 确定按钮 */
@property (nonatomic, weak) UIButton *okBtn;
/** 取消按钮 */
@property (nonatomic, weak) UIButton *cancleBtn;
@end

@implementation ZCTradeInputView

#pragma mark - LazyLoad

- (NSMutableArray *)nums
{
    if (_nums == nil) {
        _nums = [NSMutableArray array];
    }
    return _nums;
}

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleStr payType:(NSString *)payType money:(NSString *)payMoney cardInfo:(NSString *)cardInfo
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake((ZCScreenWidth -302)/2, (ZCScreenHeight -190)/2, 302, 190);
        self.backgroundColor = [UIColor clearColor];

        self.titleStr = titleStr;
        self.payType = payType;
        self.payMoney = payMoney;
        self.cardInfo = cardInfo;
        /** 注册keyboard通知 */
        [self setupKeyboardNote];
        /** 添加子控件 */
        [self setupSubViews];
    }
    return self;
}

/** 添加子控件 */
- (void)setupSubViews
{
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cancleBtn];
    self.cancleBtn = cancleBtn;
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-shanchu"] forState:UIControlStateNormal];
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-shanchu"] forState:UIControlStateHighlighted];
    [self.cancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn.tag = ZCTradeInputViewButtonTypeWithCancle;
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 302, 1)];
    line.backgroundColor = ZCColor(233, 233, 233);
    [self addSubview:line];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, self.frame.size.width-100, 20)];
    titleLabel.text = _titleStr;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    UILabel * payTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, self.frame.size.width-20, 20)];
    payTypeLabel.text = _payType;
    payTypeLabel.font = [UIFont systemFontOfSize:15];
    payTypeLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    payTypeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:payTypeLabel];

    
    UILabel * payMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, self.frame.size.width-20, 20)];
    payMoneyLabel.text = _payMoney;
    payMoneyLabel.font = [UIFont systemFontOfSize:20];
    payMoneyLabel.textColor = ZCColor(219, 0, 0);
    payMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:payMoneyLabel];

    UILabel * cardInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.width * 0.40625 * 0.5+50 + self.frame.size.width*0.121875 + 10, self.frame.size.width-20, 20)];
    cardInfoLabel.text = _cardInfo;
    cardInfoLabel.font = [UIFont systemFontOfSize:15];
    cardInfoLabel.textColor = [UIColor lightGrayColor];
    cardInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:cardInfoLabel];

}

/** 注册keyboard通知 */
- (void)setupKeyboardNote
{
    // 删除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delete) name:ZCTradeKeyboardDeleteButtonClick object:nil];
    
    // 确定通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ok) name:ZCTradeKeyboardOkButtonClick object:nil];
    
    // 数字通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(number:) name:ZCTradeKeyboardNumberButtonClick object:nil];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 取消按钮 */
    self.cancleBtn.width = 18;
    self.cancleBtn.height = 18;
    self.cancleBtn.x = 15;
    self.cancleBtn.y = ZCScreenWidth * 0.03125;
    
    /** 确定按钮 */
//    self.okBtn.y = self.cancleBtn.y;
//    self.okBtn.width = self.cancleBtn.width;
//    self.okBtn.height = self.cancleBtn.height;
//    self.okBtn.x = CGRectGetMaxX(self.cancleBtn.frame) + ZCScreenWidth * 0.025;
}

#pragma mark - Private

// 删除
- (void)delete
{
    [self.nums removeLastObject];
    [self setNeedsDisplay];
}

// 数字
- (void)number:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    NSNumber *numObj = userInfo[ZCTradeKeyboardNumberKey];
    [self.nums addObject:numObj];
    [self setNeedsDisplay];

    if (self.nums.count == ZCTradeInputViewNumCount) {
        // 包装通知字典
        NSMutableString *pwd = [NSMutableString string];
        for (int i = 0; i < self.nums.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@", self.nums[i]];
            [pwd appendString:str];
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[ZCTradeInputViewPwdKey] = pwd;
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCTradeInputViewOkButtonClick object:self userInfo:dict];

    }
}

// 确定
- (void)ok
{
    
}

// 按钮点击
- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == ZCTradeInputViewButtonTypeWithCancle) {  // 取消按钮点击
        if ([self.delegate respondsToSelector:@selector(tradeInputView:cancleBtnClick:)]) {
            [self.delegate tradeInputView:self cancleBtnClick:btn];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCTradeInputViewCancleButtonClick object:self];
    } else if (btn.tag == ZCTradeInputViewButtonTypeWithOk) {  // 确定按钮点击
        if ([self.delegate respondsToSelector:@selector(tradeInputView:okBtnClick:)]) {
            [self.delegate tradeInputView:self okBtnClick:btn];
        }
        // 包装通知字典
        NSMutableString *pwd = [NSMutableString string];
        for (int i = 0; i < self.nums.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@", self.nums[i]];
            [pwd appendString:str];
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[ZCTradeInputViewPwdKey] = pwd;
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCTradeInputViewOkButtonClick object:self userInfo:dict];
    } else {
        
    }
}

- (void)drawRect:(CGRect)rect
{
    // 画图
    UIImage *field = [UIImage imageNamed:@"password_in"];
    
    
    CGFloat y = self.frame.size.width * 0.40625 * 0.5+50;
    CGFloat w = self.frame.size.width * 0.846875;
    CGFloat h = self.frame.size.width * 0.121875;
    CGFloat x = (self.frame.size.width - w)/2;
    [field drawInRect:CGRectMake(x, y, w, h)];
    
    
    
    // 画点
    UIImage *pointImage = [UIImage imageNamed:@"payYuan"];
    CGFloat pointW = self.frame.size.width * 0.05;
    CGFloat pointH = pointW;
    CGFloat pointY = self.frame.size.width * 0.24 + 50;
    CGFloat pointX;
    CGFloat margin = self.frame.size.width * 0.0484375 + 10;
    CGFloat padding = self.frame.size.width * 0.045578125;
    for (int i = 0; i < self.nums.count; i++) {
        pointX = margin + padding + i * (pointW + 2 * padding);
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }
    
    // ok按钮状态
    BOOL statue = NO;
    if (self.nums.count == ZCTradeInputViewNumCount) {
        statue = YES;
    } else {
        statue = NO;
    }
    self.okBtn.enabled = statue;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
