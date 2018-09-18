//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const WXWTabBarItemTitle;
FOUNDATION_EXTERN NSString *const WXWTabBarItemImage;
FOUNDATION_EXTERN NSString *const WXWTabBarItemSelectedImage;
FOUNDATION_EXTERN NSString *const WXWTabBarItemImageInsets;
FOUNDATION_EXTERN NSString *const WXWTabBarItemTitlePositionAdjustment;

@interface CustomTabBarController : UITabBarController

+ (instancetype)tabBarControllerWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                              tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes
                                        imageInsets:(UIEdgeInsets)imageInsets
                            titlePositionAdjustment:(UIOffset)titlePositionAdjustment;

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                  tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes
                            imageInsets:(UIEdgeInsets)imageInsets
                titlePositionAdjustment:(UIOffset)titlePositionAdjustment
                                context:(NSString *)context;

/*!
 * An array of the root view controllers displayed by the tab bar interface.
 */
@property (nonatomic, readwrite, copy) NSArray<UIViewController *> *tabBarViewControllers;

/*!
 * The Attributes of items which is displayed on the tab bar.
 */
@property (nonatomic, readwrite, copy) NSArray<NSDictionary *> *tabBarItemsAttributes;
/*!
 * To set both UIBarItem image view attributes in the tabBar,
 * default is UIEdgeInsetsZero.
 */
@property (nonatomic, readonly, assign) UIEdgeInsets imageInsets;
/*!
 * To set both UIBarItem label text attributes in the tabBar,
 * use the following to tweak the relative position of the label within the tab button (for handling visual centering corrections if needed because of custom text attributes)
 */
@property (nonatomic, readonly, assign) UIOffset titlePositionAdjustment;

/*
 * Whether to turn on animation
 */
@property (nonatomic, readwrite, assign) BOOL selectedAnimation;


@end
