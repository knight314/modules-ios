#import "NormalButton.h"

@implementation NormalButton


+ (id)buttonWithType:(UIButtonType)buttonType {
    NormalButton* button = [super buttonWithType:buttonType];
    [button initializeValues];
    return button;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeValues];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initializeValues];
}

-(void) initializeValues
{
    [self addTarget: self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void) buttonTouchUpInsideAction: (id)sender
{
    if (self.didTouchUpInsideAction) self.didTouchUpInsideAction(sender);
}

@end
