#import <UIKit/UIKit.h>


typedef id(^KeyValueCodingTranslator)(NSObject* obj, id value, NSString* type, NSString* key);

@interface KeyValueHelper : NSObject

-(KeyValueCodingTranslator) translateValueHandler;

-(void) setTranslateValueHandler:(KeyValueCodingTranslator)handler;

#pragma mark - Public Methods

-(void) setValues: (NSDictionary*)config object:(NSObject*)object;
-(void) setValue:(id)value keyPath:(NSString*)keyPath object:(NSObject*)object;
-(void) setValue:(id)value keyPath:(NSString*)keyPath object:(NSObject*)object propertiesTypes:(NSDictionary*)propertiesTypes;


#pragma mark - Class Methods

+(KeyValueHelper*) sharedInstance;

+(void) setSharedInstance:(KeyValueHelper*)obj;

+(NSArray *)getClassPropertiesNames: (Class)clazz;

+(NSMutableDictionary *)getClassPropertieTypes:(Class)clazz;

+(id) translateValue:(id)value type:(NSString*)type;

+(UIImage*) getUIImageByPath: (NSString*)path;

+(NSString*) getResourcePath: (NSString*)path;

@end
