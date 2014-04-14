//
//  MCDateValueTransformer.m
//  Pods
//
//  Created by Matthew Cheok on 30/3/14.
//
//

#import "MCModelDateValueTransformer.h"
#import <ISO8601DateFormatter.h>

NSString * const MCModelDateValueTransformerName = @"MCModelDateValueTransformerName";
NSString * const MCModelDateTimeValueTransformerName = @"MCModelDateTimeValueTransformerName";

@interface MCModelDateValueTransformer ()

@property (strong, nonatomic) ISO8601DateFormatter *formatter;

@end

@implementation MCModelDateValueTransformer

+ (void)load {
    @autoreleasepool {
        [NSValueTransformer setValueTransformer:[[self alloc] initWithFormatterDisplayingTime:NO] forName:MCModelDateValueTransformerName];
        [NSValueTransformer setValueTransformer:[[self alloc] initWithFormatterDisplayingTime:YES] forName:MCModelDateTimeValueTransformerName];
    }
}

- (instancetype)initWithFormatterDisplayingTime:(BOOL)displaysTime {
    self = [super init];
    if (self) {
        _formatter = [[ISO8601DateFormatter alloc] init];
        _formatter.includeTime = displaysTime;
    }
    return self;
}

+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    return [self.formatter dateFromString:value];
}

- (id)reverseTransformedValue:(id)value {
    return [self.formatter stringFromDate:value];
}

@end
