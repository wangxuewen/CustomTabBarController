//
//  UIControl+CustomTabBarControllerExtension.m
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import "UIControl+CustomTabBarControllerExtension.h"
#import "UIView+CustomTabBarControllerExtension.h"

@implementation UIControl (CustomTabBarControllerExtension)

- (UIImageView *)wxw_tabImageView {
    for (UIImageView *subview in self.subviews) {
        if ([subview wxw_isTabImageView]) {
            return (UIImageView *)subview;
        }
    }
    return nil;
}

@end
