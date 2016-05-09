//
//  MTRSAEncrypt.h
//
//  Created by liukun on 14-3-21.
//  Copyright (c) 2014年 liukun. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "openssl/rsa.h"
#import "openssl/pem.h"



/**
 @abstract  padding type
 */
typedef NS_ENUM(NSInteger, MTRSA_PADDING_TYPE) {
    
    MTRSA_PADDING_TYPE_NONE       = RSA_NO_PADDING,
    MTRSA_PADDING_TYPE_PKCS1      = RSA_PKCS1_PADDING,
    MTRSA_PADDING_TYPE_SSLV23     = RSA_SSLV23_PADDING
};

@interface MTRSAEncrypt : NSObject
{
    RSA *_rsaPublic;
    RSA *_rsaPrivate;
    
    @public
    RSA *_rsa;
}


+ (MTRSAEncrypt *)sharedInstance;



#pragma mark - 导入密钥



/**
 @abstract  import public key, call before 'encryptWithPublicKey'
 @param     publicKey with base64 encoded
 @return    Success or not.
 */
- (BOOL)importRSAPublicKeyBase64:(NSString *)publicKey;

/**
 @abstract  import private key, call before 'decryptWithPrivateKey'
 @param privateKey with base64 encoded
 @return Success or not.
 */
- (BOOL)importRSAPrivateKeyBase64:(NSString *)privateKey;



#pragma mark - 导出密钥


/**
 @abstract  export public key, 'importRSAPublicKeyBase64' should call before this method
 @return    public key base64 encoded
 */
- (NSString *)base64EncodedPublicKey;


/**
 @abstract  export public key, 'importRSAPrivateKeyBase64' should call before this method
 @return    private key base64 encoded
 */
- (NSString *)base64EncodedPrivateKey;



#pragma mark - 加密解密


/**
 @abstract  encrypt text using RSA public key
 @param     padding type add the plain text
 @return    encrypted data
 */
- (NSData *)encryptWithPublicKeyUsingPadding:(MTRSA_PADDING_TYPE)padding
                                   plainData:(NSData *)plainData;

/**
 @abstract  encrypt text using RSA private key
 @param     padding type add the plain text
 @return    encrypted data
 */
- (NSData *)encryptWithPrivateKeyUsingPadding:(MTRSA_PADDING_TYPE)padding
                                    plainData:(NSData *)plainData;

/**
 @abstract  decrypt text using RSA private key
 @param     padding type add the plain text
 @return    encrypted data
 */
- (NSData *)decryptWithPrivateKeyUsingPadding:(MTRSA_PADDING_TYPE)padding
                                   cipherData:(NSData *)cipherData;

/**
 @abstract  decrypt text using RSA public key
 @param     padding type add the plain text
 @return    encrypted data
 */
- (NSData *)decryptWithPublicKeyUsingPadding:(MTRSA_PADDING_TYPE)padding
                                  cipherData:(NSData *)cipherData;
@end
