//
//  AppDelegate.m
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/25/24.
//

#import "AppDelegate.h"
#import "reseacrhapp-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
