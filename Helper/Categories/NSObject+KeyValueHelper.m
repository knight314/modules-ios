#import "NSObject+KeyValueHelper.h"
#import <objc/runtime.h>


@implementation NSObject (KeyValueHelper)

- (id)valueForUndefinedKey:(NSString *)key
{
    const char *aKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    return objc_getAssociatedObject(self, aKey);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    id oldValue = [self valueForUndefinedKey: key];
    if (value == oldValue) {
        return;
    }
    
    // first set nil to release the old value, then set the new value
    const char *aKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    objc_setAssociatedObject(self, aKey, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, aKey, value, OBJC_ASSOCIATION_RETAIN);
    
    // for iOS UIView , OS X To Be Continued ...
    if ([self isKindOfClass:[UIView class]] && [oldValue isKindOfClass:[UIView class]]) {
        [(UIView *)oldValue removeFromSuperview];
    }
    if ([self isKindOfClass:[UIView class]] && [value isKindOfClass:[UIView class]]) {
        [((UIView *)self) addSubview:(UIView *)value];
    }
}

@end
