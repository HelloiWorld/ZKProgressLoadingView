//
//  LoadingView.h
//  Football_talk_iphone
//
//  Created by pzk on 16/10/24.
//  Copyright © 2016年 Aone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *loadingBottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImage;

@property (assign, nonatomic) float progressValue;
@property (nonatomic, strong) NSTimer *timer;

-(void)progressFinish;

@end
