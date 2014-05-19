//
//  UIColor+MCAdditions.m
//  Projects
//
//  Created by Matthew Cheok on 9/8/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "UIColor+MCAdditions.h"

@implementation UIColor (MCAdditions)

- (UIImage *)pixelImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), YES, 0);
    [self setFill];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Image Effects

+ (UIColor *)averageColorFromImage:(UIImage *)image {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (UIColor *)contrastingColor {
    UIColor *black = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor *white = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    float blackDiff = [self luminosityDifference:black];
    float whiteDiff = [self luminosityDifference:white];
    
    return (blackDiff > whiteDiff) ? black : white;
}

- (float)luminosityDifference:(UIColor*)otherColor {
    size_t numComponentsA = CGColorGetNumberOfComponents(self.CGColor);
    size_t numComponentsB = CGColorGetNumberOfComponents(otherColor.CGColor);
    
    if (numComponentsA == numComponentsB && numComponentsA == 4) {
        const CGFloat *rgbA = CGColorGetComponents(self.CGColor);
        const CGFloat *rgbB = CGColorGetComponents(otherColor.CGColor);
        
        float l1 = 0.2126 * pow(rgbA[0], 2.2f) +
        0.7152 * pow(rgbA[1], 2.2f) +
        0.0722 * pow(rgbA[2], 2.2f);
        float l2 = 0.2126 * pow(rgbB[0], 2.2f) +
        0.7152 * pow(rgbB[1], 2.2f) +
        0.0722 * pow(rgbB[2], 2.2f);
        
        if (l1 > l2) {
            return (l1+0.05f) / (l2/0.05f);
        } else {
            return (l2+0.05f) / (l1/0.05f);
        }
    }
    
    return 0.0f;
}

#pragma mark -
#pragma mark WebColor

- (NSString *)webColorString {

	if (![self canProvideRGBColor]) return nil;

	return [NSString stringWithFormat:@"#%02lX%02lX%02lX", (unsigned long)((NSUInteger)([self redComponent] * 255)), (unsigned long)((NSUInteger)([self greenComponent] * 255)), (unsigned long)((NSUInteger)([self blueComponent] * 255))];
}

+ (UIColor *)colorFromWebColorString: (NSString *)colorString {

	NSUInteger length = [colorString length];
	if (length > 0) {
		// remove prefixed #
		colorString = [colorString stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"#"]];
		length = [colorString length];

		// calculate substring ranges of each color
		// FFF or FFFFFF
		NSRange redRange, blueRange, greenRange;
		if (length == 3) {
			redRange = NSMakeRange(0, 1);
			greenRange = NSMakeRange(1, 1);
			blueRange = NSMakeRange(2, 1);
		} else if (length == 6) {
			redRange = NSMakeRange(0, 2);
			greenRange = NSMakeRange(2, 2);
			blueRange = NSMakeRange(4, 2);
		} else {
			return nil;
		}

		// extract colors
		unsigned int redComponent, greenComponent, blueComponent;
		BOOL valid = YES;
		NSScanner *scanner = [NSScanner scannerWithString:[colorString substringWithRange:redRange]];
		valid = [scanner scanHexInt:&redComponent];

		scanner = [NSScanner scannerWithString:[colorString substringWithRange:greenRange]];
		valid = ([scanner scanHexInt:&greenComponent] && valid);

		scanner = [NSScanner scannerWithString:[colorString substringWithRange:blueRange]];
		valid = ([scanner scanHexInt:&blueComponent] && valid);

		if (valid) {
			return [UIColor colorWithRed:redComponent/255.0 green:greenComponent/255.0 blue:blueComponent/255.0 alpha:1.0f];
		}
	}

	return nil;
}


#pragma mark -
#pragma mark String

- (NSString *)stringFromColor {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");

	NSString *result;
	switch ([self colorSpaceModel]) {
		case kCGColorSpaceModelRGB:
			result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", [self redComponent], [self greenComponent], [self blueComponent], [self alphaComponent]];
			break;
		case kCGColorSpaceModelMonochrome:
			result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", [self whiteComponent], [self alphaComponent]];
			break;
		default:
			result = nil;
	}
	return result;
}

