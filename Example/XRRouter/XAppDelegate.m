//
//  XAppDelegate.m
//  XRRouter
//
//  Created by wnwn7375@outlook.com on 09/22/2020.
//  Copyright (c) 2020 wnwn7375@outlook.com. All rights reserved.
//

#import "XAppDelegate.h"
#import "XRRouter_Example-Swift.h"

@implementation XAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [self _initRouter];
    
    UIViewController *rootVC = [[MainViewController alloc] init];
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    return YES;
}


-(void) _initRouter {
    [XRRouter setup:@"dc"];
    [XRRouter.share errorHandler:^(NSString * url, NSString * errorMsg) {
        NSLog(@"XRRouter ErrorHandler url = %@ ",url);
        NSLog(@"XRRouter ErrorHandler errorMsg = %@ ",errorMsg);
    }];
    
    [XRRouter.share addInterceptor:^XRRouterIntent *(XRRouterIntent * intent) {
        NSString *urlStr =  intent.urlStr;
        if ([urlStr containsString:@"getBookName"]) {
            [intent param:@"name" :@"拦截器强行修改名称"];
        }
        return intent;
    }];
    
    [XRRouter.share addInterceptor:^XRRouterIntent *(XRRouterIntent * intent) {
        NSString *urlStr =  intent.urlStr;
        if ([urlStr containsString:@"getBookName"]) {
            [intent param:@"name" :@"拦截器强行修改名称2"];
        }
        return intent;
    }];
    
}

@end
