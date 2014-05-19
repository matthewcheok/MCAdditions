//
//  UIColor+MCAdditions.h
//  Projects
//
//  Created by Matthew Cheok on 9/8/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MCAdditions)

- (UIImage *)pixelImage;

#pragma mark - Image Effects

+ (UIColor *)averageColorFromImage:(UIImage *)image;
- (UIColor *)contrastingColor;

#pragma mark -
#pragma mark Web String

- (NSString *)webColorString;
+ (UIColor *)colorFromWebColorString: (NSString *)colorString;

#pragma mark -
#pragma mark String

- (NSString *)stringFromColor;
+ (UIColor *)colorFromString: (NSString *)colorString;

#pragma mark -
#pragma mark Propery List

+ (UIColor *)colorFromPropertyRepresentation:(id)colorObject;
- (id)propertyRepresentation ;

#pragma mark -
#pragma mark RGB


- (UIColor *)colorInRGBColorSpace;
- (BOOL)canProvideRGBColor;
- (CGColorSpaceModel)colorSpaceModel;
- (CGFloat)redComponent;
- (CGFloat)greenComponent;
- (CGFloat)blueComponent;
- (CGFloat)alphaComponent;
- (CGFloat)whiteComponent;


#pragma mark -
#pragma mark HSB

- (CGFloat)hueComponent;
- (CGFloat)saturationComponent;
- (CGFloat)brightnessComponent;


#pragma mark -
#pragma mark Texture

- (UIColor *)colorWithTextureOnImage:(UIImage *)image;


#pragma mark -
#pragma mark Derived Colors

- (UIColor *)darkenedColor;
- (UIColor *)lightenedColor;

#pragma mark - 
#pragma mark Linear Dodge

- (UIColor *)colorByComputingLinearDodgeWithColor:(UIColor *)color atRatio:(CGFloat)ratio;

#pragma mark -
#pragma mark Cross Fade

- (UIColor *)colorByInterpolatingWithColor:(UIColor *)color atRatio:(CGFloat)ratio;

/**
 * Fades between firstColor and secondColor at the specified ratio:
 *
 *    @ ratio 0.0 - fully firstColor
 *    @ ratio 0.5 - halfway between firstColor and secondColor
 *    @ ratio 1.0 - fully secondColor
 *
 */

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor
                               secondColor:(UIColor *)secondColor
                                   atRatio:(CGFloat)ratio;

/**
 * Same as above, but allows turning off the color space comparison
 * for a performance boost.
 */

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio compareColorSpaces:(BOOL)compare;

/**
 * An array of [steps] colors starting with firstColor, continuing with linear interpolations
 * between firstColor and lastColor and ending with lastColor.
 */
+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                                    inSteps:(NSUInteger)steps;

/**
 * An array of [steps] colors starting with firstColor, continuing with interpolations, as specified
 * by the equation block, between firstColor and lastColor and ending with lastColor. The equation block
 * must take a float as an input, and return a float as an output. Output will be santizied to be between
 * a ratio of 0.0 and 1.0. Passing nil for the equation results in a linear relationship.
 */
+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                          withRatioEquation:(float (^)(float))equation
                                    inSteps:(NSUInteger)steps;


/**
 * Convert UIColor to RGBA colorspace. Used for cross-colorspace interpolation.
 */
+ (UIColor *)colorConvertedToRGBA:(UIColor *)colorToConvert;

@end
