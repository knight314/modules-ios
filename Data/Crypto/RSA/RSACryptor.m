#import "RSACryptor.h"

#import <Security/Security.h>


//  Base64
// https://github.com/l4u/NSData-Base64

// RSA Encrypt
// http://stackoverflow.com/questions/4211484/send-rsa-public-key-to-iphone-and-use-it-to-encrypt


// RSA Decrypt
// http://stackoverflow.com/questions/10579985/how-can-i-get-seckeyref-from-der-pem-file
// http://stackoverflow.com/questions/23615932/x-509-rsa-encryption-decryption-ios


// Get Exponent and Modulus
// http://stackoverflow.com/questions/3116907/rsa-get-exponent-and-modulus-given-a-public-key


@implementation RSACryptor
{
    SecKeyRef publicKey;
    SecKeyRef privateKey;
}


-(void)dealloc
{
    CFRelease(publicKey);
    CFRelease(privateKey);
}



-(SecKeyRef) getPublicKey {
    return publicKey;
}

-(SecKeyRef) getPrivateKey {
    return privateKey;
}


/*
-(void) loadPublicKeyFromFile: (NSString*) derFilePath
{
    NSData *derData = [[NSData alloc] initWithContentsOfFile:derFilePath];
    [self loadPublicKeyFromData: derData];
}
-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password
{
    NSData *p12Data = [NSData dataWithContentsOfFile:p12FilePath];
    [self loadPrivateKeyFromData: p12Data password:p12Password];
}
*/



-(void) loadPublicKeyFromData: (NSData*) derData
{
    publicKey = [self getPublicKeyRefrenceFromeData: derData];
}
-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password
{
    privateKey = [self getPrivateKeyRefrenceFromData: p12Data password: p12Password];
}




#pragma mark - Private Methods

-(SecKeyRef) getPublicKeyRefrenceFromeData: (NSData*)derData
{
    SecCertificateRef certificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef trust;
    OSStatus status = SecTrustCreateWithCertificates(certificate, policy, &trust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(trust, &trustResult);
    }
    SecKeyRef securityKey = SecTrustCopyPublicKey(trust);
    CFRelease(certificate);
    CFRelease(policy);
    CFRelease(trust);
    
    return securityKey;
}


-(SecKeyRef) getPrivateKeyRefrenceFromData: (NSData*)p12Data password:(NSString*)password
{
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    
    return privateKeyRef;
}



#pragma mark - Encrypt And Decrypt

/**
 *
 *      TODO:
 *
 *      Now , Private to encryp -> Public key to decrypt
 *
 *      Also should ,  Public key to encrypt -> Private key to decrypt
 *
 *
 */


-(NSData*) rsaPublicKeyEncryptData:(NSData*)data
{
    return [self rsaPublicKeyEncryptData: data key:[self getPublicKey]];
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
-(NSData*) rsaPublicKeyEncryptData:(NSData*)data key:(SecKeyRef)key
{
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize = cipherBufferSize - 11;       // 分段加密, 加密数据长度 <= 模长-11, 明文长度(bytes) <= 密钥长度(bytes)-11
    size_t blockCount = (size_t)ceil([data length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    for (int i=0; i<blockCount; i++) {
        NSUInteger bufferSize = MIN(blockSize,[data length] - i * blockSize);
        NSData *buffer = [data subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes], [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }else{
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer){
        free(cipherBuffer);
    }
    return encryptedData;
}


-(NSData*) rsaPrivateKeyDecryptData:(NSData*)data
{
    return [self rsaPrivateKeyDecryptData:data key:[self getPrivateKey]];
}

-(NSData*) rsaPrivateKeyDecryptData:(NSData*)data key:(SecKeyRef)key
{
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
    
    if (status != noErr) {
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    return decryptedData;
}








#pragma mark - Class Methods

static RSACryptor* sharedInstance = nil;

+(RSACryptor*) sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

+(void) setSharedInstance: (RSACryptor*)instance
{
    sharedInstance = instance;
}


@end
