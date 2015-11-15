#import "NSString+Additions.h"

@implementation NSString (Additions)

-(BOOL) isEqualToStringIgnoreCase: (NSString*)string
{
    return [[self lowercaseString] isEqualToString: [string lowercaseString]];
}

@end

