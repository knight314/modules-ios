#import <UIKit/UIKit.h>

#define degreeToRadian(x) (x * M_PI / 180.0)

@interface LayerHelper : NSObject



#pragma mark - Key Values

+(NSDictionary*) propertiesTypes;

+(void) setPropertiesTypes: (NSDictionary*)propertiesTypes;

+(void) setAttributesValues:(NSDictionary*)config layer:(CALayer*)layer;

+(void) setValue:(id)value keyPath:(NSString*)keyPath layer:(CALayer*)layer;



#pragma mark - Public Methods

// change the anchorPOint, but the visual psoition on screen is not change
+(void) setAnchorPoint:(CGPoint)anchorPoint layer:(CALayer*)layer;



+(void) setBottomBorder: (CALayer*)layer;

@end
