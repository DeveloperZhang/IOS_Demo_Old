//
//  ZYNetWorking.m
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "ZYNetWorking.h"
#import "ZYAFNetworking.h"
#import "UserModel.h"

@interface ZYNetWorking ()

@property (nonatomic) NSMutableDictionary *taskDic;

@end

@implementation ZYNetWorking

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)postRequestWithPath:(NSString *)path param:(id)param succeedBlock:(NetSucceedBlock) succeedBlock failedBlock:(NetFailedBlock) failedBlock
{
    /*
     *模拟请求
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"请求数据ING...");
        sleep(2);
        self.userModel.userId = 1;
        self.userModel.userName = @"Vicent_Z";
        if (self.userModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                succeedBlock(self.userModel);
            });
        }
    });
     */
    NSURLSessionDataTask *task = [[ZYAFNetworking sharedInstance] POST:path param:param userInfo:nil success:^(NSURLSessionDataTask *task, id obj) {
        [self.taskDic removeObjectForKey:@"json"];
        NSLog(@"thread--->%@",[NSThread currentThread]);
        NSError *err = nil;
        UserModel *userModel = [[UserModel alloc] initWithDictionary:obj[@"users"][0] error:&err];
        succeedBlock(userModel);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.taskDic removeObjectForKey:@"json"];
    }];
    [self.taskDic setObject:task forKey:@"json"];
}

- (void)cancelTaskWithPath:(NSString *)path
{
    if ([self.taskDic[path] isKindOfClass:[NSURLSessionDataTask class]]) {
        NSURLSessionDataTask *cancelTask = self.taskDic[path];
        [cancelTask cancel];
        [self.taskDic[path] removeObjectForKey:path];
    }
}

- (void)cancelAllTasks
{
    [self.taskDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self cancelTaskWithPath:key];
    }];
}

#pragma mark -setter/getter
- (NSMutableDictionary *)taskDic
{
    if (_taskDic) {
        _taskDic = [[NSMutableDictionary alloc] init];
    }
    return _taskDic;
}

@end
