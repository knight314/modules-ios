#import "LayerHelper.h"

#import "KeyValueHelper.h"


@implementation LayerHelper



#pragma mark - Key Values

NSDictionary* layerPropertiesTypes = nil;

+(NSDictionary*) propertiesTypes
{
    if (! layerPropertiesTypes) {
        layerPropertiesTypes = [KeyValueHelper getClassPropertieTypes: [CALayer class]];
    }
    return layerPropertiesTypes;
}

+(void) setPropertiesTypes: (NSDictionary*)propertiesTypes
{
    layerPropertiesTypes = propertiesTypes;
}

+(void) setAttributesValues:(NSDictionary*)config layer:(CALayer*)layer
{
    for (NSString* keyPath in config) {
        [self setValue: config[keyPath] keyPath:keyPath layer:layer];
    }
}

+(void) setValue:(id)value keyPath:(NSString*)keyPath layer:(CALayer*)layer
{
    NSString* keyPathType = [self propertiesTypes][keyPath];
    id newValue = [KeyValueHelper translateValue:value type:keyPathType];
    [layer setValue: newValue forKeyPath:keyPath];
}



#pragma mark - Public Methods

+(void) setAnchorPoint:(CGPoint)anchorPoint layer:(CALayer*)layer
{
    CGRect oldFrame = layer.frame;
    layer.anchorPoint = anchorPoint;
    layer.frame = oldFrame;
}



+(void) setBottomBorder: (CALayer*)layer
{
    CALayer *bottomBorderLayer = [CALayer layer];
    
    bottomBorderLayer.frame = CGRectMake(0, layer.frame.size.height - 1, layer.frame.size.width, 1.0f);
    
    bottomBorderLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    [layer addSublayer:bottomBorderLayer];
}

@end
