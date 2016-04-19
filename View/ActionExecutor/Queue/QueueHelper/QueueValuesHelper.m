#import "QueueValuesHelper.h"

#import "LayerHelper.h"
#import "KeyValueHelper.h"

@implementation QueueValuesHelper


+(NSMutableArray*) translateValues: (NSString*)keyPath object:(UIView*)object values:(NSArray*)values
{
    NSMutableArray* results = [NSMutableArray array];
    NSString* keyPathType = [LayerHelper propertiesTypes][keyPath];
    for (NSUInteger i = 0; i < values.count; i++) {
        id value = values[i];
        id newValue = nil;
        
        // "c_v", current value
        if ([value isKindOfClass:[NSString class]] && [value isEqualToString:@"c_v"]) {
            newValue = [object.layer valueForKeyPath:keyPath];
        } else {
            newValue = [KeyValueHelper translateValue:value type:keyPathType];
        }
        
        [results addObject:newValue];
    }
    return results.count ? results : nil;
}

@end
