//
//  OldMethodViewController.m
//  AutoLayoutDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "OldMethodViewController.h"

@interface OldMethodViewController () {
    NSLayoutConstraint* topConstraint;
}

@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UILabel *label2;



@end

@implementation OldMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    [self.view addSubview:self.label2];
    
    //禁用AutoresizingMask自动转化autoLayout
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    //self.label左侧与父视图左侧对齐
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    //self.label顶部与父视图顶部对齐
    topConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    //self.label高度为父视图高度一半
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:28.0f];
    //self.label右侧与父视图右侧对齐
    NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:100.0f];
    
    //iOS 6.0或者7.0调用addConstraints
    [self.view addConstraints:@[leftConstraint, topConstraint, heightConstraint, widthConstraint]];
    //iOS 8.0以后设置active属性值
//    leftConstraint.active = YES;
//    widthConstraint.active = YES;
//    topConstraint.active = YES;
//    heightConstraint.active = YES;
    
    
    //禁用AutoresizingMask自动转化autoLayout
    self.label2.translatesAutoresizingMaskIntoConstraints = NO;
    //self.label左侧与父视图左侧对齐
    NSLayoutConstraint* leftConstraint2 = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:10.0f];
    //self.label顶部与父视图顶部对齐
    NSLayoutConstraint* topConstraint2 = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeTop multiplier:1.0f constant:10.0f];
    //self.label高度为父视图高度一半
    NSLayoutConstraint* heightConstraint2 = [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:28.0f];
    //self.label右侧与父视图右侧对齐
    NSLayoutConstraint* widthConstraint2= [NSLayoutConstraint constraintWithItem:self.label2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:100.0f];
    //iOS 6.0或者7.0调用addConstraints
    [self.view addConstraints:@[leftConstraint2, topConstraint2, heightConstraint2, widthConstraint2]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animationAction:(id)sender {
    topConstraint.constant = 64;
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"Test Label";
        _label.backgroundColor = [UIColor lightGrayColor];
    }
    return _label;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.text = @"Test Label_2";
        _label2.backgroundColor = [UIColor lightGrayColor];
    }
    return _label2;
}

@end
