//
//  ViewController.m
//  20160223_PINCacheDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"
#import "PINCache.h"

#define CACHESTR @"cacheStr"

@interface ViewController ()

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
- (IBAction)getCacheAction:(id)sender {
    PINMemoryCache *cache = [PINMemoryCache sharedCache];
    cache.costLimit = 1;
    if ([cache objectForKey:CACHESTR]) {
        NSLog(@"cache1 %@",[cache objectForKey:CACHESTR]);
    }else {
        NSLog(@"cache1未存储,存储中...");
        [cache setObject:@"testStr" forKey:CACHESTR];
    }
    
    PINDiskCache *cache2 = [PINDiskCache sharedCache];
    if ([cache2 objectForKey:CACHESTR]) {
        NSLog(@"cache2 %@",[cache2 objectForKey:CACHESTR]);
    }else {
        NSLog(@"cache2未存储,存储中...");
        [cache2 setObject:@"testStr" forKey:CACHESTR];
    }
    
    PINCache *cache3 = [PINCache sharedCache];
    if ([cache3 objectForKey:CACHESTR]) {
        NSLog(@"cache3 %@",[cache2 objectForKey:CACHESTR]);
    }else {
        NSLog(@"cache3未存储,存储中...");
        [cache3 setObject:@"testStr" forKey:CACHESTR];
    }
    
    
    NSLog(@"111");
    
}

@end
