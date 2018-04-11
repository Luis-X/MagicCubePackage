//
//  BaseViewController.swift
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/2.
//  Copyright © 2018年 LuisX. All rights reserved.
//

import UIKit

class BaseViewController: QMUICommonViewController {
    
    override func didInitialized() {
        super.didInitialized()
        // init 时做的事情请写在这里
    }

    override func initSubviews() {
        super.initSubviews()
        // 对 subviews 的初始化写在这里
        self.view.backgroundColor = UIColor.white;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 对 self.view 的操作写在这里
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func setNavigationItemsIsInEditMode(_ isInEditMode: Bool, animated: Bool) {
        super.setNavigationItemsIsInEditMode(isInEditMode, animated: animated)
        self.title = "";
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - QMUINavigationControllerDelegate
    override func shouldSetStatusBarStyleLight() -> Bool {
        return true;
    }
    
    override func navigationBarBackgroundImage() -> UIImage? {
        return UIImage.qmui_image(with: UIColor.qmui_color(withHexString: "#f93450"));
    }
    
    override func navigationBarShadowImage() -> UIImage? {
        return UIImage.qmui_image(with: UIColor(white: 1.0, alpha: 0.95), size: CGSize(width: 1, height: 1), cornerRadius: 0.0);
    }
    
    override func navigationBarTintColor() -> UIColor? {
        return UIColor(red: 26/255.0, green: 18/255.0, blue: 16/255.0, alpha: 1.00);
    }
    
    override func titleViewTintColor() -> UIColor? {
        return UIColor(red: 26/255.0, green: 18/255.0, blue: 16/255.0, alpha: 1.00);
    }
}
