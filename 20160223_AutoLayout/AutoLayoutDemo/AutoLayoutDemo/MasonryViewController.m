//
//  MasonryViewController.m
//  AutoLayoutDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "MasonryViewController.h"
#import "Masonry.h"

@interface MasonryViewController ()

@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UILabel *label2;

- (IBAction)animationAction:(id)sender;
@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.label];
    [self.view addSubview:self.label2];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(100, 0, 0, 0);
    UIView *superview = self.label.superview;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding.top);
        make.left.equalTo(superview.mas_left).with.offset(padding.left);
        make.right.equalTo(superview.mas_right).with.offset(-padding.right);
        make.height.mas_equalTo(28);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_top).with.offset(padding.top);
        make.left.equalTo(self.label.mas_left).with.offset(padding.left);
        make.right.equalTo(self.label.mas_right).with.offset(-padding.right);
        make.height.equalTo(self.label.mas_height);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animationAction:(id)sender {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(64, 0, 0, 0);
    UIView *superview = self.label.superview;
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding.top);
    }];
    
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {

    }];
}

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
