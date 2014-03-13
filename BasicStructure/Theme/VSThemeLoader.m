//
//  VSThemeLoader.m
//  Q Branch LLC
//
//  Created by Brent Simmons on 6/26/13.
//  Copyright (c) 2012 Q Branch LLC. All rights reserved.
//

#import "VSThemeLoader.h"

@interface VSThemeLoader ()

//@property (nonatomic, strong, readwrite) VSTheme *currentTheme;
//@property (nonatomic, strong, readwrite) NSArray *arrThemes;

@end


static VSThemeLoader *singletonManager = nil;

@implementation VSThemeLoader


+ (VSThemeLoader *)sharedInstance
{
    if (singletonManager == nil)
        singletonManager = [[super allocWithZone:NULL] init];
    
	return singletonManager;
}

- (id)init {
	
	self = [super init];
	if (self == nil)
		return nil;
	
	NSString *themesFilePath = [[NSBundle mainBundle] pathForResource:@"Themes" ofType:@"plist"];
	NSDictionary *themesDictionary = [NSDictionary dictionaryWithContentsOfFile:themesFilePath];
	
	NSMutableArray *themes = [NSMutableArray array];
	for (NSString *oneKey in themesDictionary) {
		
		VSTheme *theme = [[VSTheme alloc] initWithDictionary:themesDictionary[oneKey]];
		theme.name = oneKey;
		[themes addObject:theme];
	}

    for (VSTheme *oneTheme in themes) { /*All themes inherit from the default theme.*/
		if (oneTheme != _currentTheme)
			oneTheme.parentTheme = _currentTheme;
    }
    
	_arrThemes = themes;
	
	return self;
}

- (VSTheme *)themeNamed:(NSString *)themeName {

	for (VSTheme *oneTheme in _arrThemes) {
		if ([themeName isEqualToString:oneTheme.name])
			return oneTheme;
	}

	return nil;
}

#define kUserPreferredTheme @"UserPreferredTheme"

-(void)loadDefaultTheme{
    NSInteger intUserTheme =  [(NSNumber*)[Helper getFromNSUserDefaults:kUserPreferredTheme] integerValue];
    _currentTheme = [self themeNamed:[NSString stringWithFormat:@"Theme%d",intUserTheme]];
}

-(void)loadNextTheme{    
    if(_arrThemes.count==1)
        return;
    
    NSInteger currentThemeIndex = [[_currentTheme stringForKey:@"themeno"] integerValue];
    if(currentThemeIndex < _arrThemes.count-1)
        currentThemeIndex++;
    else
        currentThemeIndex =0;
    
    _currentTheme = [self themeNamed:[NSString stringWithFormat:@"Theme%d",currentThemeIndex]];
    
    [Helper addToNSUserDefaults:[NSNumber numberWithInt:currentThemeIndex] forKey:kUserPreferredTheme];
}

@end

