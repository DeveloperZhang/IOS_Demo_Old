//
//  IHViewController.m
//  IHKeyboardAvoiding
//
//  Created by Fraser Scott-Morrison on 18/04/13.
//  Copyright (c) 2013 Idle Hands Apps. All rights reserved.
//

#import "IHViewController.h"
#import "IHKeyboardAvoiding.h"
#import "IH2ViewController.h"

@interface IHViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UITextField *myTf;
- (IBAction)goAction:(id)sender;
@end

@implementation IHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.avoidingView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"diamond_upholstery"]];
    
//    [IHKeyboardAvoiding setAvoidingView:self.view withTriggerView:self.view1];
//    [IHKeyboardAvoiding setAvoidingView:self.view withTriggerView:self.targetView];
    /**
     *  @author zhangyu@yinker.com, 16-02-16
     *
     *  只移动子视图
     *  如果设置某个view为IHKeyboardDismissing的话，点击该view会隐藏keyboard
     */
    [IHKeyboardAvoiding setAvoidingView:self.view1];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField != self.myTf) {
        [IHKeyboardAvoiding setAvoidingView:self.view withTriggerView:self.targetView];
    }
    else {
        [IHKeyboardAvoiding setAvoidingView:self.view1];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField; 
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goAction:(id)sender {
    IH2ViewController *vc = [[IH2ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
