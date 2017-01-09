//
//  NextViewController.m
//  SGEmptyView
//
//  Created by Jonhory on 2017/1/9.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "NextViewController.h"

#import "Masonry.h"

#import "SGEmptyView.h"

@interface NextViewController ()<SGEmptyViewDelegate>

@property (nonatomic ,weak) SGEmptyView * empty;

@property (nonatomic ,weak) UIView * customBView;

@end

@implementation NextViewController

- (UIView *)customBView{
    if (!_customBView) {
        UIView * v = [[UIView alloc]init];
        [self.view addSubview:v];
        _customBView = v;
        _customBView.backgroundColor = [self red:138 blue:130 green:238];
    }
    return _customBView;
}

- (SGEmptyView *)empty{
    if (!_empty) {
        _empty = [SGEmptyView addToView:self.customBView];
        [_empty configImage:@"noData2" emptyContent:@"暂时没有数据了吗？" highlightContent:@"没有"];
        _empty.delegate = self;
    }
    return _empty;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [self red:153 blue:153 green:153];
    
    [self.customBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(200);
    }];
    
    
    [self empty];
}

- (void)sgEmptyViewClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIColor *)red:(CGFloat)red blue:(CGFloat)blue green:(CGFloat)green{
    return [UIColor colorWithRed:red/255.0 green:blue/255.0 blue:green/255.0 alpha:1.0];
}

- (void)dealloc{
    NSLog(@"dealloc = %@",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
