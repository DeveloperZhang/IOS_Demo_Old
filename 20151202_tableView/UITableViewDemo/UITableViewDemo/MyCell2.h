//
//  MyCell2.h
//  UITableViewDemo
//
//  Created by zhangyu on 15/12/3.
//  Copyright © 2015年 Developer_Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
- (IBAction)btnAction:(id)sender;

@end
