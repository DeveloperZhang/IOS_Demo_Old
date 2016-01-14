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

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief post请求
 *
 *  @param path         相对路径
 *  @param param        参数
 *  @param succeedBlock 成功回调
 *  @param failedBlock  失败回调
 */
- (void)postRequestWithPath:(NSString *)path param:(id)param succeedBlock:(NetSucceedBlock) succeedBlock failedBlock:(NetFailedBlock) failedBlock;

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 取消请求
 *
 *  @param path 相对路径
 */
- (void)cancelTaskWithPath:(NSString *)path;

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 取消所有请求
 */
- (void)cancelAllTasks;

@end
