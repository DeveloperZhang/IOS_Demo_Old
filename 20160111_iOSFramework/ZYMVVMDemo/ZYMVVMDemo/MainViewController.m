//
//  ViewController.m
//  ZYMVVMDemo
//
//  Created by zhangyu on 16/1/12.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "FBKVOController.h"

@interface MainViewController ()

@property (strong, nonatomic) MainViewModel *mainViewModel;

@end

@implementation MainViewController

#pragma mark -life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleModelViewUpdate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.KVOController removeObserver:self.mainViewModel forKeyPath:@"name"];
    [self.KVOController removeObserver:self.mainViewModel forKeyPath:@"handler.result.requestState"];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -event action
- (IBAction)requestAction:(id)sender {
    [self loadViewWithViewModel];
}

- (IBAction)cancelRequest:(id)sender {
    [self.mainViewModel cancelFetchName];
}

#pragma mark -custom method
- (void)handleModelViewUpdate
{
    __weak typeof(self) weakSelf = self;
    
    [self.KVOController observe:self.mainViewModel keyPath:@"name" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = weakSelf;
        id newValue = change[NSKeyValueChangeNewKey];
        if (![newValue isKindOfClass:[NSNull class]]){
            NSLog(@"请求结果--》%@",newValue);
            strongSelf.nameLb.text = newValue;
        }
    }];
    
    [self.KVOController observe:self.mainViewModel keyPath:@"handler.result.requestState" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//        __strong typeof(self) strongSelf = weakSelf;
        BaseHandlerResult *result = self.mainViewModel.handler.result;
        NSLog(@"result.content-->%@",result.content);
        id newValue = change[NSKeyValueChangeNewKey];
        if (newValue > 0) {
            switch ([newValue integerValue]) {
                case RequestStateSucceed:
                {
                    NSLog(@"成功");
                }
                    break;
                case RequestStateExecuting:
                {
                    NSLog(@"执行中");
                }
                    break;
                case RequestStateFailed:
                {
                    NSLog(@"失败");
                }
                    break;
                case RequestStateCanceled:
                {
                    NSLog(@"取消");
                }
                    break;
                default:
                    break;
            }
        }
    }];
}

- (void)loadViewWithViewModel
{
    [self.mainViewModel fetchNameWithParam:@{@"username":@"Vicent_Z",@"pwd":@"123456"}];
}

#pragma mark -setter
- (MainViewModel *)mainViewModel
{
    if (!_mainViewModel) {
        _mainViewModel = [[MainViewModel alloc] init];
    }
    return _mainViewModel;
}
@end
