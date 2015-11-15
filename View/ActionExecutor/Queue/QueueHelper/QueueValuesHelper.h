#import <UIKit/UIKit.h>

@interface QueueValuesHelper : NSObject


+(NSMutableArray*) translateValues: (NSString*)keyPath object:(UIView*)object values:(NSArray*)values;


@end
