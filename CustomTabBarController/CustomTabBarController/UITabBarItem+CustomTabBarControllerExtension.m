//
//  UITabBarItem+CustomTabBarControllerExtension.m
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import "UITabBarItem+CustomTabBarControllerExtension.h"

@implementation UITabBarItem (CustomTabBarControllerExtension)

- (UIControl *)wxw_tabButton {
    UIControl *control = [self valueForKey:@"view"];
    return control;
}

@end
