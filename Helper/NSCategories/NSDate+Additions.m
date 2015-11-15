#import "NSDate+Additions.h"
#import "_DateHelper.h"


@implementation NSDate(Operator)

/**
 *  compare with time
 */

-(BOOL) GT:(NSDate*)date
{
    return [self compare: date] == NSOrderedDescending;
}

-(BOOL) LT:(NSDate*)date
{
    return [self compare: date] == NSOrderedAscending;
}

-(BOOL) EQ:(NSDate*)date
{
    return [self compare: date] == NSOrderedSame;
}

-(BOOL) GTEQ:(NSDate*)date
{
    return [self GT: date] || [self EQ:date];
}

-(BOOL) LTEQ:(NSDate*)date
{
    return [self LT: date] || [self EQ:date];
}


/**
 *  compare without time
 */
-(BOOL) GTDate:(NSDate*)date
{
    return [[DateHelper truncateTime:self] GT: [DateHelper truncateTime:date]];
}

-(BOOL) LTDate:(NSDate*)date
{
    return [[DateHelper truncateTime:self] LT: [DateHelper truncateTime:date]];
}

-(BOOL) EQDate:(NSDate*)date
{
    return [[DateHelper truncateTime:self] EQ: [DateHelper truncateTime:date]];
}

-(BOOL) GTEQDate:(NSDate*)date
{
    return [self GTDate: date] || [self EQDate:date];
}

-(BOOL) LTEQDate:(NSDate*)date
{
    return [self LTDate: date] || [self EQDate:date];
}


@end