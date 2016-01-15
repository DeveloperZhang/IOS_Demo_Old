//
//  ViewController.m
//  ZYFramework
//
//  Created by zhangyu on 16/1/11.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"

@interface MainViewController ()

@property (strong,nonatomic) MainViewModel *mainViewModel;

@end

@implementation MainViewController

#pragma mark -Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Test commit");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadViewWithModel:self.mainViewModel];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -Custom Methods

- (void)loadViewWithModel:(MainViewModel *)model
{
    if ([self.mainViewModel.userName length]) {
        self.userNameTf.text = self.mainViewModel.userName;
    }
    else
    {
        [self.mainViewModel fetchUserWithParam:nil succeedBlock:^(NSString *returnValue) {
            NSLog(@"%s-->returnValue:%@",__func__,returnValue);
            if ([returnValue length]) {
                self.userNameTf.text = self.mainViewModel.userName;
            }
        } failedBlock:^(id errorCode) {
            NSLog(@"%s-->errorCode:%@",__func__,errorCode);
        }];
    }
}


#pragma mark -Setter Methods
- (MainViewModel *)mainViewModel
{
    if (!_mainViewModel) {
        _mainViewModel = [[MainViewModel alloc] init];
    }
    return _mainViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
