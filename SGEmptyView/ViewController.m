//
//  ViewController.m
//  SGEmptyView
//
//  Created by Jonhory on 2017/1/9.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

#import "SGEmptyView.h"

@interface ViewController ()
@property (nonatomic ,weak) SGEmptyView * emptyView;

@end

@implementation ViewController

- (SGEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [SGEmptyView addToView:self.view];
        __weak __typeof(self)weakSelf = self;
        _emptyView.clickBlock = ^(){
            [weakSelf goNext];
        };
    }
    return _emptyView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self emptyView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)goNext{
    NextViewController * next = [[NextViewController alloc]init];
    [self presentViewController:next animated:YES completion:^{
        [self.emptyView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
