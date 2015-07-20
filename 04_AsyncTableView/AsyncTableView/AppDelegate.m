//
//  AppDelegate.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "AppDelegate.h"
#import "VCTable+Factory.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation AppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    VCTable *rootViewController = [VCTable factoryInstance];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
