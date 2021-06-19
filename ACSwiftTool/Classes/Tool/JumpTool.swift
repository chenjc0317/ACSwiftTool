//
//  JumpTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import UIKit

/// 跳转到具体的App，常用软件
public enum JumpAppType:String{
    /// 微信
    case wechat = "weixin://"
    /// QQ
    case qq = "mqq://"
    /// 电话
    case phone = "tel://"
}
/// 跳转状态 是否成功
public enum JumpStatus: String {
    case success    = "success"
    case fail        = "fail"
    public init?(string: String?) {
        guard let string = string else { return nil }
        self.init(rawValue: string)
    }
}
/// JMPStatus  描述信息
extension JumpStatus: CustomStringConvertible {
    public var description: String {
        return rawValue
    }
}

public extension SwiftTool{
    /// 跳转到系统页面
    /// - Parameter type： 类型
    /// - Parameter completionHandler：  block回调，bool表示是否成功
    static func jumpSystem(completionHandler completion: ((JumpStatus) -> Void)? = nil){
        let urlString = UIApplication.openSettingsURLString
        if let url: URL = URL(string: urlString) {
            SwiftTool.jump(url: url, completionHandler: completion)
        }else{
            completion?(.fail)
        }
    }
    
    /// 跳转到App
    /// - Parameter type： 类型
    /// - Parameter completionHandler：  block回调，bool表示是否成功
    static func jumpApp(type:JumpStatus, completionHandler completion: ((JumpStatus) -> Void)? = nil){
        if let url: URL = URL(string: type.rawValue) {
            SwiftTool.jump(url: url, completionHandler: completion)
        }else{
            completion?(.fail)
        }
    }
    
    /// 跳转
    static func jump(url:URL, completionHandler completion: ((JumpStatus) -> Void)? = nil){
        DispatchQueue.main.async {
            UIApplication.shared.open(url, options: [:]) { (bool) in
                if bool{
                    completion?(.success)
                }else{
                    completion?(.fail)
                }
            }
        }
    }
}
