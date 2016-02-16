//
//  IH2ViewController.m
//  IHKeyboardAvoiding
//
//  Created by ZhangYu on 16/2/16.
//  Copyright © 2016年 Idle Hands Apps. All rights reserved.
//

#import "IH2ViewController.h"
#import "IHKeyboardAvoiding.h"

@interface IH2ViewController (){
    NSArray *areaArr;
    NSMutableArray *teamArr;
}

@property (strong, nonatomic)UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UITextField *myTf;

- (IBAction)showPicker:(id)sender;
@end

@implementation IH2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [IHKeyboardAvoiding setAvoidingView:self.view];
    
    self.pickView = [[UIPickerView alloc] init];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    areaArr=@[@"西南区",@"中央区",@"东南区",@"大西洋区",@"西北区",@"太平洋区"];
    teamArr=[[NSMutableArray alloc] init];
    [teamArr addObject:@[@"马刺",@"灰熊",@"小牛",@"火箭",@"鹈鹕"]];
    [teamArr addObject:@[@"活塞",@"步行者",@"骑士",@"公牛",@"雄鹿"]];
    [teamArr addObject:@[@"热火",@"魔术",@"老鹰",@"奇才",@"黄蜂"]];
    [teamArr addObject:@[@"凯尔特人",@"76人",@"尼克斯",@"篮网",@"猛龙"]];
    [teamArr addObject:@[@"森林狼",@"掘金",@"爵士",@"开拓者",@"雷霆"]];
    [teamArr addObject:@[@"国王",@"太阳",@"湖人",@"快船",@"勇士"]];
    
    //该方法可以让点击输入框后弹出picker
    self.myTf.inputView = self.pickView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //判断列
    if (component==0) {
        return [areaArr count];
    }else{
        //判断0列中当前的行号
        NSInteger  currentRow=[pickerView selectedRowInComponent:0];
        return [teamArr[currentRow] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        //o列从区域数组中选择
        return areaArr[row];
    }else{
        //根据0列中选择的行号
        NSInteger  currentRow=[pickerView selectedRowInComponent:0];
        return teamArr[currentRow][row];
    }
}

- (IBAction)showPicker:(id)sender {
    [self.view addSubview:self.pickView];
}
@end
