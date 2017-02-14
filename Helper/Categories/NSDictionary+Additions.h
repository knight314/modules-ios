#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (NSMutableDictionary *)deepCopy ;

- (void)deepCopyTo:(NSMutableDictionary*)destination ;

@end
