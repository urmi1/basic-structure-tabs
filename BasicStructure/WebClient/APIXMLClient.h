//
//  AppDelegate.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"
#import "APIKit.h"

@interface APIXMLClient : AFHTTPClient

+ (APIClient *)sharedClient;

//User registration related methods
- (void)getAccount:(NSDictionary *)params callBack:(APIClientCallback)callBack; //Login user
- (void)forgotPassword:(NSDictionary *)params callBack:(APIClientCallback)callBack; //ForgotPassword

@end
