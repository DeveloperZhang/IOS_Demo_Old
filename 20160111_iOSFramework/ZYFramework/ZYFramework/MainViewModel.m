//
//  MainViewModel.m
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "MainViewModel.h"
#import "ZYNetWorking.h"
#import "UserModel.h"

@interface MainViewModel ()

@property (strong,nonatomic) UserModel *userModel;

@end

@implementation MainViewModel

- (void)fetchUserWithParam:(id)param succeedBlock:(void(^)(NSString *returnValue)) succeedBlock failedBlock:(void(^)(id errorCode)) failedBlock
{
    ZYNetWorking *net = [[ZYNetWorking alloc] init];
    [net postRequestWithParam:param succeedBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[NSDictionary class]]) {
            UserModel *userModel = [[UserModel alloc] init];
            userModel.userId = [returnValue[@"userId"] integerValue];
            userModel.userName = returnValue[@"userName"];
            self.userName = userModel.userName;
            succeedBlock(self.userName);
        }
    }
    failedBlock:failedBlock];
}

@end
