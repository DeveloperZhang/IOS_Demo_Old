//
//  MainViewModel.h
//  ZYMVVMDemo
//
//  Created by zhangyu on 16/1/12.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHandler.h"

@interface MainViewModel : NSObject

@property (nonatomic,readonly) BaseHandler *handler;

@property (copy,nonatomic) NSString *name;

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 获得name
 *
 *  @param param 参数
 */
- (void)fetchNameWithParam:(id)param;

/*!
 *  @author Zhang Yu, 2016-01-12
 *
 *  @brief 取消请求
 */
- (void)cancelFetchName;

@end
