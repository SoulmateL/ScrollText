//
//  ViewController.m
//  ScrollText
//
//  Created by cqtd on 2017/9/4.
//  Copyright © 2017年 cqtd. All rights reserved.
//

#import "ViewController.h"
#import "LScrollText.h"
@interface ViewController ()<LScrollTextDelegate>
@property (nonatomic,strong) LScrollText *scrollText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    NSArray *array = @[@"1111111",@"2222222",@"3333333",@"4444444",@"5555555",@"6666666"];
    _scrollText = [[LScrollText alloc] initWithFrame:CGRectMake(100, 100, 100, 30)
                                            delegate:self
                                          dataSource:array
                                           Direction:ScrollDirectionBottomtoTop
                                  scrollIntervalTime:3
                                       animationTime:0.5];
    _scrollText.fontSize = 15;
    _scrollText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollText];
    
    
    UIButton *a = [UIButton buttonWithType:UIButtonTypeSystem];
    a.backgroundColor = [UIColor redColor];
    [a setTitle:@"开始" forState:0];
    a.frame = CGRectMake(100, 200, 100, 30);
    [self.view addSubview:a];
    [a addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
    [b setTitle:@"暂停" forState:0];
    b.backgroundColor = [UIColor blueColor];
    b.frame = CGRectMake(100, 300, 100, 30);
    [self.view addSubview:b];
    [b addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
}
- (void)start {
    [_scrollText start];
}
- (void)stop {
    [_scrollText stop];
}

- (void)scrollText:(LScrollText *)scrollText currentIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
