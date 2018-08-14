//
//  ViewController.m
//  二货
//
//  Created by 管章鹏 on 2018/7/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "ViewController.h"
#import "DatePickVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClick:(id)sender {
    
    DatePickVC *vc= [[DatePickVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}




@end
