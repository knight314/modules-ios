#import "RSACryptor.h"

@interface RSABase64Cryptor : RSACryptor



-(void) loadPublicKeyFromString: (NSString*)derBase64String;
-(void) loadPrivateKeyFromString: (NSString*)p12Base64String password:(NSString*)p12Password;



-(NSString*) rsaBase64EncryptString:(NSString*)string;
-(NSString*) rsaBase64DecryptString:(NSString*)string;


@end
