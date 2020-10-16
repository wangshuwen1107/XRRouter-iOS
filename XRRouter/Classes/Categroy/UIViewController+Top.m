//
//  UIViewController+Top.m
//  Pods
//
//  Created by 王书文 on 2020/10/10.
//

#import <Foundation/Foundation.h>
#import "UIViewController+Top.h"

@implementation UIViewController (Top)

+ (UIViewController *)getTopVc{
    UIWindow *uiWindow = UIApplication.sharedApplication.keyWindow;
    if (!uiWindow) {
        return nil;
    }
    UIViewController *root = uiWindow.rootViewController;
    if (!root) {
        return nil;
    }
    return [self _getTopVc:root];
}

+ (UIViewController *) _getTopVc:(UIViewController *) root{
    if ([root isKindOfClass:UINavigationController.class]) {
        UINavigationController *navigationController =(UINavigationController *)root;
        UIViewController *top = navigationController.topViewController;
        if (top) {
            return [self _getTopVc:top];
        }
    }else if ([root isKindOfClass:UITabBarController.class]){
        UITabBarController *tabBarController =(UITabBarController *)root;
        UIViewController *top = tabBarController.selectedViewController;
        if (top) {
            return [self _getTopVc:top];
        }
    }else {
        UIViewController *top =  root.presentedViewController;
        if (top && ![top isKindOfClass: UIAlertController.class]) {
            return [self _getTopVc:top];
        }
    }
    return root;
}

@end
