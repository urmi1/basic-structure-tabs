//
//  AppDelegate.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

//Main windows
@property (strong, nonatomic) UIWindow *window;

//Tab controller
@property (strong, nonatomic) UITabBarController *tabController;

//Loading
@property (strong, nonatomic) LoadingView *loadingView;

@end
