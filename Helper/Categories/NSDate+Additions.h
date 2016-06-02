#import <Foundation/Foundation.h>

@interface NSDate(Operator)

// GT for Greate Than
// LT for Less Than
// EQ for Equal


/**
 *  compare with time
 */
-(BOOL) GT:(NSDate*)date;
-(BOOL) LT:(NSDate*)date;
-(BOOL) EQ:(NSDate*)date;
-(BOOL) GTEQ:(NSDate*)date;
-(BOOL) LTEQ:(NSDate*)date;

/**
 *  compare without time
 */
-(BOOL) GTDate:(NSDate*)date;
-(BOOL) LTDate:(NSDate*)date;
-(BOOL) EQDate:(NSDate*)date;
-(BOOL) GTEQDate:(NSDate*)date;
-(BOOL) LTEQDate:(NSDate*)date;


@end


