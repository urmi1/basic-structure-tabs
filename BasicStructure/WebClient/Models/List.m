//
//  Contacts.m
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "List.h"

@implementation List

-(id)initWithDictionary:(NSDictionary*)dict{
    if(self=[super init]){
        self.strListName = [dict valueForKey:@"ContactName"];
    }
    return self;
}

@end
