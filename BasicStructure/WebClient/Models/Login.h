//
//  Login.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : BSObject

@property (nonatomic,assign) NSInteger intUserID;

+ (Login *)sharedInstance;
- (void)initWithDictionary:(NSDictionary*)dict;

@end
