//
//  NSString+extras.h
//  YouShop
//
//  Created by _MyCompanyName_ on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (extras)

+ (UIColor *)colorWithHex:(NSUInteger) rgb;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger) length;
+ (NSString*)toHexString;

@end
