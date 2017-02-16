#import <Foundation/Foundation.h>

@interface NSMutableArray (Move)

-(void) moveLastObjectToFirst;
-(void) moveFirstObjectToLast;
- (void)reverse ;

@end


@interface NSMutableArray (Replace)

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end


@interface NSMutableArray (Remove)

- (void)removeObjectUsingComparator:(BOOL(^)(int index, id obj))comparator ;

@end
