//
//  ViewController.m
//  BSYTextView
//
//  Created by chenchen on 15/9/15.
//  Copyright (c) 2015年 BSY. All rights reserved.
//

#import "ViewController.h"
#import "BSYTextView.h"
#import "UIView+BSYLayout.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demo";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = 0;
    BSYTextView *text = [[BSYTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:text];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)tongzhi:(NSNotification *)notification{
    
       NSLog(@"    %@",notification.userInfo);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