+ (UIColor *)colorFromString: (NSString *)colorString {
	NSScanner *scanner = [NSScanner scannerWithString:colorString];
	if (![scanner scanString:@"{" intoString:NULL]) return nil;
	const NSUInteger kMaxComponents = 4;
	float c[kMaxComponents];
	NSUInteger i = 0;
	if (![scanner scanFloat:&c[i++]]) return nil;
	while (1) {
		if ([scanner scanString:@"}" intoString:NULL]) break;
		if (i >= kMaxComponents) return nil;
		if ([scanner scanString:@"," intoString:NULL]) {
			if (![scanner scanFloat:&c[i++]]) return nil;
		} else {
			// either we're at the end of there's an unexpected character here
			// both cases are error conditions
			return nil;
		}
	}
	if (![scanner isAtEnd]) return nil;
	UIColor *color;
	switch (i) {
		case 2: // monochrome
			color = [UIColor colorWithWhite:c[0] alpha:c[1]];
			break;
		case 4: // RGB
			color = [UIColor colorWithRed:c[0] green:c[1] blue:c[2] alpha:c[3]];
			break;
		default:
			color = nil;
	}
	return color;
}


#pragma mark -
#pragma mark Propery List

+ (UIColor *)colorFromPropertyRepresentation:(id)colorObject
{
	UIColor *color = nil;
	if ([colorObject isKindOfClass:[NSString class]]) {
		color = [UIColor colorFromString:colorObject];
		if (!color) {
			color = [UIColor colorFromWebColorString:colorObject];
		}
	} else if ([colorObject isKindOfClass:[NSData class]]) {
		color = [NSKeyedUnarchiver unarchiveObjectWithData:colorObject];
	} else if ([colorObject isKindOfClass:[UIColor class]]){
		color = colorObject;
	}
	return color;
}

- (id)propertyRepresentation
{
	NSString *colorString = [self stringFromColor];
	if (colorString) return colorString;

	return nil;
}


#pragma mark -
#pragma mark RGB

- (UIColor *)colorInRGBColorSpace {
    if ([self canProvideRGBColor]) {
        return [UIColor colorWithRed:[self redComponent] green:[self greenComponent] blue:[self blueComponent] alpha:[self alphaComponent]];
    }
    return nil;
}

// The RGB code is based on:
// http://arstechnica.com/apple/guides/2009/02/iphone-development-accessing-uicolor-components.ars

- (BOOL)canProvideRGBColor {
	return (([self colorSpaceModel] == kCGColorSpaceModelRGB) || ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));
}

