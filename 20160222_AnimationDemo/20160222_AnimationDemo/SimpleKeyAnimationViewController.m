//
//  SimpleKeyAnimationViewController.m
//  20160222_AnimationDemo
//
//  Created by ZhangYu on 16/2/22.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "SimpleKeyAnimationViewController.h"

@interface SimpleKeyAnimationViewController () {
    CALayer *_layer;
}

@end

@implementation SimpleKeyAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"petal"].CGImage);
    [self.view.layer addSublayer:_layer];
    
//    [self translationAnimation];
    [self groupAnimation];
}

#pragma mark 基础旋转动画
-(CABasicAnimation *)rotationAnimation{
    
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    CGFloat toValue=M_PI_2*3;
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    
    //    basicAnimation.duration=6.0;
    basicAnimation.autoreverses=true;
    basicAnimation.repeatCount=HUGE_VALF;
    basicAnimation.removedOnCompletion=NO;
    
    [basicAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];
    
    return basicAnimation;
}

#pragma mark 关键帧移动动画
-(CAKeyframeAnimation *)translationAnimation{
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint endPoint= CGPointMake(55, 400);
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    
    keyframeAnimation.path=path;
    CGPathRelease(path);
    
    
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];
    
    return keyframeAnimation;
}

#pragma mark 创建动画组
-(void)groupAnimation{
    //1.创建动画组
    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
    
    //2.设置组中的动画和其他属性
    CABasicAnimation *basicAnimation=[self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation=[self translationAnimation];
    animationGroup.animations=@[basicAnimation,keyframeAnimation];
    
    animationGroup.delegate=self;
    animationGroup.duration=10.0;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    animationGroup.beginTime=CACurrentMediaTime()+1;//延迟五秒执行
    
    //3.给图层添加动画
    [_layer addAnimation:animationGroup forKey:nil];
}

#pragma mark - 代理方法
#pragma mark 动画完成
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CAAnimationGroup *animationGroup=(CAAnimationGroup *)anim;
    CABasicAnimation *basicAnimation=(CABasicAnimation *)animationGroup.animations[0];
    CAKeyframeAnimation *keyframeAnimation=(CAKeyframeAnimation *)animationGroup.animations[1];
    CGFloat toValue=[[basicAnimation valueForKey:@"KCBasicAnimationProperty_ToValue"] floatValue];
    CGPoint endPoint=[[keyframeAnimation valueForKey:@"KCKeyframeAnimationProperty_EndPosition"] CGPointValue];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    //设置动画最终状态
    _layer.position=endPoint;
    _layer.transform=CATransform3DMakeRotation(toValue, 0, 0, 1);
    
    [CATransaction commit];
}

//- (void)translationAnimation {
//    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    
//    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];
//    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
//    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
//    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(55, 400)];
//    keyFrameAnimation.values = @[key1,key2,key3,key4];
//    keyFrameAnimation.duration = 3;
//    keyFrameAnimation.beginTime = CACurrentMediaTime() + 1;
//    keyFrameAnimation.removedOnCompletion = NO;
//    [_layer addAnimation:keyFrameAnimation forKey:@"KCKeyframeAnimation_Position"];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
