//
//  UIImage+UIImageExtras.h
//  Football_talk_iphone
//
//  Created by Aone on 16/4/10.
//  Copyright © 2016年 Aone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtras)

-(UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

@end
