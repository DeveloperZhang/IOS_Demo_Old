//
//  ZYAFNetworking.m
//  ZYAFNetworking
//
//  Created by zhangyu on 16/1/7.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "ZYAFNetworking.h"
#import "AFHTTPSessionManager.h"

@implementation ZYAFNetworking


#pragma mark--设置环境
- (void)initHost
{
    //可以通过环境变量动态设置host
    /*
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString *hostTag = [def objectForKey:@"hostSetting"];
    if ([hostTag isEqualToString:@"Product"]){
        self.host = DEV_HOST;
        self.webHost = DEV_WEBHOST;
    }
    else
    {
        self.host = HOST;
        self.webHost = WEBHOST;
    }
    */
    
    self.host = ZHost;
    self.webHost = ZWebHost;
}

+(instancetype)sharedInstance {
    static ZYAFNetworking *singleton = nil;
    if (! singleton) {
        singleton = [[self alloc] initPrivate];
    }
    return singleton;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"这个是个单例"
                                   reason:@"应该这样调用 [ZYAFNetworking sharedInstance]"
                                 userInfo:nil];
    return nil;
}

//实现自己真正的私有初始化方法
- (instancetype)initPrivate {
    self  = [super init];
    //初始化操作
    if (self) {
        [self initHost];
    }
    return self;
}

- (NSURL*)url:(NSString*) path
{
    return [NSURL URLWithString:[self urlString:path]];
}

- (NSString*)urlString:(NSString*) path
{
    return [NSString stringWithFormat:@"%@/%@",_host,path];
}

- (NSURLSessionDataTask *)POST:(NSString*) path param:(NSDictionary*) param userInfo:(id) userinfo success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))successBlock failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //声明failBlock
    void (^failureBlock)(NSURLSessionDataTask *, NSError *);
    
    if (failure) {
        failureBlock = failure;
    }
    else
    {
        failureBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSLog(@"%s%@",__func__,error);
        };
    }
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    return [session POST:[self urlString:path] parameters:param progress:nil success:successBlock failure:failureBlock];
}


@end