- (CGColorSpaceModel)colorSpaceModel {
	return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (CGFloat)redComponent {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat)greenComponent {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
	return c[1];
}

- (CGFloat)blueComponent {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
	return c[2];
}

- (CGFloat)alphaComponent {
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[CGColorGetNumberOfComponents(self.CGColor)-1];
}

- (CGFloat)whiteComponent {
	NSAssert([self colorSpaceModel] == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}


#pragma mark -
#pragma mark HSB

// conversion: http://en.wikipedia.org/wiki/HSL_and_HSV
// calculates HSV values

- (CGFloat)hueComponent {
	if (![self canProvideRGBColor]) return 0;
	CGFloat r = [self redComponent];
	CGFloat g = [self greenComponent];
	CGFloat b = [self blueComponent];

	CGFloat min = MIN(MIN(r,g),b);
	CGFloat max = MAX(MAX(r,g),b);

	CGFloat hue = 0;
	if (max==min) {
		hue = 0;
	} else if (max == r) {
		hue = fmod((60 * (g-b)/(max-min) + 360), 360);
	} else if (max == g) {
		hue = (60 * (b-r)/(max-min) + 120);
	} else if (max == b) {
		hue = (60 * (r-g)/(max-min) + 240);
	}
	return hue / 360;
}


- (CGFloat)saturationComponent {
	if (![self canProvideRGBColor]) return 0;
	CGFloat r = [self redComponent];
	CGFloat g = [self greenComponent];
	CGFloat b = [self blueComponent];

	CGFloat min = MIN(MIN(r,g),b);
	CGFloat max = MAX(MAX(r,g),b);

	if (max==0) {
		return 0;
	} else {
		return (max-min)/(max);
	}
}

- (CGFloat)brightnessComponent {
	if (![self canProvideRGBColor]) return 0;
	CGFloat r = [self redComponent];
	CGFloat g = [self greenComponent];
	CGFloat b = [self blueComponent];

	CGFloat max = MAX(MAX(r,g),b);

	return max;
}


#pragma mark -
#pragma mark Texture

- (UIColor *)colorWithTextureOnImage:(UIImage *)image
{
    CGSize imageSize = image.size;
    CGRect drawRect = CGRectMake(0, 0, imageSize.width, imageSize.height);

    UIGraphicsBeginImageContext(imageSize);

	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, drawRect);

    // blend texture on top
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGImageRef cgImage = image.CGImage;
    CGContextDrawImage(context, drawRect, cgImage);
    CGContextSetBlendMode(context, kCGBlendModeNormal);

    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();


    UIColor *texturedColor = [UIColor colorWithPatternImage:textureImage];
    return texturedColor;
}


#pragma mark -
#pragma mark Derived Colors

- (UIColor *)darkenedColor
{
    CGFloat delta = 0.1f;
    if (![self canProvideRGBColor]) return self;

    CGFloat redComponent = MAX([self redComponent]-delta,0);
    CGFloat greenComponent = MAX([self greenComponent]-delta,0);
    CGFloat blueComponent = MAX([self blueComponent]-delta,0);
    CGFloat alphaComponent = [self alphaComponent];

    UIColor *darkenedColor = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    return darkenedColor;
}

- (UIColor *)lightenedColor
{
    CGFloat delta = 0.1f;
    if (![self canProvideRGBColor]) return self;

    CGFloat redComponent = MIN([self redComponent]+delta,1);
    CGFloat greenComponent = MIN([self greenComponent]+delta,1);
    CGFloat blueComponent = MIN([self blueComponent]+delta,1);
    CGFloat alphaComponent = [self alphaComponent];

    UIColor *lightenedColor = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    return lightenedColor;
}


#pragma mark -
#pragma mark Linear Dodge

- (UIColor *)colorByComputingLinearDodgeWithColor:(UIColor *)color atRatio:(CGFloat)ratio {
    if (![self canProvideRGBColor]) return self;
    if (![color canProvideRGBColor]) return self;
    
    CGFloat redComponent = MIN([self redComponent]+[color redComponent]*ratio,1);
    CGFloat greenComponent = MIN([self greenComponent]+[color greenComponent]*ratio,1);
    CGFloat blueComponent = MIN([self blueComponent]+[color blueComponent]*ratio,1);
    CGFloat alphaComponent = [self alphaComponent];
    
    UIColor *result = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    return result;
}


#pragma mark -
#pragma mark Cross Fade

- (UIColor *)colorByInterpolatingWithColor:(UIColor *)color atRatio:(CGFloat)ratio {
    CGFloat selfH = 0, selfS = 0, selfB = 0, selfA = 0;
    CGFloat otherH = 0, otherS = 0, otherB = 0, otherA = 0;
    BOOL success = [self getHue:&selfH saturation:&selfS brightness:&selfB alpha:&selfA];
    success = success && [color getHue:&otherH saturation:&otherS brightness:&otherB alpha:&otherA];
    NSAssert(success, @"Cannot convert colorspace");
    if (!success) {
        return [UIColor colorForFadeBetweenFirstColor:self secondColor:color atRatio:ratio];
    }

    CGFloat p = MAX(MIN(ratio,1),0);
    CGFloat q = 1 - p;

    if (fabsf(selfH - otherH) > 0.5)
        selfH += 1;
    CGFloat h = p * otherH + q * selfH;
    CGFloat s = p * otherS + q * selfS;
    CGFloat b = p * otherB + q * selfB;
    CGFloat a = p * otherA + q * selfA;
    if (h>1)
        h -= 1;
    return [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
}

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor
                               secondColor:(UIColor *)secondColor
                                   atRatio:(CGFloat)ratio {
    return [self colorForFadeBetweenFirstColor:firstColor secondColor:secondColor atRatio:ratio compareColorSpaces:YES];

}

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio compareColorSpaces:(BOOL)compare {
    // Eliminate values outside of 0 <--> 1
    ratio = MIN(MAX(0, ratio), 1);

    // Convert to common RGBA colorspace if needed
    if (compare) {
        if (CGColorGetColorSpace(firstColor.CGColor) != CGColorGetColorSpace(secondColor.CGColor))
        {
            firstColor = [UIColor colorConvertedToRGBA:firstColor];
            secondColor = [UIColor colorConvertedToRGBA:secondColor];
        }
    }

    // Grab color components
    const CGFloat *firstColorComponents = CGColorGetComponents(firstColor.CGColor);
    const CGFloat *secondColorComponents = CGColorGetComponents(secondColor.CGColor);

    // Interpolate between colors
    CGFloat interpolatedComponents[CGColorGetNumberOfComponents(firstColor.CGColor)] ;
    for (NSUInteger i = 0; i < CGColorGetNumberOfComponents(firstColor.CGColor); i++)
    {
        interpolatedComponents[i] = firstColorComponents[i] * (1 - ratio) + secondColorComponents[i] * ratio;
    }

    // Create interpolated color
    CGColorRef interpolatedCGColor = CGColorCreate(CGColorGetColorSpace(firstColor.CGColor), interpolatedComponents);
    UIColor *interpolatedColor = [UIColor colorWithCGColor:interpolatedCGColor];
    CGColorRelease(interpolatedCGColor);

    return interpolatedColor;
}

+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                                    inSteps:(NSUInteger)steps {

    return [self colorsForFadeBetweenFirstColor:firstColor lastColor:lastColor withRatioEquation:nil inSteps:steps];
}

+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor lastColor:(UIColor *)lastColor withRatioEquation:(float (^)(float))equation inSteps:(NSUInteger)steps {
    // Handle degenerate cases
    if (steps == 0)
        return nil;
    if (steps == 1)
        return [NSArray arrayWithObject:firstColor];
    if (steps == 2)
        return [NSArray arrayWithObjects:firstColor, lastColor, nil];

    // Assume linear if no equation is passed
    if (equation == nil) {
    	equation = ^(float input) {
    	    return input;
    	};
    }

    // Calculate step size
    CGFloat stepSize = 1.0f / (steps - 1);

    // Array to store colors in steps
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:steps];
    [colors addObject:firstColor];

    // Compute intermediate colors
    CGFloat ratio = stepSize;
    for (int i = 2; i < steps; i++)
    {
        [colors addObject:[self colorForFadeBetweenFirstColor:firstColor secondColor:lastColor atRatio:equation(ratio)]];
        ratio += stepSize;
    }

    [colors addObject:lastColor];
    return colors;
}

+ (UIColor *)colorConvertedToRGBA:(UIColor *)colorToConvert;
{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;

    // Convert color to RGBA with a CGContext. UIColor's getRed:green:blue:alpha: doesn't work across color spaces. Adapted from http://stackoverflow.com/a/4700259

    alpha = CGColorGetAlpha(colorToConvert.CGColor);

    CGColorRef opaqueColor = CGColorCreateCopyWithAlpha(colorToConvert.CGColor, 1.0f);
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[CGColorSpaceGetNumberOfComponents(rgbColorSpace)];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, opaqueColor);
    CGColorRelease(opaqueColor);
    CGContextFillRect(context, CGRectMake(0.f, 0.f, 1.f, 1.f));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);

    red = resultingPixel[0] / 255.0f;
    green = resultingPixel[1] / 255.0f;
    blue = resultingPixel[2] / 255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
