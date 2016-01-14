//
//  ZYNetWorking.h
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义返回请求数据的block类型
typedef void (^NetSucceedBlock) (id returnValue);
typedef void (^NetFailedBlock) (id errorCode);

@interface ZYNetWorking : NSObject

- (void)postRequestWithParam:(id)param succeedBlock:(NetSucceedBlock) succeedBlock failedBlock:(NetFailedBlock) failedBlock;

@end
