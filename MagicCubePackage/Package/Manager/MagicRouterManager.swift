//
//  MagicRouterManager.swift
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/9.
//  Copyright © 2018年 LuisX. All rights reserved.
//

import UIKit
// 协议
let R_SCHEME = "magic://";
// 普通页面URL
func R_URL_NORMAL(page: String) -> String {
    return R_SCHEME + page;
}
// web页面URL
func R_URL_WEB(link: String) -> String {
    return R_SCHEME + "web?link=" + link;
}

class MagicRouterManager: NSObject {
    
    /*
     说明:
     根据URL获取相应参数(多参数)
     例如: myapp://post/edit/123?debug=true&foo=bar  处理/:object/:action/:primaryKey 则object为post,action为edit,primaryKey为123
     注意: 不可包含中文
     */
    class func showAnyViewControllerWithRouterURL(_ routerURL: String, _ data: Dictionary<String, Any>?, _ navigationController: UINavigationController!) {
        //UTF8编码
        var urlString = routerURL;
        urlString = routerURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!;
        JLRoutes.global().addRoute("/:page") { (parameters: Dictionary<String, Any>) -> Bool in
            self.allActionManagementWithNavigationController(navigationController, data, parameters: parameters);
            return true;
        }
        JLRoutes.routeURL(URL(string: urlString))
    }
    
    
    class func allActionManagementWithNavigationController(_ navigationController: UINavigationController!, _ data: Dictionary<String, Any>?, parameters: Dictionary<String, Any>)  {
        print("参数:\(parameters)");
        // 通用参数
        //        let JLRoutePattern = parameters["JLRoutePattern"];
        //        let JLRouteScheme = parameters["JLRouteScheme"];
        //        let JLRouteURL = parameters["JLRouteURL"];
        // 私有参数
        // 页面
        let page = parameters["page"] as! String;
        var viewController: UIViewController?;
        
        switch page {
        // ViewController
        case "test":
            viewController = ViewController();
            break;
        // Weex
        case "weex":
            viewController = WeexViewController();
            break;
        default:
            break;
        }
        
        // 判空
        if viewController != nil {
            viewController?.hidesBottomBarWhenPushed = true;
            navigationController.pushViewController(viewController!, animated: true);
        }
    }
    
}
