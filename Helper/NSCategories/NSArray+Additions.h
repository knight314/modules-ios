//
//  NSArray+Additions.h
#import <Foundation/Foundation.h>

@interface NSArray (SafeGetter)

/** @return if index >= array.count , will return nil **/
-(id)safeObjectAtIndex:(NSUInteger)index;

@end

// http://stackoverflow.com/questions/586370/how-can-i-reverse-a-nsarray-in-objective-c

@interface NSArray (Reverse)

- (NSArray *)reversedArray;

@end



