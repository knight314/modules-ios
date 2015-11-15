#import "RSABase64Cryptor.h"


@implementation RSABase64Cryptor


-(void) loadPublicKeyFromString: (NSString*)derBase64String
{
    [self loadPublicKeyFromData: [[NSData alloc] initWithBase64EncodedString:derBase64String options:NSDataBase64DecodingIgnoreUnknownCharacters]];
}
-(void) loadPrivateKeyFromString: (NSString*)p12Base64String password:(NSString*)p12Password
{
    [self loadPrivateKeyFromData: [[NSData alloc] initWithBase64EncodedString:p12Base64String options:NSDataBase64DecodingIgnoreUnknownCharacters] password:p12Password];
}



-(NSString*) rsaBase64EncryptString:(NSString*)string {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encryptedData = [self rsaPublicKeyEncryptData: data];
    NSString* base64EncryptedString = [encryptedData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64EncryptedString;
}

-(NSString*) rsaBase64DecryptString:(NSString*)string {
    NSData* data = [[NSData alloc] initWithBase64EncodedString: string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* decryptData = [self rsaPrivateKeyDecryptData: data];
    NSString* result = [[NSString alloc] initWithData: decryptData encoding:NSUTF8StringEncoding];
    return result;
}



@end
