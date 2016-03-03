//
//  AFHTTPClient.m
//  inKer
//
//  Created by 杨志达 on 14-10-24.
//  Copyright (c) 2014年 Zhi Da Yang. All rights reserved.
//

#import "AFHTTPClient.h"

#import "DistributeChannels.h"

static NSString * const AFAppDotNetAPIBaseURLString = URL_HOST;

@implementation AFHTTPClient

+ (instancetype)sharedClient
{
    static AFHTTPClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        _sharedClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.requestSerializer setTimeoutInterval:30];
        
        [_sharedClient.requestSerializer setValue:@"application/json"
                               forHTTPHeaderField:@"Accept"];
        
        NSString *userAgentValue = [NSString stringWithFormat:@"iOS %@-%@",UIDevice.currentDevice.systemVersion,[DistributeChannels DistributeChannels:DistributeAppStore]];
        
        ZDLog(@"%@",userAgentValue);
        
        [_sharedClient.requestSerializer setValue:userAgentValue
                               forHTTPHeaderField:@"User-Agent"];
        
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    });
    
    return _sharedClient;
}

@end

@implementation AFHTTPClientUpload

static NSString *baseUrl = @"http://localhost:8080/FileOperaionDemo";

+ (instancetype)sharedClient
{
    static AFHTTPClientUpload *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[AFHTTPClientUpload alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
        _sharedInstance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedInstance.requestSerializer setTimeoutInterval:30];
        
        [_sharedInstance.requestSerializer setValue:@"application/json"
                               forHTTPHeaderField:@"Accept"];
        
        NSString *userAgentValue = [NSString stringWithFormat:@"iOS %@-%@",UIDevice.currentDevice.systemVersion,[DistributeChannels DistributeChannels:DistributeAppStore]];
        
        ZDLog(@"%@",userAgentValue);
        
        [_sharedInstance.requestSerializer setValue:userAgentValue
                               forHTTPHeaderField:@"User-Agent"];
        
        _sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    });
    
    return _sharedInstance;
}

///
/// 上传图片
- (AFHTTPRequestOperation *)uploadImageWithUrl:(NSString *)url
                                         image:(UIImage *)image
                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *wholeUrl = [NSString stringWithFormat:@"%@%@",baseUrl,url];
    AFHTTPRequestOperation *op = [self POST:wholeUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"myFile" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    return op;  
}

@end



