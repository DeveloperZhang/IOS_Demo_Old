//
//  ViewController.m
//  UIViewControllerDemo
//
//  Created by zhangyu on 15/12/3.
//  Copyright © 2015年 Developer_Zhang. All rights reserved.
//

#import "ViewController.h"

#define LogFunc NSLog(@"%s",__func__)

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    //1.继承父类 OK
//    [super loadView];
    //2.自定义 OK
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor grayColor];
    self.view = view;
    LogFunc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LogFunc;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    LogFunc;
}

- (void)viewWillDisappear:(BOOL)animated
{
    LogFunc;
    [super viewWillDisappear:animated];
    //wrong already disapper
    LogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //模拟内存不足:模拟器->hardware->内存警告 选项
    LogFunc;
}

@end
