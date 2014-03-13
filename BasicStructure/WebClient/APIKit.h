//
//  APIKit.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "BSObject.h"
#import "Login.h"
#import "List.h"
#import "Menu.h"

#define kList @"PathOfList"
#define kUserLogin @"UserLogin"
#define kForgotPassword @"ForgotPassword"
#define kkUploadMedia @"UploadMedia"

//Callback typedef
typedef void(^APIClientCallback)(NSError *error, NSDictionary *dictionary);
