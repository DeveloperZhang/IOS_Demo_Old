//
//  SimpleDrawViewController.m
//  20160222_AnimationDemo
//
//  Created by ZhangYu on 16/2/22.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "SimpleDrawViewController.h"

#define PHOTO_HEIGHT 150

@interface SimpleDrawViewController () {
    CALayer *layer;
}

@end

@implementation SimpleDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT/2;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor blueColor].CGColor;
    layer.borderWidth = 2;
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    
    //沿x翻转
    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    [layer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    
    //沿x翻转
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"header.jpg"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    CGContextRestoreGState(ctx);
    
}

- (void)dealloc {
    //销毁代理
    layer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
