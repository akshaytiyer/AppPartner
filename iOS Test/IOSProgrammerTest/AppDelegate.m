//
//  AppDelegate.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"

@interface AppDelegate ()

//Create a property for Navigation Controller
@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    //Assign a new object for MainMenuViewController
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];

    //Set the rootViewController to be MainMenuViewController
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainMenuViewController];
    //[self.navController setNavigationBarHidden:YES];
    
    //Set properties for the navigation bar
    //Bar Color: #2C4556, 90% Opacity
    //Bar Buttom Items Colors: #FFFFFF
    //Font: Machinato Light, Size 20
    UINavigationBar *bar = [self.navController navigationBar];
    [bar setBarTintColor:[UIColor colorWithRed:0.173 green:0.271 blue:0.337 alpha:0.9]];
    [bar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [bar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Machinato-Light" size:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];

    //Set the text of the back bar button item to be blank
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:nil];
    self.navController.navigationBar.topItem.backBarButtonItem=backItem;
    
    //Set the initial view controller as the Navigation Controller
    self.window.rootViewController = self.navController;

    return YES;
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
