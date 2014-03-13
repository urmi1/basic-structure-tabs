//
//  NSString+AESEncryption.h
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 24/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AESEncryption.h"

@interface NSString (AESEncryption)

- (NSString *)AES256Encrypt:(NSString *)pStrEncKey withVector:(NSString *)pStrVector;
- (NSString *)AES256Decrypt:(NSString *)pStrEncKey withVector:(NSString *)pStrVector;

@end
