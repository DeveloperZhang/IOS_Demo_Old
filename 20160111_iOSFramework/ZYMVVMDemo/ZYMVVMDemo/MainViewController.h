//
//  ViewController.h
//  ZYMVVMDemo
//
//  Created by zhangyu on 16/1/12.
//  Copyright © 2016年 Developer_Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
- (IBAction)requestAction:(id)sender;
- (IBAction)cancelRequest:(id)sender;

@end

