//
//  ViewController.m
//  20160223_DrawDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"
#import "PointView.h"

@interface ViewController ()
{
    UIBezierPath * _curve;
    CAShapeLayer * _shapeLayer;
    NSMutableArray * _pointViewArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pointViewArray = [[NSMutableArray alloc]init];
    ViewController * __weak weakSelf = self;
    for (int i = 0; i < 3; i++) {
        
        PointView * pointView = [PointView aInstance];
        
        pointView.center = CGPointMake(i * 60 + 30, 400);
        pointView.dragCallBack = ^(PointView * pv){
            
            ViewController * __strong strongSelf = weakSelf;
            [strongSelf changePoint];
        };
        
        [self.view addSubview:pointView];
        [_pointViewArray addObject:pointView];
    }
    
    _curve = [UIBezierPath bezierPath];
    [_curve moveToPoint:((PointView *)_pointViewArray[0]).center];
    [_curve addQuadCurveToPoint:((PointView *)_pointViewArray[2]).center controlPoint:((PointView *)_pointViewArray[1]).center];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.lineWidth = 3;
    _shapeLayer.path = _curve.CGPath;
    _shapeLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:_shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changePoint {
    [_curve removeAllPoints];
    int count1 = 0;
    for (PointView * pointView in _pointViewArray) {
        count1++;
        if (count1 == 2) {
            NSLog(@"%d:%f,%f",count1,pointView.center.x,pointView.center.y);
        }
    }
    [_curve moveToPoint:((PointView *)_pointViewArray[0]).center];
    [_curve addQuadCurveToPoint:((PointView *)_pointViewArray[2]).center
                   controlPoint:((PointView *)_pointViewArray[1]).center];
    _shapeLayer.path = _curve.CGPath;
}
- (IBAction)action:(id)sender {
    [_shapeLayer removeFromSuperlayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.duration = 3.0f;
    [_shapeLayer addAnimation:animation forKey:@"myStroke"];
    [self.view.layer addSublayer:_shapeLayer];
}

@end
