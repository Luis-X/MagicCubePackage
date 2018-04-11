//
//  AppDelegate.swift
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/2.
//  Copyright © 2018年 LuisX. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {
    var latestVer = String();
    var window: UIWindow?

    // 七、当应用程序载入后执行
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window?.rootViewController =  self.loadRootTabBarController();
        self.window?.makeKeyAndVisible();
        self.startWeexSDK();
        self.checkAppUpdate(appId: "1130862662");
        return true;
    }

    // 一、当应用程序将要进入非活动状态执行(在此期间,应用程序不接收消息或事件)
    func applicationWillResignActive(_ application: UIApplication) {
      
    }
    
    // 二、当应用程序进入活动状态时执行
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    // 三、当应用程序被推送到后台时调用
    func applicationDidEnterBackground(_ application: UIApplication) {
      
    }

    // 四、当应用程序从后台将要重新回到前台时调用
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    // 五、当应用程序要退出时调用(保存数据,退出前清理工作)
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // 六、当应用程序终止前会执行这个方法(内存清理,防止程序被终止)
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
    }
    //MARK: - 打开URL回调
    
    // 十、苹果整合了八、九的功能到此方法(iOS9.0+)
    // 优先级: 高
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return self.openURLHandler(url: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String);
    }
    // 九、通过sourceApplication判断来自哪个App决定是否唤醒自己的App(iOS4.2 – 9.0)
    // 优先级: 中
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true;
    }
    // 八、打开URL时执行(iOS2.0 – 9.0)
    // 优先级: 低
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return true;
    }
    
    func openURLHandler(url: URL, sourceApplication: String?) -> Bool {
        
        print("来源App: \(sourceApplication)");
        print("url协议: \(url.scheme)");
        print("url参数: \(url.query)");
        
        return true;
    }
    
    // MARK: 初始化标签栏
    func loadRootTabBarController() -> UITabBarController {
        
        let array = [["page" : "HomeViewController", "title" : "首页", "img_normal" : "ui_normal@2x.png", "img_select" : "ui_selected@2x.png"],
                     ["page" : "ViewController", "title" : "普通", "img_normal" : "ui_normal@2x.png", "img_select" : "ui_selected@2x.png"]]
        
        let rootTabBarViewController = BaseTabBarViewController();
        rootTabBarViewController.viewControllers = self.loadNavigationController(array: array);
        return rootTabBarViewController;
        
    }
    
    // 创建视图控制器
    func loadNavigationController(array: Array< Dictionary <String, String> >) -> Array<UIViewController> {
        
        /*  Swift 中使用   NSClassFromString   注意点:
         *  使用时会遇到的错误代码: fatal error: unexpectedly found nil while unwrapping an Optinal value
         *  原因: swift在用字符串转为类型的时候,如果类型是自定义的,需要在类型字符串前面加上项目名称
         */
        
        var resultArray = Array<UIViewController>();
        var index = 0;
        for dic in array {
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
            let normalImage = dic["img_normal"]!;
            let selectedImage = dic["img_select"]!;
            let title = dic["title"]!;
            let page = dic["page"]!;
            let className = namespace + "." + page;
            let viewController:UIViewController;
            
            guard let Cls = NSClassFromString(className) as? UIViewController.Type  else {
                print("无法转换 UIViewController");
                continue;
            }
            
            viewController = Cls.init();
            let navigationController = QMUINavigationController.init(rootViewController: viewController);
            let tabBarItem = UITabBarItem.init(title: title, image: UIImage(named: normalImage), tag: index);
            tabBarItem.selectedImage = UIImage(named: selectedImage);
            navigationController.tabBarItem = tabBarItem;
            resultArray.append(navigationController);
            index += 1;
        }
        return resultArray
    }
    
    func startWeexSDK() {
        WeexManager.initWeexSDK();
    }
    
    func checkAppUpdate(appId: String) {
        weak var weakSelf = self;
        DispatchQueue.global(qos: .default).async {
            let infoDic = Bundle.main.infoDictionary;
            let currentVersion = infoDic!["CFBundleShortVersionString"] as! String;
            let urlString = "https://itunes.apple.com/lookup?id=" + appId;
            MagicNetworkManager.shared.POST(url: urlString, parameters: [:], success: { (response) in
                
                let array:Array<Any> = response["results"] as! Array;
                if array.count > 0 {
                    let releaseInfo:[String : Any] = array.first as! Dictionary;
                    weakSelf?.latestVer = releaseInfo["version"] as! String;
                    if Float(self.latestVer)! > Float(currentVersion)! {
                        if !UserDefaults.standard.bool(forKey: (weakSelf?.latestVer)!) {
                            UserDefaults.standard.set(false, forKey: (weakSelf?.latestVer)!);
                            let alertView = UIAlertView(title: "New Version", message: "update", delegate: self, cancelButtonTitle: "cancle", otherButtonTitles: "update");
                            alertView.show();
                        }
                    }
                }
                
            }, failure: { (error) in
                
            });
        }
        
    }
    
    // 弹框
    func showAlertView(alertView: UIAlertView, buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            UserDefaults.standard.set(true, forKey: self.latestVer);
            break;
        case 1:
            UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/cn/app/weex-playground/id1130862662?mt=8")!);
            break;
        default:
            break;
        }
        alertView.dismiss(withClickedButtonIndex: buttonIndex, animated: true);
    }
    
    // MARK: UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.showAlertView(alertView: alertView, buttonIndex: buttonIndex);
    }
}

