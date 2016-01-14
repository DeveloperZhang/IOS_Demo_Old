//
//  ZYNetWorking.m
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "ZYNetWorking.h"
#import "UserModel.h"

@implementation ZYNetWorking

- (void)postRequestWithParam:(id)param succeedBlock:(NetSucceedBlock) succeedBlock failedBlock:(NetFailedBlock) failedBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"请求数据ING...");
        sleep(2);
        NSDictionary *dic = @{@"userName":@"Jim",@"userId":@1};
        if (dic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                succeedBlock(dic);
            });
        }
        
    });
}


@end
