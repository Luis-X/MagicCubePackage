//
//  WeexViewController.h
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/11.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeexBaseViewController.h"
#import <SocketRocket/SRWebSocket.h>

@interface WeexViewController : WeexBaseViewController <SRWebSocketDelegate>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) BOOL showNavigationBar;

@end
