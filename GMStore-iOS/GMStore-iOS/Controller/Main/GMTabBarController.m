//
//  GMTabBarController.m
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/28.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import "GMTabBarController.h"
#import "GMNavigationController.h"
#import "GMTabBar.h"

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

@interface GMTabBarController ()<UITabBarControllerDelegate>

@end

@implementation GMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    GMTabBar *tabBar = [[GMTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    //KVC把系统换成自定义
    [self setValue:tabBar forKey:@"tabBar"];
    
    [self addDcChildViewContorller];
}

- (void)addDcChildViewContorller{
    NSArray *childArray = @[
                            @{MallClassKey  : @"GMHandPickViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"tabr_02_up",
                              MallSelImgKey : @"tabr_02_down"},
                            
                            @{MallClassKey  : @"DCMediaListViewController",
                              MallTitleKey  : @"美媒榜",
                              MallImgKey    : @"tabr_03_up",
                              MallSelImgKey : @"tabr_03_down"},
                            
                            @{MallClassKey  : @"DCBeautyShopViewController",
                              MallTitleKey  : @"美店",
                              MallImgKey    : @"tabr_04_up",
                              MallSelImgKey : @"tabr_04_down"},
                            @{MallClassKey  : @"DCMyCenterViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tabr_05_up",
                              MallSelImgKey : @"tabr_05_down"}
                            ];
    
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        GMNavigationController *nav = [[GMNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
    
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);//（当只有图片的时候）需要自动调整
        [self addChildViewController:nav];
    }];
}

#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if(viewController == [tabBarController.viewControllers objectAtIndex:3]){
//        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//            DCLoginMeViewController *dcLoginVc = [DCLoginMeViewController new];
//            [self presentViewController:dcLoginVc animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}

- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc] initWithCapacity:0];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}

#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
