//
//  ViewController.m
//  20160222_AnimationDemo
//
//  Created by ZhangYu on 16/2/22.
//  Copyright © 2016年 ZhangYu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic ,strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"SimpleAnimationViewController",@"SimpleDrawViewController",@"SimpleAddAnimationViewController",
                       @"SimpleKeyAnimationViewController",@"SimpleTransitionAnimationViewController"];
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *secondViewController = [[NSClassFromString(self.dataArray[indexPath.row]) alloc] init];
    secondViewController.title = self.dataArray[indexPath.row];
    //跳转事件
    [self.navigationController pushViewController:secondViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
