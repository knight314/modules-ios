#import <Foundation/Foundation.h>

@interface RSACryptor : NSObject



#pragma mark - Initialize Methods

-(void) loadPublicKeyFromData: (NSData*) derData;
-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;

-(SecKeyRef) getPublicKey;
-(SecKeyRef) getPrivateKey;


#pragma mark - Encrypt And Decrypt

-(NSData*) rsaPublicKeyEncryptData:(NSData*)data ;
-(NSData*) rsaPublicKeyEncryptData:(NSData*)data key:(SecKeyRef)key;

-(NSData*) rsaPrivateKeyDecryptData:(NSData*)data;
-(NSData*) rsaPrivateKeyDecryptData:(NSData*)data key:(SecKeyRef)key;






#pragma mark - Class Methods

+(RSACryptor*) sharedInstance;
+(void) setSharedInstance: (RSACryptor*)instance;


@end
