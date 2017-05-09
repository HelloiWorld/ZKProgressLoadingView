//
//  LoadingView.h
//  Football_talk_iphone
//
//  Created by pzk on 16/10/24.
//  Copyright © 2016年 Aone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (strong, nonatomic) UIImageView *loadingBottomImage;
@property (strong, nonatomic) UIImageView *loadingImage;

@property (nonatomic, strong) NSTimer *timer;

/**
 进度条更新

 @param value 增长的值
 */
- (void)updateProgressValue:(CGFloat)value;

/**
 计时器的更新方法
 */
- (void)progressUpdate;

/**
 直接加载完成
 */
- (void)progressFinish;

@end
