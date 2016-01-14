//
//  ZYAFNetworking.h
//  ZYAFNetworking
//
//  Created by zhangyu on 16/1/7.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//host
#define ZHost @"http://localhost:8080/TestWebDemo"
#define ZWebHost @"http://localhost:8080/TestWebDemo"

@interface ZYAFNetworking : NSObject

//api网络请求前缀
@property (nonatomic,copy) NSString *host;
//h5请求前缀
@property (nonatomic,copy) NSString *webHost;

/*!
 *  @author Zhang Yu, 2016-01-08
 *
 *  @brief 单例方法
 *
 *  @return 单例对象
 */
+(instancetype)sharedInstance;
/*!
 *  @author Zhang Yu, 2016-01-07
 *
 *  @brief 通过全局host和path构建url
 *
 *  @param path url相对路径
 *
 *  @return 整个url字符串对应的NSURL
 */
- (NSURL*)url:(NSString*) path;
/*!
 *  @author Zhang Yu, 2016-01-07
 *
 *  @brief 通过全局host和path构建urlString
 *
 *  @param path url相对路径
 *
 *  @return 整个url字符串
 */
- (NSString*)urlString:(NSString*) path;
/*!
 *  @author Zhang Yu, 2016-01-07
 *
 *  @brief POST网络请求通用方法
 *
 *  @param path         请求的相对路径
 *  @param param        参数
 *  @param userinfo     info
 *  @param successBlock 成功回调
 *  @param failure      失败回调
 */
- (NSURLSessionDataTask *)POST:(NSString*) path param:(NSDictionary*) param userInfo:(id) userinfo success:(void (^)(NSURLSessionDataTask * task, id obj))successBlock failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
