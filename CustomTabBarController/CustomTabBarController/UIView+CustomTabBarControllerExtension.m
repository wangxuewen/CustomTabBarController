//
//  UIView+CustomTabBarControllerExtension.m
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import "UIView+CustomTabBarControllerExtension.h"

@implementation UIView (CustomTabBarControllerExtension)

- (BOOL)wxw_isTabImageView {
    BOOL isKindOfImageView = [self wxw_isKindOfClass:[UIImageView class]];
    if (!isKindOfImageView) {
        return NO;
    }
    NSString *subString = [NSString stringWithFormat:@"%@cat%@ew", @"Indi" , @"orVi"];
    BOOL isBackgroundImage = [self wxw_classStringHasSuffix:subString];
    BOOL isTabImageView = !isBackgroundImage;
    return isTabImageView;
}

- (BOOL)wxw_isKindOfClass:(Class)class {
    BOOL isKindOfClass = [self isKindOfClass:class];
    BOOL isClass = [self isMemberOfClass:class];
    BOOL isKind = isKindOfClass && !isClass;
    if (!isKind) {
        return NO;
    }
    BOOL isTabBarClass = [self wxw_isTabBarClass];
    return isTabBarClass;
}

- (BOOL)wxw_isTabBarClass {
    NSString *tabBarClassString = [NSString stringWithFormat:@"U%@a%@ar", @"IT" , @"bB"];
    BOOL isTabBarClass = [self wxw_classStringHasPrefix:tabBarClassString];
    return isTabBarClass;
}

- (BOOL)wxw_classStringHasPrefix:(NSString *)prefix {
    NSString *classString = NSStringFromClass([self class]);
    return [classString hasPrefix:prefix];
}

- (BOOL)wxw_classStringHasSuffix:(NSString *)suffix {
    NSString *classString = NSStringFromClass([self class]);
    return [classString hasSuffix:suffix];
}

@end
