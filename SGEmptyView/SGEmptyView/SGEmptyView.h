//
//  SGEmptyView.h
//  SGEmptyView
//
//  Created by Jonhory on 2017/1/9.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGEmptyViewDelegate <NSObject>

- (void)sgEmptyViewClick;

@end

@interface SGEmptyView : UIView

@property (nonatomic ,weak) id<SGEmptyViewDelegate> delegate;
@property (nonatomic ,copy) void(^clickBlock)(void);

/**
 初始化方法(父视图需要已有frame)

 @param superView 父视图
 @return SGEmptyView
 */
+ (instancetype)addToView:(UIView *)superView;

/**
 配置内容

 @param imageName 图片名称
 @param content 提示内容
 @param highlightContent 高亮内容   
 */
- (void)configImage:(NSString *)imageName emptyContent:(NSString *)content highlightContent:(NSString *)highlightContent;


/**
 如有需要,修改图片顶部距离父视图top的距离

 @param topY 图片顶部距离父视图top的距离
 */
- (void)updateWithTopY:(CGFloat)topY;

@end
