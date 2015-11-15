#import "LocalizeManager.h"


#define __StringContains__(str, x) [str rangeOfString:x options:NSCaseInsensitiveSearch].location != NSNotFound     // cause containsString: method for ios >= 8.0. note ignore case


static NSString* currentLanguage = nil ;

static NSString* stringsFileSanboxPath = nil;


@implementation LocalizeManager

+(void)initialize {
    currentLanguage = [[NSLocale preferredLanguages] firstObject];
    
    if (! ([currentLanguage isEqualToString:LANGUAGE_zh_Hans] || [currentLanguage isEqualToString:LANGUAGE_zh_Hant])) {
        
        if (__StringContains__(currentLanguage, LANGUAGE_zh_HK) || __StringContains__(currentLanguage, LANGUAGE_zh_TW)) {
            currentLanguage = LANGUAGE_zh_Hant ;
        } else if (__StringContains__(currentLanguage, LANGUAGE_zh)) {
            currentLanguage = LANGUAGE_zh_Hans;
        }
        
    }

    [super initialize];
}


+(NSString*) currentLanguage {
    return currentLanguage;
}

+(void) setCurrentLanguage: (NSString*)language {
    if (language) currentLanguage = language;
}


+(void) setStringsFileSanboxPath: (NSString*)path {
    stringsFileSanboxPath = path;
}


+(NSString*) getLocalized: (NSString*)key {
    return [self getLocalized: key language:currentLanguage];
}

+(NSString*) getLocalized:(NSString *)key language:(NSString*)language
{
    // In Sandbox
    NSString* value = [self getLocalizedInSandbox:key language:language];
    
    // In Bundles
    if (! value) {
        value = NSLocalizedStringFromTable(key, language, nil);
    }
    
    return value;
}


static NSString* previousLanguage;
static NSDictionary* previousLanguageBuffer;

+(NSString*) getLocalizedInSandbox: (NSString*)key language:(NSString*)language {
    if (! stringsFileSanboxPath)  return nil;
    
    if (previousLanguage != language) {
        previousLanguage = language;
        previousLanguageBuffer = nil;
    }
    
    if (!previousLanguageBuffer) {
        NSString* languagePath = [[stringsFileSanboxPath stringByAppendingPathComponent:language] stringByAppendingPathExtension:@".strings"];
        NSData* data = [NSData dataWithContentsOfFile: languagePath];
        if (!data) return nil;
        
        NSError* error = nil;
        NSPropertyListFormat* format = nil;
        previousLanguageBuffer = [NSPropertyListSerialization propertyListWithData: data options:NSPropertyListImmutable format:format error:&error];
    }
    return previousLanguageBuffer[key];
}


#pragma mark - Helper Methods

+(NSString*) connect: (NSString*)key, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableString* result = [[NSMutableString alloc] init];
    
    va_list list;
    va_start(list, key);
    do {
        [result appendString:I18N(key)];
        key = va_arg(list, NSString*);
    } while (key);
    va_end(list);
    
    return [result description];
}

@end
