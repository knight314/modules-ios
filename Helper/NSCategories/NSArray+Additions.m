//
//  NSArray+Additions.m

#import "NSArray+Additions.h"

@implementation NSArray (SafeGetter)

-(id)safeObjectAtIndex:(NSUInteger)index
{
    return index >= self.count ? nil : [self objectAtIndex: index];
}


@end


@implementation NSArray (Reverse)

- (NSArray *)reversedArray {
    return [[self reverseObjectEnumerator] allObjects];
}

@end




