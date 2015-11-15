#import <Foundation/Foundation.h>
#import "QueueExecutorBase.h"

@interface QueueTimeCalculator : NSObject <QueueExecutorDelegate>


#pragma mark - Public Methods

-(void) clear;
-(double) take;
-(double) takeThenClear;




#pragma mark - Class Methods

+(NSMutableArray*) getBaseTimesAccordingToViews: (NSArray*)views delay:(double)delay;



@end
