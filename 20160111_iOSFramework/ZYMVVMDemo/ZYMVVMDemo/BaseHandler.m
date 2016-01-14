//
//  BaseHandler.m
//  ZYMVVMDemo
//
//  Created by zhangyu on 16/1/12.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "BaseHandler.h"
#import "ZYNetWorking.h"

@interface BaseHandlerResult ()

@property (nonatomic) NSError *error;
@property (nonatomic) id content;
@property (nonatomic) RequestState requestState;

@end

@implementation BaseHandlerResult

- (instancetype)initWithError:(NSError *)error content:(id)content {
    self = [super init];
    if (!self) {
        return nil;
    }
    _error = error;
    _content = content;
    return self;
}

@end


@interface BaseHandler ()

@property (copy, nonatomic) HandlerCompletionBlock completionBlock;
@property (nonatomic) ZYNetWorking *netWorking;
@property (nonatomic) BaseHandlerResult *result;

@end

@implementation BaseHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result = [[BaseHandlerResult alloc] init];
    }
    return self;
}

- (void)fetchUserWithParam:(id)param completionBlock:(HandlerCompletionBlock)completionBlock
{
    self.result.requestState = RequestStateExecuting;
    //request
    [self.netWorking postRequestWithPath:@"json" param:param succeedBlock:^(id returnValue) {
        self.result.content = returnValue;
        self.result.requestState = RequestStateSucceed;
        if (completionBlock) {
            completionBlock(nil,returnValue);
        }
    } failedBlock:^(id errorCode) {
        self.result.error = errorCode;
        self.result.requestState = RequestStateFailed;
        completionBlock(@"error",nil);
    }];
}

- (void)cancelFetchUser
{
    self.result.requestState = RequestStateCanceled;
    [self.netWorking cancelTaskWithPath:@"json"];
}

- (ZYNetWorking *)netWorking {
    if (!_netWorking) {
        _netWorking = [[ZYNetWorking alloc] init];
    }
    return _netWorking;
}

- (BaseHandlerResult *)result {
    if (!_result) {
        _result = [[BaseHandlerResult alloc] init];
    }
    return _result;
}

@end
