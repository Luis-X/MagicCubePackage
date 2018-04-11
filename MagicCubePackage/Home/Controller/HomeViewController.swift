//
//  HomeViewController.swift
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/2.
//  Copyright © 2018年 LuisX. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom);
        button.backgroundColor = UIColor.gray;
        button.setTitle("weex", for: .normal);
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside);
        self.view.addSubview(button);
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction() {
        MagicRouterManager.showAnyViewControllerWithRouterURL(R_URL_NORMAL(page: "weex"), [:], self.navigationController);
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
