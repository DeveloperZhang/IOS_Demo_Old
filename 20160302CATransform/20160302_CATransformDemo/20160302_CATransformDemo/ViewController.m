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
    [UIView animateWithDuration:3 animations:^{
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
    }];
    
}
@end
