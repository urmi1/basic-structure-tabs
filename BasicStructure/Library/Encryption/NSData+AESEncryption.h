//
//  NSData+AESEncryption.h
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 24/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AESEncryption)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength;

- (NSData *)DATAAES256EncryptWithKey:(NSString*)key withVector:(NSString*)vector;
- (NSData *)DATAAES256DecryptWithKey:(NSString *)key withVector:(NSString*)vector;

@end
