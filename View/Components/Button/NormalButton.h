#import <UIKit/UIKit.h>

@interface NormalButton : UIButton

@property (copy) void(^didTouchUpInsideAction)(NormalButton* sender);


-(void) setupWithConfig: (NSDictionary*)config;


@end
