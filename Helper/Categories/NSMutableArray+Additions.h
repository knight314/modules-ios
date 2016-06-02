//
//  NSMutableArray+Additions.h
#import <Foundation/Foundation.h>

@interface NSMutableArray (Movement)

-(void) moveLastObjectToFirst;
-(void) moveFirstObjectToLast;

@end




@interface NSMutableArray (SafeReplace)

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end





@interface NSMutableArray (Reverse)

- (void)reverse ;

@end
