//
//  MyCell2.m
//  UITableViewDemo
//
//  Created by zhangyu on 15/12/3.
//  Copyright © 2015年 Developer_Zhang. All rights reserved.
//

#import "MyCell2.h"

@implementation MyCell2

- (void)awakeFromNib {
    // Initialization code
    [self.myBtn addSubview:self.myView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAction:(id)sender {
    NSLog(@"%s",__func__);
}
@end
