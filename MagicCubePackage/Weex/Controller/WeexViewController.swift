//
//  WeexViewController.swift
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/9.
//  Copyright © 2018年 LuisX. All rights reserved.
//

import UIKit

class WeexViewController: BaseViewController {
    var instance: WXSDKInstance!;
    var weexView = UIView();
    var weexHeight: CGFloat!;
    var top: CGFloat!;
    var url: URL!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !self.navigationController!.navigationBar.isHidden {
            top = self.navigationController?.navigationBar.frame.maxX;
        } else {
            top = UIApplication.shared.statusBarFrame.maxY;
        }
        weexHeight = self.view.frame.size.height - top;
        render();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 反初始化，销毁工作
    deinit {
        if instance != nil {
            instance.destroy();
        }
    }
    
    func render() {
        if instance != nil {
            instance!.destroy();
        }
        
        instance = WXSDKInstance();
        instance.viewController = self;
        let width = self.view.frame.size.width;
        instance?.frame = CGRect(x: self.view.frame.size.width - width, y: top!, width: width, height: weexHeight!);
        
        weak var weakSelf = self;
        instance!.onCreate = {(view: UIView!) -> Void in
            weakSelf!.weexView.removeFromSuperview();
            weakSelf!.weexView = view;
            weakSelf!.view.addSubview(weakSelf!.weexView);
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf!.weexView);
        }

        instance!.onFailed = {(error: Error!) -> Void in
            print("faild at error: %@", error);
        }

        instance!.renderFinish = {(view: UIView!) -> Void in
            print("render finish");
        }
        
        instance!.updateFinish = {(view: UIView!) -> Void in
            print("update finish");
        }

        instance.render(with: url, options: ["bundleUrl" : "file://\(Bundle.main.bundlePath)/bundlejs/"], data: nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
