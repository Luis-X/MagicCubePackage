//
//  WeexManager.m
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/11.
//  Copyright © 2018年 LuisX. All rights reserved.
//

#import "WeexManager.h"
#import <WeexSDK/WeexSDK.h>
#import <AVFoundation/AVFoundation.h>

#import "WXImgLoaderDefaultImpl.h"
#import "WXNavigationHandlerImpl.h"

#import "WXEventModule.h"
#import "WXExtModule.h"

@implementation WeexManager
+ (void)initWeexSDK
{
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    
    [WXSDKEngine initSDKEnvironment];
    
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerHandler:[WXEventModule new] withProtocol:@protocol(WXEventModuleProtocol)];
    [WXSDKEngine registerHandler:[WXNavigationHandlerImpl new] withProtocol:@protocol(WXNavigationProtocol)];
    
    [WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];
    [WXSDKEngine registerModule:@"titleBar" withClass:NSClassFromString(@"WXTitleBarModule")];
    [WXSDKEngine registerModule:@"ext" withClass:[WXExtModule class]];
    
#if !(TARGET_IPHONE_SIMULATOR)
    [self checkUpdate];
#endif
    
#ifdef DEBUG
    [WXDebugTool setDebug:YES];
    [WXLog setLogLevel:WXLogLevelLog];
#else
    [WXDebugTool setDebug:NO];
    [WXLog setLogLevel:WXLogLevelError];
#endif
}
@end
