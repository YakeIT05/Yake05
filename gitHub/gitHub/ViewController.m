//
//  ViewController.m
//  gitHub
//
//  Created by student on 16/6/1.
//  Copyright © 2016年 Yake. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /**
     *  dsafasdfsgas
     *
     *  @return asdfsaasgda
     */
    NSLog(@"----666");

     NSLog(@"----你好很大佛奥 放到放到撒 啊范德萨");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
