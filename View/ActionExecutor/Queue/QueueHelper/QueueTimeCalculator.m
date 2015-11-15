#import "QueueTimeCalculator.h"
#import "_ActionExecutor_.h"

@implementation QueueTimeCalculator
{
    double onePhaseLongestDuration; // can be many exectutors  (ActionExecutorManager runActionExecutors:)
}



#pragma mark - Public Methods
-(void) clear
{
    onePhaseLongestDuration = 0;
}

-(double) take
{
    return onePhaseLongestDuration;
}

-(double) takeThenClear
{
    double temp = [self take];
    [self clear];
    return temp;
}


#pragma mark - QueueExecutorDelegate
-(void)queue:(QueueExecutorBase*)executor beginTimes:(NSArray*)beginTimes durations:(NSArray*)durations
{
    double totalDuration = [[QueueTimeCalculator getExtremeValue: durations isMax:YES] doubleValue];
    if (onePhaseLongestDuration < totalDuration) {
        onePhaseLongestDuration = totalDuration;
    }
    
//    NSLog(@"beginTimes: %@ , duratoins : %@ , totalDuration : %f", beginTimes, durations, totalDuration);
//    NSLog(@"Effect TotalDuration: %f", onePhaseLongestDuration);
}

-(void)queueDidStart:(QueueExecutorBase*)executor animation:(CAAnimation *)anim
{
    
}

-(void)queueDidStop:(QueueExecutorBase*)executor animation:(CAAnimation *)anim finished:(BOOL)flag
{
    
}



#pragma mark - Class Methods

+(NSNumber*) getExtremeValue: (NSArray*)numbers isMax:(BOOL)isMax
{
    NSArray* compares = numbers;
    
    // two dimensional
    if ([ArrayHelper isTwoDimension: numbers]) {
        NSMutableArray* oneDmensionInnerArrayExtremeValues = [NSMutableArray array];
        for (int i = 0; i < numbers.count; i++) {
            NSNumber* element = [self getExtremeValueFromOneDimensionArray: numbers[i] isMax:isMax];
            if (element) [oneDmensionInnerArrayExtremeValues addObject: element];
        }
        compares = oneDmensionInnerArrayExtremeValues;
    }
    
    return [self getExtremeValueFromOneDimensionArray: compares isMax:isMax];
}

+(NSNumber*) getExtremeValueFromOneDimensionArray:(NSArray*)numbers isMax:(BOOL)isMax
{
    NSNumber* value = nil;
    for (int j = 0; j < numbers.count; j++) {
        NSNumber* element = [numbers objectAtIndex: j];
        double elementValue = [element doubleValue];
        
        if (! value) value = element;
        
        // get max
        if (isMax && [value doubleValue] < elementValue) {
            value = element ;
        }
        
        else
            
            // get min
            if (! isMax && [value doubleValue] > elementValue) {
                value = element;
            }
    }
    return value;
}



+(NSMutableArray*) getBaseTimesAccordingToViews: (NSArray*)views delay:(double)delay
{
    if (delay == 0) return nil;
    
    NSNumber* delayNum = @(delay);
    NSMutableArray* baseTimes = [NSMutableArray array];
    for (NSArray* innerViews in views) {
        NSMutableArray* innerBaseTimes = [NSMutableArray array];
        for (int i = 0; i < innerViews.count; i++) {
            [innerBaseTimes addObject:delayNum];
        }
        [baseTimes addObject: innerBaseTimes];
    }
    return baseTimes;
}





@end
