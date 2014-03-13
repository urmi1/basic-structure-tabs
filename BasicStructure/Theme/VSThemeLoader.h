//
//  VSThemeLoader.m
//  Q Branch LLC
//
//  Created by Brent Simmons on 6/26/13.
//  Copyright (c) 2012 Q Branch LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSTheme.h"

@interface VSThemeLoader : NSObject

@property (nonatomic, strong) VSTheme *currentTheme;
@property (nonatomic, strong) NSArray *arrThemes;

+ (VSThemeLoader *)sharedInstance;
- (void)loadDefaultTheme;
- (void)loadNextTheme;
- (VSTheme *)themeNamed:(NSString *)themeName;

@end
