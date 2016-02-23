//
//  VFLMethodViewController.m
//  AutoLayoutDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "VFLMethodViewController.h"

@interface VFLMethodViewController () {
    NSArray* vConstraintArray;
}

@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UILabel *label2;

@end

@implementation VFLMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.label];
    [self.view addSubview:self.label2];
    
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    //水平方向上，label左侧与父视图左侧对齐，label右侧与父视图右侧对齐
    NSArray* hConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label": self.label}];
    [NSLayoutConstraint activateConstraints:hConstraintArray];
    
    //垂直方向上，label顶部与父视图顶部对齐
    vConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[label(28)]" options:0 metrics:nil views:@{@"label": self.label}];
    [NSLayoutConstraint activateConstraints:vConstraintArray];
    
    
    self.label2.translatesAutoresizingMaskIntoConstraints = NO;
    //水平方向上，label左侧与父视图左侧对齐，label右侧与父视图右侧对齐
    NSArray* hConstraintArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label2]-0-|" options:0 metrics:nil views:@{@"label2": self.label2}];
    [NSLayoutConstraint activateConstraints:hConstraintArray2];
    
    //垂直方向上，label2顶部与label视图底部相距100
    NSArray* vConstraintArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-100-[label2(28)]" options:0 metrics:nil views:@{@"label":self.label,@"label2": self.label2}];
    [NSLayoutConstraint activateConstraints:vConstraintArray2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animationAction:(id)sender {
    NSLayoutConstraint *constraint = vConstraintArray[0];
    constraint.constant = 64;
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
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
