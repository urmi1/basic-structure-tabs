//
//  Contacts.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : BSObject

@property (nonatomic,strong) NSString *strListName;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
