#import "UILabel+AdjustWidth.h"

@implementation UILabel (AdjustWidth)

- (id)initWithText:(NSString*)text
{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"Arial" size:20];
		self.textColor = [UIColor blackColor];
		self.backgroundColor = [UIColor clearColor];
		self.highlightedTextColor = [UIColor blackColor];
		self.textAlignment = NSTextAlignmentCenter;
		self.text = text;
        if (text)[self adjustWidthToFontText];
    }
    return self;
}

// Take a look :
// iOS Development: You're Doing It Wrong
//http://doing-it-wrong.mikeweller.com/2012/07/youre-doing-it-wrong-2-sizing-labels.html
// Am i doing wrong here ?
// https://github.com/MikeWeller/ButtonInsetsPlayground   comment line 159 [self sizeButtonToFit] to see .
-(void) adjustWidthToFontText {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    CGSize textSize = [self.text sizeWithAttributes: @{NSFontAttributeName: self.font}];
#else
    CGSize textSize = [self.text sizeWithFont:self.font];
#endif
    CGRect frame = self.frame;
    frame.size.width = textSize.width;
    self.frame = frame;                     // when you change the frame , the center will be changed. when you change the center, the frame's origin will be changed
}

-(void) adjustFontSizeToWidth
{
    while ( [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}].width > self.frame.size.width) {
        self.font = [self.font fontWithSize: (self.font.pointSize - 8)];
        // be aware of infinite loop
        if (self.font.pointSize < 8) {
            break;
        }
    }
}

@end
