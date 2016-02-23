//
//  ViewController.m
//  20160223_JHChainableAnimationDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"
#import "JHChainableAnimations.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)animationAction:(id)sender {
    
//    self.myView.makeFrame(CGRectMake(100, 100, 60, 60)).animate(1.0);
//    self.myView.makeBorderWidth(2.0).bounce.animate(2.0);
//    self.myView.makeScale(2).animate(1.0);
//      self.myView.moveWidth(10).animate(1.0);
    //角度
//    self.myView.rotate(90).animate(1.0);
    //沿着100角度移动30
//    self.myView.movePolar(30, 100).animate(1.0);
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:self.myView.center];
//    [path addLineToPoint:CGPointMake(200, 200)];
    //沿着路线移动
//    self.myView.moveOnPath(path).animate(1.0);
    //朝着移动的方向旋转
//    self.myView.moveAndRotateOnPath(path).animate(1.0);
//    self.myView.moveAndReverseRotateOnPath(path).animate(1.0);
    //    self.myView.transformScale(2).animate(1.0);
    self.myView.animationCompletion = JHAnimationCompletion() {
        NSLog(@"Animation Completion");
        self.btn.moveY(-self.btn.frame.size.height).animate(1);
    };
    
    self.myView.transformX(100).bounce.spring.thenAfter(2.0).transformY(100).animate(1.0);
    self.btn.moveY(self.btn.frame.size.height).animate(3);
}

@end
