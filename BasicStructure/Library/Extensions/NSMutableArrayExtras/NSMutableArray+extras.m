//
//  NSString+extras.m
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+extras.h"

@implementation NSMutableArray (extras)


+(NSMutableArray*)getRandomNos:(NSUInteger)totRandomNos startRange:(NSUInteger)pIntStartFrom endRange:(NSUInteger)pIntEndTo
{
	NSMutableArray *arrRandomNos = [[NSMutableArray alloc] initWithCapacity:totRandomNos];
	
	NSUInteger intAddedItems = 0;
	while (intAddedItems!=totRandomNos) 
	{
		NSNumber *randomNumber = [Helper getRandomNumber:pIntStartFrom to:pIntEndTo];
		if(![arrRandomNos containsObject:randomNumber])
		{
			[arrRandomNos addObject:randomNumber];
			intAddedItems++;
		}
	}
	
	return arrRandomNos;
}


- (void)moveObjectFromIndex:(NSUInteger)origIndex toIndex:(NSUInteger)newIndex
{
    if (newIndex != origIndex) {
        id object = [self objectAtIndex:origIndex];
        [self removeObjectAtIndex:origIndex];
        if (newIndex >= [self count]) {
            [self addObject:object];
        } else {
            [self insertObject:object atIndex:newIndex];
        }
    }
}


-(void)shuffleArray
{
    for (int i = ([self count]-1); i >= 1; --i)
    {
        int j = arc4random() % i;
        id tempObject = [self objectAtIndex:j];
        [self replaceObjectAtIndex:j withObject: [self objectAtIndex:i]];
        [self replaceObjectAtIndex:i withObject:tempObject];
    }	
}


-(void)reverseArray
{
    int count = [self count];
    
    for (int i = 0; i < count / 2; ++i)
    {
        int j = count - i - 1;
        
        id tempObject = [self objectAtIndex:i];
        
        [self replaceObjectAtIndex:i withObject:[self objectAtIndex:j]];
        [self replaceObjectAtIndex:j withObject:tempObject];
    }
}

@end
