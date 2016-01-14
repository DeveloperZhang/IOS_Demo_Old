//
//  MainViewModel.h
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MainViewModel : NSObject

@property (copy,nonatomic) NSString *userName;

- (void)fetchUserWithParam:(id)param succeedBlock:(void(^)(NSString *returnValue)) succeedBlock failedBlock:(void(^)(id errorCode)) failedBlock;

@end
