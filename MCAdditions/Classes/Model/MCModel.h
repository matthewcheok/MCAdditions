//
//  MCModel.h
//  GuitarScript
//
//  Created by Matthew Cheok on 16/1/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <Mantle.h>

@interface MCModel : MTLModel <MTLJSONSerializing>

/**
 *  Convenience methods to deserialize an object from its JSON dictionary representation
 *
 *  @param JSONDictionary JSON deserialized in NSDictionary
 *  @param error          Any error that occurs
 *
 *  @return The deserialized object
 */
+ (instancetype)modelWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;
- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;

/**
 *  Convenience method to deserialize objects from an array of JSON dictionary representations
 *
 *  @param JSONArray An array containing JSON deserialized NSDictionary items
 *
 *  @return An array containing the deserialized objects
 */
+ (NSArray *)arrayOfModelFromJSONArray:(NSArray *)JSONArray;

/**
 *  Informs the class of items contained in collections (like NSArray)
 *  Required if properties contain MCModel subclasses
 *
 *  @param key Name of property
 *
 *  @return Class of items in collection
 */
+ (Class)collectionItemClassForKey:(NSString *)key;
+ (NSDictionary *)JSONKeyPathsByPropertyKey;

/**
 *  Updates properties of current model from JSON dictionary representation
 *
 *  @param JSONDictionary JSON deserialized in NSDictionary
 *  @param error          Any error that occurs
 *
 *  @return Boolean indicating the success of the operation
 */
- (BOOL)updateWithJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;

- (NSDictionary *)JSONDictionary;

@end
