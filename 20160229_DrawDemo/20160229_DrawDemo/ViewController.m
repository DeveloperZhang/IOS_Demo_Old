//
//  ViewController.m
//  20160229_DrawDemo
//
//  Created by ZhangYu on 16/2/29.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)drawAction:(id)sender {
//    [self drawCircle1];
//    [self drawCircle2];
//    [self drawCur];
//    [self drawMutable];
    
}




- (void)drawMutable {
    CGSize finalSize = CGSizeMake(CGRectGetWidth(self.view.frame), 400);
    float layerHeight = finalSize.height * 0.2;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [path addLineToPoint:CGPointMake(0, finalSize.height - 1)];
    [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
    [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - layerHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, finalSize.height - layerHeight) controlPoint:CGPointMake(finalSize.width/2, (finalSize.height - layerHeight) - 40)];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:layer];
}


- (void)drawCircle1 {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 50, 50)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:layer];
}

- (void)drawCircle2 {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:30 startAngle:0 endAngle:M_PI clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:layer];
}

- (void)drawCur {
    CGPoint startPoint = CGPointMake(50, 100);
    CGPoint endPoint = CGPointMake(300, 300);
    CGPoint controlPoint = CGPointMake(150, 400);
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
    layer2.backgroundColor = [UIColor redColor].CGColor;
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer3.backgroundColor = [UIColor redColor].CGColor;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
    [self.view.layer addSublayer:shapeLayer];

    [self animation3:shapeLayer];
}

- (void)animation1:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.duration = 2.0;
    [layer addAnimation:animation forKey:@"DrawCur"];
}

- (void)animation2:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.fromValue = [NSNumber numberWithFloat:0.5];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.duration = 2.0;
    [layer addAnimation:animation forKey:@"DrawCur"];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.fromValue = [NSNumber numberWithFloat:0.5];
    animation1.toValue = [NSNumber numberWithFloat:1.0];
    animation1.duration = 2.0;
    [layer addAnimation:animation1 forKey:@"DrawCurEnd"];
}

- (void)animation3:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:10.0];
    animation.duration = 2.0;
    [layer addAnimation:animation forKey:@"DrawCurWidth"];
}

@end
