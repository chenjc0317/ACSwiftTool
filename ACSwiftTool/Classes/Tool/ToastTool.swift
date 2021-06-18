//
//  ToastTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public class ToastConfigure{
    static let shared = ToastConfigure()
    private init(){}
    /// 背景色
    public var backgroundColor:UIColor = .black
    /// 字体颜色
    public var textColor:UIColor = .white
    /// 标题字体大小 默认15pt
    public var titleFontSize: CGFloat = 15
    /// 信息字体大小 默认15pt
    public var messageFontSize: CGFloat = 15
    
    public var style:ToastStyle{
        var style = ToastStyle()
        style.backgroundColor = ToastConfigure.shared.backgroundColor
        style.titleColor = ToastConfigure.shared.textColor
        style.messageColor = ToastConfigure.shared.textColor
        style.titleFont = UIFont.sc_semibold(size: titleFontSize)
        style.messageFont = UIFont.sc_semibold(size: messageFontSize)
        style.titleAlignment = .center
        style.messageAlignment = .center
        return style
    }
    
}
public extension UIView{
    func toast(message:String,duration: TimeInterval  = 1, position: ToastPosition = .center){
        self.makeToast(message, duration: 1, position: position, title: nil, image: nil, style: ToastConfigure.shared.style, completion: nil)
    }
    func globalToast(message:String,duration: TimeInterval  = 1, position: ToastPosition = .center){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message,duration: duration,position: position)
        }
    }
}
public extension UIViewController{
    func toast(message:String,duration: TimeInterval  = 1, position: ToastPosition = .center){
        self.view.toast(message: message,duration: duration,position: position)
    }
    func globalToast(message:String,duration: TimeInterval  = 1, position: ToastPosition = .center){
        if let view = UIApplication.shared.keyWindow{
            view.toast(message: message,duration: duration,position: position)
        }
    }
}
