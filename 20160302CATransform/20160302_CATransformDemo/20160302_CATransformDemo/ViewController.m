//
//  ViewController.m
//  20160302_CATransformDemo
//
//  Created by ZhangYu on 16/3/2.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
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

- (IBAction)transformAction:(id)sender {
    
    /*
    [UIView animateWithDuration:3 animations:^{
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
    }];
     */
//    self.imageView.layer.transform = CATransform3DMakeRotation(M_PI/6, 0, 0, 1);
    
    //3D旋转
    CATransform3D rotationTransform = CATransform3DIdentity;
    rotationTransform.m34 = -1.0f/500.0f;  //注意这里要在CATransform3DRotate前调用，否则看不效果（一般500-1000效果挺好）。
    rotationTransform = CATransform3DRotate(rotationTransform,M_PI/6, 1.0f, 0.0f, 0.0f);
    self.imageView.layer.transform = rotationTransform;
}
@end
