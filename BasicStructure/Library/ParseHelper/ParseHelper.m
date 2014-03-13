//
//  ParseHelper.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "ParseHelper.h"
#import "TouchXML.h"

@implementation ParseHelper

+(void)parseXML:(NSString *)xmlData withArray:(NSMutableArray*)array{
	NSError *theError = NULL;
	CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:xmlData options:0 error:&theError];
	CXMLElement *rootElement = [theXMLDocument rootElement];
	NSArray *arrResultData = [rootElement children];
	if (arrResultData.count > 0) {
		for(CXMLElement *firstChild in arrResultData) {
            NSString *nodeName = [firstChild name];
            if([nodeName isEqualToString:@"yourtag"]){
                NSArray *arrResultList = [firstChild children];
                    for(CXMLElement *lastChild in arrResultList) {
                        NSString *nodeName = [lastChild name];
                        NSString *nodeValue = [[lastChild stringValue]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        if([nodeName isEqualToString:@"yourtag"]){
                            NSLog(@"Assign nodevalue->%@",nodeValue);
                        }
                    }
                    [array addObject:nil];
                }
            }
        }
}


@end
