//
//  UIImage+MCAdditions.m
//  Paces
//
//  Created by Matthew Cheok on 20/1/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "UIImage+MCAdditions.h"
#import "UIColor+MCAdditions.h"

@implementation UIImage (MCAdditions)

- (UIColor *)averageColor {
    return [UIColor averageColorFromImage:self];
}

- (UIColor *)contrastingColor {
    return [[UIColor averageColorFromImage:self] contrastingColor];
}

@end
