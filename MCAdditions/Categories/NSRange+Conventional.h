NS_INLINE NSRange NSRangeMake(NSUInteger loc, NSUInteger len) {
    return NSMakeRange(loc, len);
}

NS_INLINE NSUInteger NSRangeMax(NSRange range) {
    return NSMaxRange(range);
}

NS_INLINE BOOL NSRangeContainsLocation(NSUInteger loc, NSRange range) {
    return NSLocationInRange(loc, range);
}

NS_INLINE BOOL NSRangeEqualToRange(NSRange range1, NSRange range2) {
    return NSEqualRanges(range1, range2);
}

NS_INLINE NSRange NSRangeZero() {
    NSRange range;
    return range;
}

NS_INLINE NSRange NSRangeUnion(NSRange range1, NSRange range2) {
    return NSUnionRange(range1, range2);
}

NS_INLINE NSRange NSRangeIntersection(NSRange range1, NSRange range2) {
    return NSIntersectionRange(range1, range2);
}

NS_INLINE NSDictionary * NSRangeCreateDictionaryRepresentation(NSRange range) {
    return @{@"location": @(range.location), @"length": @(range.length)};
}

NS_INLINE BOOL NSRangeMakeFromDictionaryRepresentation(NSDictionary *representation, NSRangePointer range) {
    if (!representation[@"location"] || !representation[@"length"]) {
        return NO;
    }

    NSRange r;
    r.location = [representation[@"location"] unsignedIntegerValue];
    r.length = [representation[@"length"] unsignedIntegerValue];
    range = &r;

    return YES;
}