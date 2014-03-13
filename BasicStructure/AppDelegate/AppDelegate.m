//
//  AppDelegate.m
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Tab1Controller.h"
#import "Tab2Controller.h"
#import "Tab3Controller.h"
#import "Tab4Controller.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Initialize Loading view
    _loadingView = [[LoadingView alloc] init];

    //Initialize Tab controller
    [self createTabBars];
    
    //Initialize Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)createTabBars{
    self.tabController = [[UITabBarController alloc] init];
    
    UINavigationController *t1NavController = [[UINavigationController alloc] initWithRootViewController:[[Tab1Controller alloc] initWithNibName:@"Tab1Controller" bundle:nil]];
    t1NavController.navigationBar.hidden = YES;
    t1NavController.tabBarItem.title = @"Tab1";
    
    UINavigationController *t2NavController = [[UINavigationController alloc] initWithRootViewController:[[Tab2Controller alloc] initWithNibName:@"Tab2Controller" bundle:nil]];
    t2NavController.navigationBar.hidden = YES;
    t2NavController.tabBarItem.title = @"Tab2";

    UINavigationController *t3NavController = [[UINavigationController alloc] initWithRootViewController:[[Tab3Controller alloc] initWithNibName:@"Tab3Controller" bundle:nil]];
    t3NavController.navigationBar.hidden = YES;
    t3NavController.tabBarItem.title = @"Tab3";

    UINavigationController *t4NavController = [[UINavigationController alloc] initWithRootViewController:[[Tab4Controller alloc] initWithNibName:@"Tab4Controller" bundle:nil]];
    t4NavController.navigationBar.hidden = YES;
    t4NavController.tabBarItem.title = @"Tab4";

    NSArray *arrController = [NSArray arrayWithObjects:t1NavController,t2NavController,t3NavController,t4NavController,nil];
    [self.tabController setViewControllers:arrController];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
