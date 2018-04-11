//
//  WeexBaseViewController.m
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/11.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import "WeexBaseViewController.h"

@interface WeexBaseViewController ()

@end

@implementation WeexBaseViewController

- (void)didInitialized
{
    [super didInitialized];
    // init 时做的事情请写在这里
}

- (void)initSubviews
{
    [super initSubviews];
    // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 对 self.view 的操作写在这里
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated
{
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.title = @"<##>";
}


#pragma mark - 摇一摇
- (void)applicationSupportsShakeToEdit:(BOOL)open
{
    if (open) {
        //1、打开摇一摇功能
        [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
        //2、让需要摇动的控制器成为第一响应者
        [self becomeFirstResponder];
        //3、实现以下方法
    }
}

// 开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
// 取消摇动
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
// 摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

/**
 获取前一个视图控制器
 */
- (UIViewController *)baseBackViewController
{
    
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    if ( myIndex != 0 && myIndex != NSNotFound ) {
        return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    }
    return nil;
    
}

/**
 获取当前显示的控制器
 */
- (UIViewController *)getCurrentDisplayViewControllerFrom:(UIViewController *)vc
{
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getCurrentDisplayViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]){
        return [self getCurrentDisplayViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    }
    
    if (vc.presentedViewController) {
        return [self getCurrentDisplayViewControllerFrom:vc.presentedViewController];
    }
    
    return vc;
    
}

@end
