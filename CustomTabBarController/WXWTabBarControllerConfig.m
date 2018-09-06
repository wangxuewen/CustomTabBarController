//
//  WXWTabBarControllerConfig.m
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import "WXWTabBarControllerConfig.h"
//十六进制颜色
#define ColorFromHexValue(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface WXWTabBarControllerConfig()

@property (strong, readwrite, nonatomic) CustomTabBarController *tabBarController;

@end

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation WXWTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return WXWTabBarController
 */
- (CustomTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `WXWTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        
        CustomTabBarController *tabBarController = [CustomTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                 ];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    
    NSArray *viewControllers = @[
                                 firstViewController,
                                 secondViewController,
                                 thirdViewController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 WXWTabBarItemTitle : @"加速",
                                                 WXWTabBarItemImage : @"加速未选中",  /* NSString and UIImage are supported*/
                                                 WXWTabBarItemSelectedImage : @"加速选中", /* NSString and UIImage are supported*/
                                                 WXWTabBarItemImageInsets: [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)],
                                                 WXWTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  WXWTabBarItemTitle : @"",
                                                  WXWTabBarItemImage : @"游戏列表未选中",
                                                  WXWTabBarItemSelectedImage : @"游戏列表选中",
                                                  WXWTabBarItemImageInsets: [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)],
                                                  WXWTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 WXWTabBarItemTitle : @"我的",
                                                 WXWTabBarItemImage : @"我的未选中",
                                                 WXWTabBarItemSelectedImage : @"我的选中",
                                                 WXWTabBarItemImageInsets: [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)],
                                                 WXWTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]
                                                 };

    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CustomTabBarController *)tabBarController {

    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = ColorFromHexValue(0x8e8e8e);

    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];

    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:ColorFromHexValue(0x262626)];

    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
