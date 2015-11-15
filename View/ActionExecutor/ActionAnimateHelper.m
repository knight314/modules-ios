#import "ActionAnimateHelper.h"
#import "_ActionExecutor_.h"

@implementation ActionAnimateHelper


+(void) applyFillMode: (NSDictionary*)config animation:(CAKeyframeAnimation*)animation
{
    int fillMode = [config[@"fillMode"] intValue];
    
    BOOL isRemoved = YES;
    NSString* mode = kCAFillModeRemoved ;
    
    switch (fillMode) {
        case 0:
            isRemoved = YES;
            break;
        case 1:
            isRemoved = NO;
            mode = kCAFillModeForwards;
            break;
        case 2:
            isRemoved = NO;
            mode = kCAFillModeBackwards;
            break;
        case 3:
            isRemoved = NO;
            mode = kCAFillModeBoth;
            break;
        case 4:
            isRemoved = NO;
            mode = kCAFillModeRemoved;
            break;
            
        default:
            break;
    }
    
    // IOS default is YES, when removedOnCompletion = NO , the fillMode would work.
    animation.removedOnCompletion = isRemoved;
    // IOS default is kCAFillModeRemoved
    animation.fillMode = mode ;
    
}


// when controll each , should after setKeyTimes (need the keyTimes was set)
+(void) applyTimingsEasing: (NSDictionary*)config animation:(CAKeyframeAnimation*)animation
{
    float c1x = 0, c1y = 0, c2x = 0, c2y = 0;
    NSArray* points = config[@"queue.timeControl.points"];
    c1x = [[points safeObjectAtIndex:0] floatValue];
    c1y = [[points safeObjectAtIndex:1] floatValue];
    c2x = [[points safeObjectAtIndex:2] floatValue];
    c2y = [[points safeObjectAtIndex:3] floatValue];
    
        
    NSNumber* controllWhole = [config objectForKey: @"queue.timeControl.whole"];
    BOOL isControllWhole = controllWhole ? [controllWhole boolValue] : YES;               // default is YES
    if(isControllWhole) animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints: c1x :c1y :c2x :c2y];
    
    
    BOOL isControllFrame = [[config objectForKey: @"queue.timeControl.frame"] boolValue];
    if (isControllFrame) {
        NSUInteger count = animation.keyTimes.count;
        NSMutableArray* timingFunctions = [NSMutableArray arrayWithCapacity: count];
        for (NSUInteger i = 0; i < count - 1 ; i++ ) {
            [timingFunctions addObject: [CAMediaTimingFunction functionWithControlPoints: c1x :c1y :c2x :c2y]];
        }
        animation.timingFunctions = timingFunctions;
    }
    
    
}

@end
