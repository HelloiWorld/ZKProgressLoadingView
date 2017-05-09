//
//  LoadingView.m
//  Football_talk_iphone
//
//  Created by pzk on 16/10/24.
//  Copyright © 2016年 Aone. All rights reserved.
//

#import "LoadingView.h"
#import "UIImage+UIImageExtras.h"

#define ImageSrcName(file) [@"loading.bundle" stringByAppendingPathComponent:file]

@implementation LoadingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        LoadingView *view = (LoadingView*)[[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] firstObject];
        view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:view];
        
        [self configView];
    }
    return self;
}

-(void)configView{
    if (kScreenHeight < 568) {
        self.gifImageView.image = [UIImage imageNamed:ImageSrcName(@"进入页底图ip4.jpg")];
    }else{
        self.gifImageView.image = [UIImage imageNamed:ImageSrcName(@"进入页底图.jpg")];
    }
    self.loadingBottomImage.image = [UIImage imageNamed:ImageSrcName(@"进入页-进度条底")];
    [self layoutIfNeeded];
    self.loadingImage.image = [[UIImage imageNamed:ImageSrcName(@"进入页-进度条")] imageByScalingToSize:CGSizeMake(CGRectGetWidth(self.loadingBottomImage.frame), CGRectGetHeight(self.loadingBottomImage.frame))];
    [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), 0, CGRectGetHeight(self.loadingBottomImage.frame))];
    
    self.progressValue = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(progressUpdate) userInfo:nil repeats:YES];
}

//计时器的实现方法
- (void)progressUpdate{
    //进度条每次进行的变化
    self.progressValue += 0.1;
    //判断进度条是否已完成
    if (self.progressValue >= 0.9){
        self.progressValue = 0.95;
        [self.timer invalidate];
    }
    [UIView animateWithDuration:1.0 animations:^{
        [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), CGRectGetWidth(self.loadingBottomImage.frame)*self.progressValue, CGRectGetHeight(self.loadingBottomImage.frame))];
    }];
}

-(void)progressFinish{
    [self.timer invalidate];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), CGRectGetWidth(self.loadingBottomImage.frame), CGRectGetHeight(self.loadingBottomImage.frame))];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(removeView) withObject:nil afterDelay:2.0];
        //  这个方法可以避免方法还未执行的时候引起的内存泄露，在返回时调用
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}

- (void)removeView  {
    [self removeFromSuperview];
}

@end
