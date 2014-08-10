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

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)imageByCroppingToBounds:(CGRect)bounds {
    CGFloat scale = MAX(self.scale, 1.0f);
    CGRect scaledBounds = CGRectMake(bounds.origin.x * scale, bounds.origin.y * scale, bounds.size.width * scale, bounds.size.height * scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], scaledBounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)imageByScalingToSize:(CGSize)size {
	return [self imageByScalingToSize:size contentMode:UIViewContentModeRedraw interpolationQuality:kCGInterpolationDefault];
}

- (UIImage *)imageByScalingToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
	return [self imageByScalingToSize:size contentMode:contentMode interpolationQuality:kCGInterpolationDefault];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)imageByScalingToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode interpolationQuality:(CGInterpolationQuality)quality {
	CGFloat horizontalRatio = size.width / self.size.width;
	CGFloat verticalRatio = size.height / self.size.height;
	CGFloat ratio = 0;

	switch (contentMode) {
		case UIViewContentModeScaleAspectFill:
			ratio = MAX(horizontalRatio, verticalRatio);
			break;

		case UIViewContentModeScaleAspectFit:
			ratio = MIN(horizontalRatio, verticalRatio);
			break;

		case UIViewContentModeRedraw:
			break;

		default:
			[NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", contentMode];
	}

	CGSize newSize = ratio == 0 ? size : CGSizeMake(self.size.width * ratio, self.size.height * ratio);
	return [self mc_resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)mc_resizedImage:(CGSize)newSize
        interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));

    UIGraphicsBeginImageContextWithOptions(newSize, NO, self.scale);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();

    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);

    // Draw into the context; this scales the image
    [self drawInRect:newRect];

    // Get the resized image from the context and a UIImage
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

@end
