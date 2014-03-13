//
//  NSString+extras.h
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (extras)

+(NSMutableArray*)getRandomNos:(NSUInteger)totRandomNos startRange:(NSUInteger)pIntStartFrom endRange:(NSUInteger)pIntEndTo;

- (void)moveObjectFromIndex:(NSUInteger)origIndex toIndex:(NSUInteger)newIndex;

-(void)shuffleArray;

-(void)reverseArray;

@end
