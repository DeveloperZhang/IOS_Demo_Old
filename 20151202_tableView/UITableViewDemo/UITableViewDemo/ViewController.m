//
//  ViewController.m
//  UITableViewDemo
//
//  Created by zhangyu on 15/12/2.
//  Copyright © 2015年 Developer_Zhang. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

//屏幕Size
#define SCREEN [UIScreen mainScreen].bounds.size
//headerView的高度
const float headerHeight = 50;

//刷新状态
typedef NS_ENUM(NSInteger,RefreshState) {
    RefreshStateNormal,
    RefreshStateRefreshing
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *dataTable;
@property (assign, nonatomic) RefreshState state;

@end


@implementation ViewController
{
    //数据源
    NSMutableArray *dataMutableArray;
    //伪下拉刷新图
    UIView *refreshView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    dataMutableArray = [@[] mutableCopy];
    for (int i = 0; i < 10; i++) {
        NSNumber *number = [NSNumber numberWithInt:i];
        [dataMutableArray addObject:number];
    }
    //cell高度的预估值
    self.dataTable.rowHeight = UITableViewAutomaticDimension;
    self.dataTable.estimatedRowHeight = 60;
    [self.dataTable reloadData];
    
    //初始化
    refreshView = [[UIView alloc] init];
    refreshView.backgroundColor = [UIColor redColor];
    refreshView.tag = 1001;
    
    //先添加视图,再添加剂约束
    [self.dataTable addSubview:refreshView];
    // 使用autoLayout约束，禁止将AutoresizingMask转换为约束
    [refreshView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //cell分割线处理
    if ([self.dataTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.dataTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    // 设置refresh相对于self.dataTable的上左下右
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:refreshView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.dataTable attribute:NSLayoutAttributeTop multiplier:1.0 constant:-headerHeight];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:refreshView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.dataTable attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    // 由于iOS坐标系的原点在左上角，所以设置右边距使用负值
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:refreshView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:self.dataTable.frame.size.width];
    
    // 由于iOS坐标系的原点在左上角，所以设置下边距使用负值
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:refreshView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:headerHeight];
    
    //ios 7将四条约束加进数组中
//    NSArray *array = [NSArray arrayWithObjects:constraint1, constraint2, constraint3, constraint4 ,nil];
    // 把约束条件设置到父视图的Contraints中
//    [self.dataTable addConstraints:array];
    
    //iOS 8.0以后设置active属性值
    constraint1.active = YES;
    constraint2.active = YES;
    constraint3.active = YES;
    constraint4.active = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataMutableArray.count) {
        return dataMutableArray.count;
    }
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"myCell";
    static NSString *cellIdentifier1 = @"myCell1";
    UITableViewCell *cell = nil;
    if (indexPath.row%2 == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        ((MyCell *)cell).myLabel.text = [NSString stringWithFormat:@"测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高测试行高row%@",dataMutableArray[indexPath.row]];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"contentOffset.x=%f|contentOffset.y=%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    float offsetY = scrollView.contentOffset.y;
    if(offsetY < -50 && self.state != RefreshStateRefreshing)
    {
        self.state = RefreshStateRefreshing;
        [UIView animateWithDuration:1.0 animations:^{
            
            //  frame发生偏移,距离顶部50的距离(可自行设定)
            self.dataTable.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
            NSLog(@"开刷~");
        } completion:^(BOOL finished) {
            /**
             *  发起网络请求,请求刷新数据
             */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.dataTable.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
                NSLog(@"刷完了~");
                self.state = RefreshStateNormal;
            });
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
