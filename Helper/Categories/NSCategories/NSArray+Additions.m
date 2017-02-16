#import "NSArray+Additions.h"
#import "NSDictionary+Additions.h"

@implementation NSArray (Additions)

- (id)safeObjectAtIndex:(NSUInteger)index {
    return index >= self.count ? nil : [self objectAtIndex: index];
}

- (NSArray *)reversedArray {
    return [[self reverseObjectEnumerator] allObjects];
}

@end


@implementation NSArray (DeepCopy)

// Note here , this method do not copy the deepest element object, just copy array & dictionay
- (NSMutableArray *)deepCopy {
    NSMutableArray* destination = [NSMutableArray array];
    [self deepCopyTo:destination];
    return destination;
}

- (void)deepCopyTo:(NSMutableArray*)destination {
    for (int i = 0; i < self.count; i++) {
        id obj = [self objectAtIndex: i];
        
        if ([obj isKindOfClass: [NSArray class]]) {
            obj = [obj deepCopy];
        } else if ([obj isKindOfClass: [NSDictionary class]]) {
            obj = [(NSDictionary *)obj deepCopy];
        }
        [destination addObject: obj];
    }
}


@end
