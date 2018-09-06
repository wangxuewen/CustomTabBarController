//
//  CustomTabBarController.m
//  CustomTabBarController
//
//  Created by administrator on 2018/9/6.
//  Copyright © 2018年 xuewen.wang. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "UIControl+CustomTabBarControllerExtension.h"

NSString *const WXWTabBarItemTitle = @"WXWTabBarItemTitle";
NSString *const WXWTabBarItemImage = @"WXWTabBarItemImage";
NSString *const WXWTabBarItemSelectedImage = @"WXWTabBarItemSelectedImage";
NSString *const WXWTabBarItemImageInsets = @"WXWTabBarItemImageInsets";
NSString *const WXWTabBarItemTitlePositionAdjustment = @"WXWTabBarItemTitlePositionAdjustment";

@interface CustomTabBarController () <UITabBarControllerDelegate>

@property (assign, nonatomic) NSInteger indexFlag;
@property (copy, nonatomic) NSMutableArray *mItemArray;

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indexFlag = 0;
}

+ (instancetype)tabBarControllerWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                              tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes
                                        imageInsets:(UIEdgeInsets)imageInsets
                            titlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    return [[self alloc] initWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment context:nil];
}

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
                  tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes
                            imageInsets:(UIEdgeInsets)imageInsets
                titlePositionAdjustment:(UIOffset)titlePositionAdjustment
                                context:(NSString *)context {
    if (self = [super init]) {
        _imageInsets = imageInsets;
        _titlePositionAdjustment = titlePositionAdjustment;
        _tabBarItemsAttributes = tabBarItemsAttributes;
        _tabBarViewControllers = viewControllers;
        
        [self uiSetting];
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uiSetting {
    // 更换tabBar
    CustomTabBar *myTabBar = [[CustomTabBar alloc] init];
    myTabBar.effectAreaY = 35;
    [self setValue:myTabBar forKey:@"tabBar"];
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0;i < self.tabBarViewControllers.count; i++) {
        NSString *imageNormal = [NSString stringWithFormat:@"%@",_tabBarItemsAttributes[i][WXWTabBarItemImage]];
        NSString *imageSelected = [NSString stringWithFormat:@"%@",_tabBarItemsAttributes[i][WXWTabBarItemSelectedImage]];
        
        UIViewController *vc = self.tabBarViewControllers[i];
        [vc setTitle:_tabBarItemsAttributes[i][WXWTabBarItemTitle]];
        vc.tabBarItem.image = [[UIImage imageNamed:imageNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        NSValue *insetsValue = _tabBarItemsAttributes[i][WXWTabBarItemImageInsets];
        UIEdgeInsets insets = [insetsValue UIEdgeInsetsValue];
        [vc.tabBarItem setImageInsets:insets];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
        NSValue *offsetValue = _tabBarItemsAttributes[i][WXWTabBarItemTitlePositionAdjustment];
        UIOffset offset = [offsetValue UIOffsetValue];
        [vc.tabBarItem setTitlePositionAdjustment:offset];//修改文字偏移量
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.title = _tabBarItemsAttributes[i][WXWTabBarItemTitle];
        [mArr addObject:nav];
        
    }
    self.viewControllers = mArr;
    self.selectedIndex = 0;

    self.mItemArray = nil;
    for (UIView *btn in self.tabBar.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [self.mItemArray addObject:btn];
        }
    }
    
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        UIButton *btn = self.mItemArray[index];
        
        UIView *animationView = [btn wxw_tabImageView];
        
        if (index != 1) {
            [self addRotateAnimationOnView:animationView];
        } else {
            [self addScaleAnimationOnView:animationView  repeatCount:1];
        }
        [self.tabBar bringSubviewToFront:self.mItemArray[self.indexFlag]];
        
        self.indexFlag = index;
    }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

//旋转Y动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}


-(NSMutableArray *)mItemArray {
    if (!_mItemArray) {
        _mItemArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _mItemArray;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
