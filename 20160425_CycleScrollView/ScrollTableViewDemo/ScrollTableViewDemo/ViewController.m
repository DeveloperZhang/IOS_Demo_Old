//
//  ViewController.m
//  ScrollTableViewDemo
//
//  Created by ZhangYu on 16/4/25.
//  Copyright © 2016年 Yinker. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) NSInteger currentIndex;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[[UIColor greenColor],[UIColor yellowColor],[UIColor whiteColor]];
    NSMutableArray *tmpArray = [@[] mutableCopy];
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int newIndex = (int)idx - 1;
        if (newIndex < 0) {
            newIndex = (int)self.dataSource.count - 1;
        }
        tmpArray[idx] = self.dataSource[newIndex];
    }];
    self.dataSource = [tmpArray copy];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.tableView reloadData];
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *customCellIdentifier = @"customCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    cell.contentView.backgroundColor = self.dataSource[indexPath.row];
    NSLog(@"当前%d",(int)indexPath.row);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)checkNeedScroll:(UIScrollView *)scrollView {
    CGFloat position = scrollView.contentOffset.y;
    CGFloat maxPoisition = scrollView.contentSize.height - self.view.frame.size.height;
    return position <= 0 || position >= maxPoisition;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = 3/2;
    CGFloat f = scrollView.contentOffset.y;
    NSLog(@"%f",f);
    if (f != SCREEN_HEIGHT) {
        BOOL isNext = NO;
        if (f == 0) {
            NSLog(@"前一页");
        }else {
            NSLog(@"后一页");
            isNext = YES;
        }
        NSMutableArray *tmpArray = [@[] mutableCopy];
        if (!isNext) {
            [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                int newIndex = (int)idx - 1;
                if (newIndex < 0) {
                    newIndex = (int)self.dataSource.count - 1;
                }
                tmpArray[idx] = self.dataSource[newIndex];
            }];
        }else {
            [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                int newIndex = (int)idx + 1;
                if (newIndex > (int)self.dataSource.count - 1) {
                    newIndex = 0;
                }
                tmpArray[idx] = self.dataSource[newIndex];
            }];
        }
        self.dataSource = [tmpArray copy];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self.tableView reloadData];
    }

}


@end
