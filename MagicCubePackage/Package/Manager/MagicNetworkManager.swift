//
//  MagicNetworkManager.swift
//  MagicCubePackage
//
//  Created by LuisX on 2018/4/11.
//  Copyright © 2018年 LuisX. All rights reserved.
//

import UIKit
import Alamofire

class MagicNetworkManager: NSObject {
    
    static let shared = MagicNetworkManager()
    
    private override init(){
        
    }
    
}

extension MagicNetworkManager {
   
    //MARK: GET请求
    func GET(url: String, parameters: Dictionary<String, Any>?, success: @escaping (_ response: Dictionary<String, AnyObject>) -> (), failure : @escaping (_ error : Error) -> ()){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            switch (response.result){
            //成功
            case .success(let value):
                success(value as! [String : AnyObject])
                print("success:")
            //失败
            case .failure(let error):
                failure(error)
                print("error:\(error)")
            }
        }
        
    }
    
    //MARK: POST请求
    func POST(url:String, parameters:[String : Any]? = nil,success:@escaping (_ response : Dictionary<String, AnyObject>)->(), failure : @escaping (_ error : Error)->()){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            switch (response.result){
            //成功
            case .success(let value):
                success(value as! [String : AnyObject])
                print("success:")
            //失败
            case .failure(let error):
                failure(error)
                print("error:\(error)")
            }
        }
        
    }
    
    //MARK: 下载文件
    func download(url:String,success:@escaping (_ response : Any)->(), failure : @escaping (_ error : Error)->()){
        
        Alamofire.download(url).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    success(value)
                }
            case .failure(let error):
                print("download is fail")
                failure(error)
            }
        }
        
    }
    
    //MARK: 下载文件、进度
    func downloadProgress(url:String,success:@escaping (_ response : Any)->(), failure : @escaping (_ error : Error)->()){
        
        Alamofire.download(url).downloadProgress { (progress) in
            print("download progress = \(progress)")
            }.responseJSON { (response) in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        success(value)
                    }
                case .failure(let error):
                    failure(error)
                }
        }
        
    }
}

