//
//  AppDelegate.m
//  VideoChat
//
//  Created by Luke Jang on 8/26/16.
//  Copyright © 2020 StraaS.io. All rights reserved.
//

@import Rollbar;
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "StreamingFiltersViewController.h"
#import "STSStreamingViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
    selector: @selector(thermalStateChanged:)
    name: NSProcessInfoThermalStateDidChangeNotification
    object: nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
    selector: @selector(powerStateChanged:)
    name: NSProcessInfoPowerStateDidChangeNotification
    object: nil];

    RollbarConfiguration *config = [[RollbarConfiguration alloc] init];
    config.environment = @"development";

    [Rollbar initWithAccessToken:@"b8b7f5e6bd25482ba4db8e8700b33a33" configuration:config];
    [Rollbar critical:@"Rollbar started"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Managing Interface Geometry

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UIViewController * topViewController = [[splitViewController.viewControllers lastObject] topViewController];
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        topViewController = [(UINavigationController *)topViewController topViewController];
    }
    if ([topViewController isKindOfClass:[DetailViewController class]]) {
        DetailViewController * detailViewController = (DetailViewController *)topViewController;
        UIViewController * contentViewController = detailViewController.contentViewController;
        if ([contentViewController isKindOfClass:[STSStreamingViewController class]]) {
            return ((STSStreamingViewController *)contentViewController).supportedInterfaceOrientations;
        }
        if ([contentViewController isKindOfClass:[StreamingFiltersViewController class]]) {
            return ((StreamingFiltersViewController *)contentViewController).supportedInterfaceOrientations;
        }
    }
    return UIInterfaceOrientationMaskAll;
}

- (UIViewController *)topViewController {
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UIViewController * topViewController = [[splitViewController.viewControllers lastObject] topViewController];
    return topViewController;
}

#pragma mark - Split view

- (UISplitViewControllerColumn)splitViewController:(UISplitViewController *)svc topColumnForCollapsingToProposedTopColumn:(UISplitViewControllerColumn)proposedTopColumn  API_AVAILABLE(ios(14.0)){
    return UISplitViewControllerColumnPrimary;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

- (void)thermalStateChanged:(NSNotification *) notification {
    if (@available(iOS 11.0, *)) {
        NSProcessInfoThermalState state = [[NSProcessInfo processInfo] thermalState];
        if (state == NSProcessInfoThermalStateFair) {
            // Thermals are fair. Consider taking proactive measures to prevent higher thermals.
            [Rollbar debug:@"Key!!!!! thermalStateChanged state == NSProcessInfoThermalStateFair"];
        } else if (state == NSProcessInfoThermalStateSerious) {
            // Thermals are highly elevated. Help the system by taking corrective action.
            [Rollbar debug:@"Key!!!!! thermalStateChanged state == NSProcessInfoThermalStateSerious"];
        } else if (state == NSProcessInfoThermalStateCritical) {
            // Thermals are seriously elevated. Help the system by taking immediate corrective action.
            [Rollbar debug:@"Key!!!!! thermalStateChanged state == NSProcessInfoThermalStateCritical"];
        } else {
            // Thermals are okay. Go about your business.
        };
    } else {
        // Fallback on earlier versions
    }
}

- (void)powerStateChanged:(NSNotification *) notification {
    BOOL lowPowerModeEnabled = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
    if (lowPowerModeEnabled) {
        [Rollbar debug:@"Key!!!!! powerStateChanged lowPowerModeEnabled == YES"];
    } else {
        [Rollbar debug:@"Key!!!!! powerStateChanged lowPowerModeEnabled == NO"];
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [Rollbar debug:@"Key!!!!! - (void)applicationDidReceiveMemoryWarning:(UIApplication *)application"];
}

@end
