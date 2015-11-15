#import "NSString+URLEncode.h"


@implementation NSString (URLEncode)


// http://en.wikipedia.org/wiki/Percent-encoding

// http://stackoverflow.com/a/8088484/1749293

// http://stackoverflow.com/a/5507550/1749293
// http://stackoverflow.com/a/15651591/1749293
// http://stackoverflow.com/a/15651617/1749293


-(NSString*) URLEncode
{
    NSString* encode = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)self, nil, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return encode;
}

-(NSString*) URLDecode
{
    NSString *decoded = [[(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *decoded = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    return decoded;
}

@end
