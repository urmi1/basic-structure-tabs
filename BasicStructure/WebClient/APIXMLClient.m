//
//  AppDelegate.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "APIXMLClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAPIBaseURLString = @"PATH to ASMX";
static NSString * const kAPIServiceBaseURLString = @"PATH TO PAGES";

#define kPrintRequestResponse YES

@implementation APIXMLClient

+ (instancetype)sharedClient {
    static APIXMLClient *_sharedClient = nil;
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

#pragma mark -  User registration/login related

- (void)getAccount:(NSDictionary *)params callBack:(APIClientCallback)callBack{
    [self genericGetAtPath:kUserLogin withParams:params :^(id XMLDoc) {
        NSError *error = [self checkResult:XMLDoc];
        if(error==nil){
        }
        callBack(error,nil);
    } failure:^(NSError *error) {
        callBack(error,nil);
    }];
}


- (void)forgotPassword:(NSDictionary *)params callBack:(APIClientCallback)callBack{
    [self genericGetAtPath:kForgotPassword withParams:params :^(id XMLDoc) {
        NSMutableDictionary *result = nil;
        NSError *error = [self checkResult:XMLDoc];
        if(error==nil){
            result = [NSMutableDictionary dictionaryWithObjectsAndKeys:[Soap getNodeValue:[Soap getNode:XMLDoc withName: @"result"] withName:@"message"],@"message", nil];
        }
        callBack(error,result);
    } failure:^(NSError *error) {
        callBack(error,nil);
    }];
}


- (void)uploadVideoComment:(NSDictionary *)params callBack:(APIClientCallback)callBack{
    NSMutableURLRequest *request = nil;
    NSArray *arrFiles =[params objectForKey:@"files"];
    AFHTTPClient *client= [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kAPIServiceBaseURLString]];
    request = [client multipartFormRequestWithMethod:@"POST" path:kkUploadMedia parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [arrFiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dictFile = (NSDictionary*)obj;
            NSData *imageData = dictFile[@"filedata"];
            NSString *mimeType = dictFile[@"mimetype"];
            if([mimeType isEqualToString:@"video/mp4"])
                [formData appendPartWithFileData:imageData name:@"CommentFile" fileName:@"video.mp4" mimeType:mimeType];
            else
                [formData appendPartWithFileData:imageData name:@"CommentThumbfile" fileName:@"video_thumb.png" mimeType:mimeType];
        }];
    }];
    NSLog(@"request ->%@",request);
    __block NSError *responseError = nil;
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *xmlConverterror= nil;
        NSString *xmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"respnose->%@",xmlString);
        [Helper showAlertView:@"success and response is" withMessage:xmlString delegate:nil];
        CXMLDocument* XMLDoc = [[CXMLDocument alloc] initWithXMLString:xmlString options: 0 error: &xmlConverterror];
        NSMutableDictionary *result = nil;
        if(xmlString && xmlConverterror==nil)
            responseError = [self checkResult:XMLDoc];
        if(!responseError){
        }
        callBack(responseError,result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Helper showAlertView:@"failed and response is" withMessage:error.localizedDescription delegate:nil];
        NSLog(@"Failed->%@",error);
        callBack(error,nil);
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark - Internal API

- (void)genericGetAtPath:(NSString *)path withParams:(NSDictionary *)params :(void(^)(id XMLDoc))onComplete failure:(void (^)(NSError *error))failure {
    [self postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error= nil;
        if (!responseObject) {
            onComplete(nil);
            return;
        }
        if(kPrintRequestResponse)
            NSLog(@"response headers->%@",[[operation response] allHeaderFields]);
        
        NSString *xmlString = [[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding];
        CXMLDocument* doc = [[CXMLDocument alloc] initWithXMLString:xmlString options: 0 error: &error];
        if(kPrintRequestResponse)
            NSLog(@"parameter --> %@ ,path->%@ and response->%@",params,path, doc);
        if(xmlString && error==nil){
            onComplete(doc);
        } else {
            failure(error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(kPrintRequestResponse)
            NSLog(@"request failed %@ (%li) error :%@", operation.request.URL, (long)operation.response.statusCode,error);
        failure(error);
    }];
}

#pragma mark - Error checking

-(NSError*)checkResult:(CXMLDocument*)XMLDoc{
    NSError *error = nil;
    NSInteger success = [[Soap getNodeValue:[Soap getNode:XMLDoc withName: @"result"] withName:@"success"] intValue];
    if(!success){
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:[Soap getNodeValue:[Soap getNode:XMLDoc withName: @"result"] withName:@"message"] forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:@"LacedFacts" code:200 userInfo:details];
    }
    return error;
}
@end
