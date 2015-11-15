#import <UIKit/UIKit.h>




#define CanvasX(x) [FrameTranslater convertCanvasX: x]
#define CanvasY(y) [FrameTranslater convertCanvasY: y]
#define CanvasW(w) [FrameTranslater convertCanvasWidth: w]
#define CanvasH(h) [FrameTranslater convertCanvasHeight: h]

#define CanvasFontSize(px) [FrameTranslater convertFontSize: px]

#define CanvasSize(w, h) [FrameTranslater convertCanvasSize: CGSizeMake(w, h)]
#define CanvasPoint(x, y) [FrameTranslater convertCanvasPoint: CGPointMake(x, y)]
#define CanvasRect(x, y, w, h) [FrameTranslater convertCanvasRect: CGRectMake(x, y, w, h)]

#define CanvasCGSize(size) [FrameTranslater convertCanvasSize: size]
#define CanvasCGRect(rect) [FrameTranslater convertCanvasRect: rect]
#define CanvasCGPoint(point) [FrameTranslater convertCanvasPoint: point]







@interface FrameTranslater : NSObject


#pragma mark -

+(CGSize) canvasSize;
+(void) setCanvasSize: (CGSize)canvas;


#pragma mark -

+(void) transformView: (UIView*)view;

+(CGFloat) convertFontSize: (CGFloat)fontSize ;


#pragma mark -

+(CGFloat) convertCanvasX: (CGFloat)x ;
+(CGFloat) convertCanvasY: (CGFloat)y ;
+(CGFloat) convertCanvasWidth: (CGFloat)x ;
+(CGFloat) convertCanvasHeight: (CGFloat)y ;

+(CGSize) convertCanvasSize: (CGSize)size;
+(CGRect) convertCanvasRect: (CGRect)canvas ;
+(CGPoint) convertCanvasPoint: (CGPoint)point;


#pragma mark -

CGFloat CGSizeGetMax(CGSize size);
CGFloat CGSizeGetMin(CGSize size);

@end
