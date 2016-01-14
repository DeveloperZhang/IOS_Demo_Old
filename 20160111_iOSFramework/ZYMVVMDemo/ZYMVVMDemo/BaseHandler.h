//
//  BaseHandler.h
//  ZYMVVMDemo
//
//  Created by zhangyu on 16/1/12.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 成功回调
 *
 *  @param error   错误信息
 *  @param content 返回内容
 */
typedef void(^HandlerCompletionBlock) (id error,id content);
/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 取消回调
 */
typedef void(^HandlerCancelBlock)(void);


typedef NS_ENUM(NSInteger, RequestState)
{
    RequestStateSucceed = 1,//成功
    RequestStateExecuting = 2,//请求中
    RequestStateFailed = 3,//失败
    RequestStateCanceled = 4 //取消
};
/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 请求结果
 */
@interface BaseHandlerResult : NSObject

@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) id content;
@property (nonatomic, readonly) RequestState requestState;

- (instancetype)initWithError:(NSError *)error content:(id)content;

@end

@interface BaseHandler : NSObject

@property (nonatomic ,readonly) BaseHandlerResult *result;

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 获得用户数据
 *
 *  @param param           参数
 *  @param completionBlock 成功回调
 */
- (void)fetchUserWithParam:(id)param completionBlock:(HandlerCompletionBlock)completionBlock;

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 取消获取用户数据请求
 */
- (void)cancelFetchUser;

@end


