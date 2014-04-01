//
//  MCModel.m
//  GuitarScript
//
//  Created by Matthew Cheok on 16/1/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCModel.h"

#import <MTLReflection.h>
#import <objc/runtime.h>

@implementation MCModel

static NSString* MCTypeStringFromPropertyKey(Class class, NSString *key) {
    const char *type = property_getAttributes(class_getProperty(class, [key UTF8String]));
	return [NSString stringWithUTF8String:type];
}

+ (BOOL)isBooleanTypeForPropertyKey:(NSString *)key {
    return [MCTypeStringFromPropertyKey(self, key) hasPrefix:@"TB"];
}

+ (Class)classForPropertyKey:(NSString *)key {
	NSString *attributes = MCTypeStringFromPropertyKey(self, key);
	if ([attributes hasPrefix:@"T@"]) {
		NSString *string;
		NSScanner *scanner = [NSScanner scannerWithString:attributes];
		[scanner scanUpToString:@"\"" intoString:NULL];
		[scanner scanString:@"\"" intoString:NULL];
		[scanner scanUpToString:@"\"" intoString:&string];
		return NSClassFromString(string);
	}
	return nil;
}

+ (Class)collectionItemClassForKey:(NSString *)key {
	return nil;
}

#pragma mark - JSON

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{};
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
	Class class = [self classForPropertyKey:key];
    
    // nested model
	if ([class isSubclassOfClass:[MCModel class]]) {
		return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:class];
	}
    
    // array
	else if ([class isSubclassOfClass:[NSArray class]]) {
        Class collectionClass = nil;
        
        SEL selector = MTLSelectorWithKeyPattern(key, "CollectionItemClass");
        if ([self respondsToSelector:selector]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
            invocation.target = self;
            invocation.selector = selector;
            [invocation invoke];
            
            [invocation getReturnValue:&collectionClass];
        }
        else if ([self respondsToSelector:@selector(collectionItemClassForKey:)]) {
            collectionClass = [self collectionItemClassForKey:key];
        }
        
		if ([collectionClass isSubclassOfClass:[MCModel class]]) {
			return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:collectionClass];
		}
	}
    
    // url
    else if ([class isSubclassOfClass:[NSURL class]]) {
        return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
    }
    
    // boolean
    else if ([self isBooleanTypeForPropertyKey:key]) {
        return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
    }
    
	return nil;
}

#pragma mark - Properties

- (NSDictionary *)JSONDictionary {
    return [MTLJSONAdapter JSONDictionaryFromModel:self];
}

#pragma mark - Methods

+ (instancetype)modelWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error {
	return [[self alloc] initWithJSONDictionary:JSONDictionary error:error];
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error {
	return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:JSONDictionary error:error];
}

+ (NSArray *)arrayOfModelFromJSONArray:(NSArray *)JSONArray {
	NSMutableArray *result = [NSMutableArray array];
	for (NSDictionary *JSONDictionary in JSONArray) {
		id object = [self modelWithJSONDictionary:JSONDictionary error:nil];
		if (object) {
			[result addObject:object];
		}
	}
	return result;
}

- (BOOL)updateWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error {
	// create a temporary object then merge it by its JSON keys
	typeof(self) model = [[self class] modelWithJSONDictionary:JSONDictionary error:error];
	if (*error != nil) {
		return NO;
	}
    
	NSArray *keysOfJSONProperties = [[[self class] JSONKeyPathsByPropertyKey] allKeys];
	for (NSString *key in keysOfJSONProperties) {
		[self mergeValueForKey:key fromModel:model];
	}
	return YES;
}

@end
