//
//  DBHelper.h
//  BasicStructure
//
//  Created by _MyCompanyName_ on 14/02/11.
//  Copyright 2011 _MyCompanyName_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBHelper : NSObject 

@property (nonatomic,assign) sqlite3 *database;

//instance methods called once
+(DBHelper*)sharedInstance;

-(id)init;
-(void)checkAndCreateDatabase;
-(void)enableCascadeOption;

@end

