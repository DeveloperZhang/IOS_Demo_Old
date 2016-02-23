//
//  SimpleViewAnimationViewController.m
//  20160222_AnimationDemo
//
//  Created by ZhangYu on 16/2/23.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "SimpleViewAnimationViewController.h"

@interface SimpleViewAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation SimpleViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)action:(id)sender {    
    [UIView animateWithDuration:1 animations:^{
        NSLog(@"animation.y->%f",self.myView.frame.origin.y);
        self.myView.frame = CGRectMake(self.myView.frame.origin.x, self.myView.frame.origin.y + 100, self.myView.frame.size.width, self.myView.frame.size.height);
    } completion:^(BOOL finished) {
        NSLog(@"after.animation.y->%f",self.myView.frame.origin.y);
    }];
}

@end
