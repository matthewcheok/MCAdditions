//
//  UIImage+MCAdditions.h
//  Paces
//
//  Created by Matthew Cheok on 20/1/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MCAdditions)

- (UIColor *)averageColor;
- (UIColor *)contrastingColor;

- (UIImage *)imageByCroppingToBounds:(CGRect)bounds;
- (UIImage *)imageByScalingToSize:(CGSize)size;
- (UIImage *)imageByScalingToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;
- (UIImage *)imageByScalingToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode interpolationQuality:(CGInterpolationQuality)quality;

@end
