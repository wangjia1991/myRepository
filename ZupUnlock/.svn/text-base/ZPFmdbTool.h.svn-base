//
//  ZPFmdbTool.h
//  手势密码解锁
//
//  Created by lianghuigui on 16-04-20.
//  Copyright (c) 2016年 lianghuigui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface ZPFmdbTool : NSObject

@property(nonatomic,strong)FMDatabaseQueue *dbQ;

+ (instancetype)sharedDatabaseQueue;

//插入密码数据
- (void)insertPassword:(NSString *)str;

//删除密码数据
- (void)deletelastPassword;
//查询密码数据
- (NSString *)querylastPassword;


@end
