//
//  LoadingView.m
//  Football_talk_iphone
//
//  Created by pzk on 16/10/24.
//  Copyright © 2016年 Aone. All rights reserved.
//

#import "LoadingView.h"
#import <pthread/pthread.h>
#import "UIImage+UIImageExtras.h"

#define ImageSrcName(file) [@"loading.bundle" stringByAppendingPathComponent:file]

@implementation LoadingView{
    CGFloat _progressValue;
    pthread_mutex_t _mutex;
}

- (instancetype)initWithFrame:(CGRect)frame{
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
    self.loadingBottomImage.image = [UIImage imageNamed:ImageSrcName(@"进入页-进度条底")];
    [self layoutIfNeeded];

    self.loadingImage.image = [[UIImage imageNamed:ImageSrcName(@"进入页-进度条")] imageByScalingToSize:CGSizeMake(CGRectGetWidth(self.loadingBottomImage.frame), CGRectGetHeight(self.loadingBottomImage.frame))];
    [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), 0, CGRectGetHeight(self.loadingBottomImage.frame))];
    
    _progressValue = 0;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(progressUpdate) userInfo:nil repeats:YES];
    // 初始化互斥锁
    pthread_mutex_init(&_mutex, NULL);
}
    
- (void)updateProgressValue:(CGFloat)value {
    
    pthread_mutex_lock(&_mutex);
    _progressValue = _progressValue + value < 1 ? _progressValue + value:1;
    pthread_mutex_unlock(&_mutex);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0 animations:^{
            [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), CGRectGetWidth(self.loadingBottomImage.frame)*_progressValue, CGRectGetHeight(self.loadingBottomImage.frame))];
        }];
    });
}

//计时器的实现方法
- (void)progressUpdate{
    //进度条每次进行的变化
    _progressValue += 0.1;
    //自动增长不可增加到1，除非指定接口调用成功
    if (_progressValue >= 0.9){
        _progressValue = 0.95;
        [self.timer invalidate];
    }
    [UIView animateWithDuration:1.0 animations:^{
        [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), CGRectGetWidth(self.loadingBottomImage.frame)*_progressValue, CGRectGetHeight(self.loadingBottomImage.frame))];
    }];
}

-(void)progressFinish{
    [self.timer invalidate];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.loadingImage setFrame:CGRectMake(CGRectGetMinX(self.loadingBottomImage.frame), CGRectGetMinY(self.loadingBottomImage.frame), CGRectGetWidth(self.loadingBottomImage.frame), CGRectGetHeight(self.loadingBottomImage.frame))];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
        //  这个方法可以避免方法还未执行的时候引起的内存泄露，在返回时调用
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}

- (void)dealloc {
    [self.timer invalidate];
    pthread_mutex_destroy(&_mutex);
}

@end
