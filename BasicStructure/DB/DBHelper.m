//
//  DBHelper.m
//  BasicStructure
//
//  Created by _MyCompanyName_ on 14/02/11.
//  Copyright 2011 _MyCompanyName_. All rights reserved.
//

#import <CoreLocation/CLLocation.h>
#import "DBHelper.h"

#define kDatabaseName @"DBName.sqlite"

//static sqlite3_stmt *selectStmt = nil;
//static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *updateStmt = nil;
//static sqlite3_stmt *deleteStmt = nil;

static DBHelper *singletonInstance = nil;

@implementation DBHelper

#pragma mark instance methods called once

+(DBHelper*)sharedInstance{
    if(singletonInstance == nil)
        singletonInstance = [[super allocWithZone:NULL] init];
    
    return singletonInstance;
}

-(id) init {
    if(self = [super init]){
        //Check and Create Database in Iphone if not exists
        [self checkAndCreateDatabase];
    }
	return self;
}

//Function For Check for Database whether Exists or not. If not copy it to document directory.
-(void)checkAndCreateDatabase {	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir =[documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:kDatabaseName];
	NSLog(@"%@", databasePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if(![fileManager fileExistsAtPath:databasePath])
	{
		NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseName];
        NSError *error;
		[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:&error];
        if(error)
            NSLog(@"Error->%@",[error localizedDescription]);
	}

	//Open DB Connection
	if(sqlite3_open([databasePath UTF8String], &_database) != SQLITE_OK)
		sqlite3_close(_database);
    else
        [self enableCascadeOption];
	return;
}

-(void)enableCascadeOption {
 	const char *updateSql;

	updateSql = nil;
	if(updateStmt == nil)
	{
		updateSql = "PRAGMA foreign_keys = ON";
		if(sqlite3_prepare_v2(_database, updateSql, -1, &updateStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(_database));
	}
	//Insert the values into DB
	if(SQLITE_DONE != sqlite3_step(updateStmt))
	{
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(_database));
	}

	//Reset the add statement.
	sqlite3_reset(updateStmt);
	updateStmt = nil;
}

/*

//Select sample
- (void)getAllCategories:(NSMutableArray*)arrCategories{
    [arrCategories removeAllObjects];
	selectStmt = nil;
	
	const char *sqlStatement = "select ID,Name,ImgName,AddedDate from TblCategory order by ID";
	
	if(sqlite3_prepare_v2(_database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(selectStmt) == SQLITE_ROW) {
			[arrCategories addObject:objCategory];
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(selectStmt);
	selectStmt = nil;
}

//Insert sample
- (BOOL)addModel:(ModelClass*)modelObject{
    BOOL sqlSuccess;
	const char *insertSql;
	
	insertSql = nil;
	if(insertStmt == nil) {
		insertSql = "INSERT INTO TableName (Column1,Column1,Column1) VALUES(?,?,?)";
		if(sqlite3_prepare_v2(_database, insertSql, -1, &insertStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(_database));
		
		sqlite3_bind_text(insertStmt,1, [@"" UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt,2, [@"" UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insertStmt,3, [@"" UTF8String], -1, SQLITE_TRANSIENT);
	}
	//Insert the values into DB
	if(SQLITE_DONE != sqlite3_step(insertStmt)) {
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(_database));
		sqlSuccess = NO;
	}
	else{
		sqlSuccess = YES;
    }
	
	//Reset the add statement.
	sqlite3_reset(insertStmt);
	insertStmt = nil;
	
	return sqlSuccess;
} 

// Delete Sample
- (BOOL)deleteModel:(ModelClass*)modelObject{
    BOOL sqlSuccess=NO;
    
    deleteStmt=nil;
	
	if(deleteStmt == nil){
		const char *deleteSql = " Delete From TblCategory where ID = ?";
		if(sqlite3_prepare_v2(_database, deleteSql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(_database));
	}
	
	sqlite3_bind_int(deleteStmt, 1,modelObject.ID);
	
	if(SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting data. '%s'", sqlite3_errmsg(_database));
	else
		sqlSuccess =YES;
	
	//Reset the delete statement.
	sqlite3_reset(deleteStmt);
	deleteStmt = nil;
    return sqlSuccess;
}

*/

@end
