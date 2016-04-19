#import "AudioHandler.h"
#import "MXAudioPlayerFadeOperation.h"


@interface AudioHandler() <AVAudioPlayerDelegate>

@end


@implementation AudioHandler
{
    int currentLoopCount;
}

-(instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError *__autoreleasing *)outError
{
    self = [super initWithContentsOfURL:url error:outError];
    if (self) {
        self.delegate = self;
    }
    return self;
}


-(double) getIntervalTime: (int)intervalIndex
{
    NSArray* loopIntervals = self.loopIntervals;
    int lastIndex = (int)loopIntervals.count - 1;
    if (intervalIndex > lastIndex) intervalIndex = lastIndex;
    return [loopIntervals[intervalIndex] doubleValue];
}





#pragma mark - Public Methods


- (void) playAudioInBackgroundThread
{
    if ([NSThread isMainThread]) {
        [self performSelectorInBackground:@selector(play) withObject:nil];
    } else {
        [self play];
    }
}


- (void) fade
{
    MXAudioPlayerFadeOperation *fadeOperation = [[MXAudioPlayerFadeOperation alloc] initFadeWithAudioPlayer:self toVolume:self.fadeToVolume overDuration:self.fadeOverDuration];
    [fadeOperation setDelay: self.fadeDelay];
    [[AudioHandler audioCrossFadeQueue] addOperation:fadeOperation];
}


#pragma mark - AVAudioPlayerDelegate Methods


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (!flag || self.intervalsLoops == 0) return;
    
    if (self.intervalsLoops > 0) {
        // loop is over
        if (currentLoopCount >= self.intervalsLoops) return;
        currentLoopCount++;
    } 
    
    // get interval & play it in background
    double interval = [self getIntervalTime: currentLoopCount - 1];
    [self performSelector:@selector(playAudioInBackgroundThread) withObject:nil afterDelay:interval];
}





#pragma mark - Class Methods


NSOperationQueue *audioFaderQueue;

+(NSOperationQueue *) audioCrossFadeQueue
{
    if (! audioFaderQueue) {
        audioFaderQueue = [[NSOperationQueue alloc] init];
        [audioFaderQueue setMaxConcurrentOperationCount:1];
    }
    return audioFaderQueue;
}


// http://stackoverflow.com/questions/13390039/playing-a-sound-in-ios-pauses-background-music
+(void) setupAudioSession
{
    // AVAudioSessionCategoryOptionMixWithOthers is the key point
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError* categoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&categoryError];
    NSError* activeError = nil;
    [session setActive:YES error:&activeError];
}


@end
