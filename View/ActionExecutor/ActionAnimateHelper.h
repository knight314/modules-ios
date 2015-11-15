#import <Foundation/Foundation.h>

@class CAKeyframeAnimation;

@interface ActionAnimateHelper : NSObject


+(void) applyFillMode: (NSDictionary*)config animation:(CAKeyframeAnimation*)animation;

+(void) applyTimingsEasing: (NSDictionary*)config animation:(CAKeyframeAnimation*)animation;


@end
