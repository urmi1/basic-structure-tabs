//
//  Login.m
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "Login.h"


static Login *staticInstance = nil;

@implementation Login

#define kUserID @"UserID"
#define kUserDetails @"UserDetails"

+ (Login *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Login *savedLoginDetails = [Helper getCustomObjectToUserDefaults:kUserDetails];
        if(!savedLoginDetails)
            staticInstance = [[Login alloc] init];
        else
            staticInstance = savedLoginDetails;        
    });
    return staticInstance;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:(int)self.intUserID forKey:kUserID];
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];
	if( self != nil ) {
		self.intUserID = [decoder decodeIntegerForKey:kUserID];
    }
	return self;
}

-(void)initWithDictionary:(NSDictionary*)dict{
    staticInstance.intUserID = [[dict valueForKey:@"UserID"] intValue];
}


@end
