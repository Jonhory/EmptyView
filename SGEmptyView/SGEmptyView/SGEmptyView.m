//
//  SGEmptyView.m
//  SGEmptyView
//
//  Created by Jonhory on 2017/1/9.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import "SGEmptyView.h"
#import "Masonry.h"

@interface SGEmptyView ()
//UI
@property (nonatomic ,weak) UIButton * clickBackBtn;
@property (nonatomic ,weak) UIImageView * emptyImage;
@property (nonatomic ,weak) UILabel * emptyLabel;
//UI属性
@property (nonatomic ,strong) NSString * imageName;/**< 图片名称 */
@property (nonatomic ,strong) NSString * emptyContent;/**< 所有内容 */
@property (nonatomic ,strong) NSString * highlightContent;/**< 高亮内容 */
//配置默认属性
@property (nonatomic ,assign) CGFloat contenFont;/**< 文字大小 */
@property (nonatomic ,assign) CGFloat maxLayoutWidth;/**< 最大宽度 */
@property (nonatomic ,strong) UIColor * contentNormalColor;/**< 默认颜色 */
@property (nonatomic ,strong) UIColor * contentHighlightColor;/**< 高亮颜色 */

@property (nonatomic ,strong) UIView * kSuperView;

@end

@implementation SGEmptyView

+(instancetype)addToView:(UIView *)superView{
    SGEmptyView * view = [[SGEmptyView alloc]init];
    view.kSuperView = superView;
    [view configNormal];
    [superView addSubview:view];
    [view setContentContraints];
    return view;
}

- (void)configImage:(NSString *)imageName emptyContent:(NSString *)content highlightContent:(NSString *)highlightContent{
    self.imageName = imageName;
    self.emptyContent = content;
    self.highlightContent = highlightContent;
    [self showTheContent];
}

- (void)updateWithTopY:(CGFloat)topY{
    [self.clickBackBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(topY);
        make.centerX.equalTo(@0);
        make.top.equalTo(self.emptyImage.mas_top);
        make.bottom.equalTo(self.emptyLabel.mas_bottom);
        make.width.mas_equalTo(self.maxLayoutWidth);
    }];
}

- (void)configNormal{
    self.contenFont = 15;
    self.maxLayoutWidth = 100;
    self.contentNormalColor = [UIColor lightGrayColor];
    self.contentHighlightColor = [UIColor colorWithRed:42/255.0 green:187/255.0 blue:178/255.0 alpha:1.0];
    
    self.imageName = @"noData";
    self.emptyContent = @"暂时还没有数据哦~";
    [self showTheContent];
}

- (void)showTheContent{
    self.highlightContent = self.highlightContent;
    self.emptyImage.image = [UIImage imageNamed:self.imageName];
    self.emptyLabel.text = self.emptyContent;
    if (self.highlightContent && ![self.highlightContent isEqualToString:@""]) {
        NSMutableAttributedString * hintString = [[NSMutableAttributedString alloc]initWithString:self.emptyContent];
        NSRange range1 = [[hintString string]rangeOfString:self.highlightContent];
        [hintString addAttribute:NSForegroundColorAttributeName value:self.contentHighlightColor range:range1];
        self.emptyLabel.attributedText = hintString;
    }
}

- (void)setContentContraints{
    [self.clickBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(@0);
    }];
    
    [self.emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.clickBackBtn);
        make.top.equalTo(self.clickBackBtn.mas_top);
    }];
    
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.clickBackBtn);
        make.top.equalTo(self.emptyImage.mas_bottom).offset(15);
        make.bottom.equalTo(self.clickBackBtn.mas_bottom);
        make.width.equalTo(self);
    }];
    
    [self.clickBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyImage.mas_top);
        make.bottom.equalTo(self.emptyLabel.mas_bottom);
        make.width.equalTo(self);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.centerY.equalTo(self.kSuperView);
        make.height.equalTo(self.clickBackBtn);
    }];
}

- (void)sg_empty_click{
    if (![self returnDelegate]) {
        !self.clickBlock ? : self.clickBlock();
    }
}

- (BOOL)returnDelegate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sgEmptyViewClick)]) {
        [self.delegate sgEmptyViewClick];
        return YES;
    }
    return NO;
}

- (UIButton *)clickBackBtn{
    if (!_clickBackBtn) {
        UIButton * btn = [[UIButton alloc]init];
        [self addSubview:btn];
        _clickBackBtn = btn;
        [_clickBackBtn addTarget:self action:@selector(sg_empty_click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBackBtn;
}

- (UIImageView *)emptyImage{
    if (!_emptyImage) {
        UIImageView * iv = [[UIImageView alloc]init];
        [self.clickBackBtn addSubview:iv];
        _emptyImage = iv;
    }
    return _emptyImage;
}

- (UILabel *)emptyLabel{
    if (!_emptyLabel) {
        UILabel * label = [[UILabel alloc]init];
        [self.clickBackBtn addSubview:label];
        _emptyLabel = label;
        _emptyLabel.font = [UIFont systemFontOfSize:self.contenFont];
        _emptyLabel.textColor = self.contentNormalColor;
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
    }
    return _emptyLabel;
}

@end
