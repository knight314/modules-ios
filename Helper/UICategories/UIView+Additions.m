#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIViewController *)viewController
{
    for (UIView* view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
