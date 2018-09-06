//
//  CustomTabBar.h
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBar : UITabBar

///中心大按钮往上的响应区域高度（比如大按钮超出tabbar20个高度，那么此值就是20）
@property(nonatomic,assign)CGFloat effectAreaY;

@end
