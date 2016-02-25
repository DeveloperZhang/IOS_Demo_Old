//
//  ViewController.m
//  HttpManager
//
//  Created by ZhangYu on 16/2/24.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

- (IBAction)getAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getAction:(id)sender {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSURL *URL = [NSURL URLWithString:@"http://www.yinketong.org/openService/loan/investListV19?currentPageNum=1&limtNo=19&queryType=1&userId=40801"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}
@end
