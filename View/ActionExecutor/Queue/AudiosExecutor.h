#import "QueueExecutorBase.h"

@interface AudiosExecutor : QueueExecutorBase



@property (strong, readonly) NSMutableDictionary* systemSounds;

@property (strong, readonly) NSMutableDictionary* audiosPlayers;



@property (assign) BOOL disableAudio;



-(void) clearCaches;


@end
