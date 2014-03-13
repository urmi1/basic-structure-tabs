//
//  AppDelegate.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "APIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAPIBaseURLString = @"PathToWebservice";

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    return self;
}

#pragma mark - Login details

- (void)getAccount:(NSDictionary *)params callBack:(APIClientCallback)callBack{
    [self genericGetAtPath:kUserLogin withParams:params :^(id JSON) {
        Login *account = [Login sharedInstance];
        NSError *error = [self checkResult:JSON];
        if(!error){
            [account initWithDictionary:JSON[@"result"][@"data"]];
        }
        callBack(error,[NSDictionary dictionaryWithObjectsAndKeys: account,@"Account", nil]);
    } failure:^(NSError *error) {
        callBack(error,nil);
    }];
}

#pragma mark - List 

- (void)getList:(NSDictionary *)params callBack:(APIClientCallback)callBack{
    [self genericGetAtPath:kList withParams:params :^(id JSON) {
        NSError *error = [self checkResult:JSON];
        NSDictionary *result = nil;
        if(!error){
            NSArray *itemDictionaries = JSON[@"result"][@"data"];
            result = [NSDictionary dictionaryWithObjectsAndKeys:[List arrayOfModelsFromDictionaries:itemDictionaries],@"result", nil];
        }
        callBack(error,result);
    } failure:^(NSError *error) {
        callBack(error,nil);
    }];
}

#pragma mark - Internal API

- (void)genericGetAtPath:(NSString *)path withParams:(NSDictionary *)params :(void(^)(id JSON))onComplete failure:(void (^)(NSError *error))failure {
    [self postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error= nil;
        if (!responseObject) {
            onComplete(nil);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if (error) {
            NSLog(@"JSON parsing error in %@", NSStringFromSelector(_cmd));
            failure(error);
        } else {
            onComplete(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request failed %@ (%li)", operation.request.URL, (long)operation.response.statusCode);
        failure(error);
    }];
}

#pragma mark - Error checking

-(NSError*)checkResult:(id)JSON{
    NSError *error = nil;
    NSDictionary *result = JSON[@"result"];
    if([[result valueForKey:@"success"] intValue]==0){
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:[result valueForKey:@"message"] forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:@"YourDomain" code:200 userInfo:details];
    }
    return error;
}

@end
