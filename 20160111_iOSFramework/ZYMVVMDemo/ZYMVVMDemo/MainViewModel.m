//
//  MainViewModel.m
//  ZYMVVMDemo
//
//  Created by zhangyu on 16/1/12.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "MainViewModel.h"
#import "UserModel.h"

@interface MainViewModel ()

@property (nonatomic) BaseHandler *handler;

@end

@implementation MainViewModel

- (void)fetchNameWithParam:(id)param
{
    NSLog(@"模拟请求数据---》参数：%@",param);
    [self.handler fetchUserWithParam:param completionBlock:^(id error, id content) {
        if ([content isKindOfClass:[UserModel class]]) {
            NSLog(@"content--->%@",content);
            self.name = ((UserModel *)content).loginname;
        }
    }];
}

- (void)cancelFetchName
{
    [self.handler cancelFetchUser];
}

- (BaseHandler *)handler {
    if (!_handler) {
        _handler = [[BaseHandler alloc] init];
    }
    return _handler;
}

@end
