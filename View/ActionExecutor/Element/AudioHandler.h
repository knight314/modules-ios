#import <AVFoundation/AVFoundation.h>

@interface AudioHandler : AVAudioPlayer


// count 
@property(assign) NSUInteger intervalsLoops;
@property(strong) NSArray* loopIntervals;


@property(assign) float fadeDelay;
@property(assign) float fadeToVolume;
@property(assign) float fadeOverDuration;


#pragma mark - Class Methods

+(NSOperationQueue *) audioCrossFadeQueue;

+(void) setupAudioSession;

@end
