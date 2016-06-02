//
//  NSMutableArray+Additions.m

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Movement)


-(void) moveFirstObjectToLast
{
    id firstObj = [self firstObject];
    if (! firstObj) return;
    [self removeObjectAtIndex: 0];
    [self addObject: firstObj];
}

-(void) moveLastObjectToFirst
{
    id lastObj = [self lastObject];
    if (! lastObj) return;                      // just the case self.count == 0
    [self removeObjectAtIndex: self.count - 1];
    [self insertObject: lastObj atIndex:0];
}

@end




@implementation NSMutableArray (SafeReplace)


- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    index < self.count ? [self replaceObjectAtIndex: index withObject:anObject] : [self addObject: anObject];
}

@end




@implementation NSMutableArray (Reverse)

- (void)reverse {
    if ([self count] == 0)
    return;
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        
        i++;
        j--;
    }
}

@end