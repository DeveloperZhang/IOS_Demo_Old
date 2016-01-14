//
//  UserModel.h
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface UserModel : JSONModel

@property (copy,nonatomic) NSString *loginname;//用户名
@property (copy,nonatomic) NSString *password;//密码
@property (copy,nonatomic) NSString *email;//用户邮箱

@end
