//
//  SimpleAddAnimationViewController.m
//  20160222_AnimationDemo
//
//  Created by ZhangYu on 16/2/22.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "SimpleAddAnimationViewController.h"

@interface SimpleAddAnimationViewController () {
    CALayer *_layer;
}

@end

@implementation SimpleAddAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"petal"].CGImage);
    [self.view.layer addSublayer:_layer];
}

- (void)translationAnimation:(CGPoint)location {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    basicAnimation.duration = 5.;
    basicAnimation.delegate = self;
    basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

#pragma mark 旋转动画
-(void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画属性初始值、结束值
//    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
//    [basicAnimation setValue:[NSNumber numberWithFloat:M_PI_2*3] forKey:@"KCBasicAnimationRotation"];
    //设置其他动画属性
    basicAnimation.duration=6.0;
    basicAnimation.autoreverses=true;//旋转后在旋转到原来的位置
    basicAnimation.repeatCount=HUGE_VALF;//设置无限循环
    basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation= [_layer animationForKey:@"KCBasicAnimation_Translation"];
    if(animation){
        if (_layer.speed==0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建并开始动画
        [self translationAnimation:location];
        
        [self rotationAnimation];
    }
}

#pragma mark 动画暂停
-(void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval=[_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    _layer.speed=0;
}

#pragma mark 动画恢复
-(void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime= CACurrentMediaTime()-_layer.timeOffset;
    //设置偏移量
    _layer.timeOffset=0;
    //设置开始时间
    _layer.beginTime=beginTime;
    //设置动画速度，开始运动
    _layer.speed=1.0;
}

#pragma mark - 动画代理方法
#pragma mark 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}

#pragma mark 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    //提交事务
    [CATransaction commit];
    //暂停动画
    [self animationPause];
}

@end