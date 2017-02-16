#import <UIKit/UIKit.h>

#define kColorRGB(r, g, b)                  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kColorRGBWithAlpha(r, g, b, alpha)  [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:alpha]

#define kColorHex(__HEX__)                      [UIColor colorWithRed:((float)((__HEX__ & 0xFF0000) >> 16))/255.0 green:((float)((__HEX__ & 0xFF00) >> 8))/255.0 blue:((float)(__HEX__ & 0xFF))/255.0 alpha:1.0]

#define kColorHexWithAlpha(__HEX__, alpha)      [UIColor colorWithRed:((float)((__HEX__ & 0xFF0000) >> 16))/255.0 green:((float)((__HEX__ & 0xFF00) >> 8))/255.0 blue:((float)(__HEX__ & 0xFF))/255.0 alpha:alpha]

@interface UIColor (Additions)

- (instancetype)alpha:(CGFloat)alpha;

@end
