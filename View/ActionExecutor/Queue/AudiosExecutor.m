#import "AudiosExecutor.h"

#import "NSArray+Additions.h"
#import "ViewKeyValueHelper.h"

#import "AudioHandler.h"


@implementation AudiosExecutor


@synthesize systemSounds;

@synthesize audiosPlayers;



-(void)execute:(NSDictionary *)config objects:(NSArray *)objects values:(NSArray *)values times:(NSArray *)times durationsRep:(NSMutableArray *)durationsQueue beginTimesRep:(NSMutableArray *)beginTimesQueue
{

    id value = [values firstObject];
    if (!value) value = config[@"values"];
    
    double inactivityTime = [[times firstObject] doubleValue];
    if (inactivityTime > 0) {
//        double delayTime = [config[@"delay"] doubleValue];
        NSArray* resources = @[config, value];
        [self performSelector:@selector(playAudionAfterDelay:) withObject:resources afterDelay:inactivityTime];
    } else {
        [self playAudio: config value:value];
    }
}

-(void) playAudionAfterDelay: (NSArray*)resources
{
    NSDictionary* config = [resources firstObject];
    id value = [resources lastObject];
    
    [self playAudio: config value:value];
}


// http://stackoverflow.com/questions/13390039/playing-a-sound-in-ios-pauses-background-music

+ (void)setupAudioSession {

    // Deprecated:Deprecated in iOS 7.0.
    
    /*
    AudioSessionInitialize(NULL,NULL,NULL,NULL);
    
    OSStatus activationResult = 0;
    activationResult = AudioSessionSetActive(true);
    
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    
    UInt32 allowMixing = true;
    OSStatus propertySetError = 0;
    propertySetError = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers,sizeof(allowMixing),&allowMixing);
    */
    
    // AVAudioSessionCategoryOptionMixWithOthers is the key point
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError* categoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&categoryError];
    NSError* activeError = nil;
    [session setActive:YES error:&activeError];
}



-(void) playAudio: (NSDictionary*)config value:(id)value 
{
    if (self.disableAudio) return;
    if (![value isKindOfClass:[NSString class]]) return;
    
    BOOL isSystemSound = [config[@"isSystemSound"] boolValue];
    
    if (isSystemSound) {
        
        if (!systemSounds) {
            systemSounds = [NSMutableDictionary dictionary];
        }
      
#if __LP64__
        SystemSoundID soundID = [systemSounds[value] unsignedIntValue];
#else
        SystemSoundID soundID = [systemSounds[value] unsignedLongValue];
#endif
        if (soundID == 0) {
            
            NSString* path = [ViewKeyValueHelper getResourcePath: value];
            NSURL* soundURL = [NSURL fileURLWithPath:path];
            AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)soundURL, &soundID);
            
#if __LP64__
            NSNumber* soundIDNumber = [NSNumber numberWithUnsignedInt:soundID];
#else
            NSNumber* soundIDNumber = [NSNumber numberWithUnsignedInteger:soundID];
#endif
            [systemSounds setObject:soundIDNumber forKey:value];
            
        }
        AudioServicesPlaySystemSound(soundID);
        
        
    } else {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [AudiosExecutor setupAudioSession];
        });
        
        if (!audiosPlayers) {
            audiosPlayers = [NSMutableDictionary dictionary];
        }
        
        AudioHandler* audioPlayer = [audiosPlayers objectForKey: value];
        
        if (! audioPlayer) {
            NSString* path = [ViewKeyValueHelper getResourcePath: value];
            NSError* error = nil;
            audioPlayer = [[AudioHandler alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error: &error];
            if (error) return;
            [audiosPlayers setObject: audioPlayer forKey:value];
            [audioPlayer prepareToPlay];
        }
        
        // u can set 'volume' / 'numberOfLoops' / 'currentTime' / 'intervalsLoops' ...
        if (config[@"player"]) {
            [[ViewKeyValueHelper sharedInstance] setValues: config[@"player"] object:audioPlayer];
        }
        
        // such as 'pause' / 'stop' / 'play' , default 'playAudioInBackground'
        SEL selector = @selector(play);
        if (config[@"selector"]) {
            selector = NSSelectorFromString(config[@"selector"]);
        }
        [audioPlayer performSelectorInBackground:selector withObject:nil];
    }
    
    
}



-(void) clearCaches
{
    for (NSString* value in systemSounds) {
#if __LP64__
        SystemSoundID soundID = [systemSounds[value] unsignedIntValue];
#else
        SystemSoundID soundID = [systemSounds[value] unsignedLongValue];
#endif
        
        AudioServicesDisposeSystemSoundID(soundID);
    }
    [systemSounds removeAllObjects];
    
    // 
    for (NSString* value in audiosPlayers) {
        AudioHandler* audioPlayer = audiosPlayers[value];
        [audioPlayer stop];
    }
    [audiosPlayers removeAllObjects];
    
}


@end
