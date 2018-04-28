//
//  ViewController.m
//  BQL_iOSProjectMix
//
//  Created by qinglin bi on 2018/4/28.
//  Copyright © 2018年 qinglin bi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testFunc0 {
    NSLog(@"可以混淆方法名，也可以混淆类名");
}

- (void)testFunc1 {
    NSLog(@"在func.list中注册你要混淆的方法名或者类名");
}

- (void)testFunc2 {
    NSLog(@"不要将func.list引入项目中");
}

- (void)testFunc3 {
    NSLog(@"codeObfuscation这个文件是你编译之后自动生成的，看生成位置，拖进对应项目位置中");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
