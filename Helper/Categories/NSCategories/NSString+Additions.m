#import "NSString+Additions.h"

@implementation NSString (Additions)

// compatibility of NSNumber & NSString
- (NSString *)stringValue {
    return self;
}

-(BOOL) isEqualToStringIgnoreCase: (NSString*)string {
    return [[self lowercaseString] isEqualToString: [string lowercaseString]];
}

@end

