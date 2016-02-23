//
//  SimpleAnimationViewController.m
//  20160222_AnimationDemo
//
//  Created by ZhangYu on 16/2/22.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "SimpleAnimationViewController.h"

#define WIDTH 60

@interface SimpleAnimationViewController ()

@end

@implementation SimpleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SimpleAnimationViewController");
    [self drawLayer];
}

- (void)drawLayer {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    layer.cornerRadius = WIDTH/2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 9;
    [self.view.layer addSublayer:layer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CALayer *layer = [self.view.layer.sublayers lastObject];
    CGFloat width = layer.bounds.size.width;
    if (width == WIDTH) {
        width = WIDTH * 4;
    }else{
        width = WIDTH;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width/2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
