//
//  NSNull+FilterMessage.m
//  DMS
//
//  Created by suchavision on 2/8/17.
//  Copyright © 2017 Lou Jiwei. All rights reserved.
//

#import "NSNull+FilterMessage.h"

@implementation NSNull (FilterMessage)

-(id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSNull instanceMethodSignatureForSelector: @selector(description)];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    id temp = nil;
    [anInvocation invokeWithTarget: temp];
}

@end
