//
//  SecondViewController.m
//  20160302_CATransformDemo
//
//  Created by ZhangYu on 16/3/3.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () {
    float angle;
}


@property (weak, nonatomic) IBOutlet UIView *containerV;
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;
@property (weak, nonatomic) IBOutlet UIView *v4;
@property (weak, nonatomic) IBOutlet UIView *v5;
@property (weak, nonatomic) IBOutlet UIView *v6;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1/500;
    angle =  -M_PI/4;
    
    CATransform3D trans2 = CATransform3DTranslate(trans, 0, 0, 50);
    self.v1.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, 50, 0, 0);
    trans2 = CATransform3DRotate(trans2, M_PI_2 , 0 , 1 , 0);
    self.v2.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, 0, -50, 0);
    trans2 = CATransform3DRotate(trans2, M_PI_2 , 1 , 0 , 0);
    self.v3.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, 0, 50, 0);
    trans2 = CATransform3DRotate(trans2, (-M_PI_2) , -1 , 0 , 0);
    self.v4.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, -50, 0, 0);
    trans2 = CATransform3DRotate(trans2, (-M_PI_2) , 0 , 1 , 0);
    self.v5.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, -50, 0, 0);
    trans2 = CATransform3DRotate(trans2, - M_PI_2 , 0 , 1 , 0);
    self.v5.layer.transform = trans2;
    
    trans2 = CATransform3DTranslate(trans, 0, 0, -50);
    
    trans = CATransform3DRotate(trans2, M_PI, 0, 1, 0);
    self.v6.layer.transform = trans2;
    
    trans = CATransform3DRotate(trans, angle , 0, 1 , 0);
    trans = CATransform3DRotate(trans, angle , 1, 0 , 0);
    self.containerV.layer.sublayerTransform = trans;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.containerV addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    CGPoint p =  [sender translationInView:self.containerV];
    float angel1 = angle + (p.x / 30);
    float angel2 = angle - (p.y / 30);
    
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1 / 500;
    trans = CATransform3DRotate(trans, angel1 , 0, 1 , 0);
    trans = CATransform3DRotate(trans, angel2 , 1, 0 , 0);
    self.containerV.layer.sublayerTransform = trans;
}




@end
