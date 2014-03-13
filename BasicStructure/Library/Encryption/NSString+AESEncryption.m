//
//  NSString+AESEncryption.m
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 24/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+AESEncryption.h"

unsigned char strToChar (char a, char b)
{
    char encoder[3] = {'\0','\0','\0'};
    encoder[0] = a;
    encoder[1] = b;
    return (char) strtol(encoder,NULL,16);
}

@implementation NSString (AESEncryption)

- (NSString *)AES256Encrypt:(NSString *)pStrEncKey withVector:(NSString *)pStrVector
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData DATAAES256EncryptWithKey:pStrEncKey withVector:pStrVector];
    NSString *encryptedString = [encryptedData base64Encoding];
    return encryptedString;
}

- (NSString *)AES256Decrypt:(NSString *)pStrEncKey withVector:(NSString *)pStrVector
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData DATAAES256DecryptWithKey:pStrEncKey withVector:pStrVector];
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}

@end
