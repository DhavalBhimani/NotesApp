//
//  AppDelegate.m
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#import "AppDelegate.h"
#import "MainNotesListVC.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [FIRDatabase database].persistenceEnabled = YES;
    [self SetInitialSetup];
    return YES;
}

#pragma mark - App State Changes Methods
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - Load Initial Screen
-(void)SetInitialSetup
{
    //Load Notes List Home Screen
    MainNotesListVC *homeVC = loadViewController(SB_Home, @"MainNotesListVC");
    _mainNavigationController = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    self.window.rootViewController = _mainNavigationController;
    [self.window makeKeyAndVisible];
}
@end
