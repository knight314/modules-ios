#import "NSDictionary+Additions.h"
#import "NSArray+Additions.h"

@implementation NSDictionary (Additions)

// Note here , this method do not copy the deepest element object, just copy array & dictionay
- (NSMutableDictionary *)deepCopy {
    NSMutableDictionary* destination = [NSMutableDictionary dictionary];
    [self deepCopyTo:destination];
    return destination;
}

- (void)deepCopyTo:(NSMutableDictionary*)destination {
    for (NSString* key in self) {
        id obj = [self objectForKey: key];
        
        if ([obj isKindOfClass: [NSDictionary class]]) {
            obj = [obj deepCopy];
        } else if ([obj isKindOfClass: [NSArray class]]) {
            obj = [(NSArray *)obj deepCopy];
        }
        [destination setObject: obj forKey:key];
    }
}


@end
