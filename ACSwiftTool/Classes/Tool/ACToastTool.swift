//
//  ACToastTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Toast_Swift
/// Tost配置项
public class ACToastConfigure {
    static let shared = ACToastConfigure()
    private init(){}
    /// 背景色
    public var backgroundColor: UIColor = .black
    /// 字体颜色
    public var textColor:UIColor = .white
    /// 标题字体大小 默认15pt
    public var titleFontSize: CGFloat = 15
    /// 信息字体大小 默认15pt
    public var messageFontSize: CGFloat = 15
    
    public var style: ToastStyle {
        var style = ToastStyle()
        style.backgroundColor = ACToastConfigure.shared.backgroundColor
        style.titleColor = ACToastConfigure.shared.textColor
        style.messageColor = ACToastConfigure.shared.textColor
        style.titleFont = UIFont.sc_semibold(size: titleFontSize)
        style.messageFont = UIFont.sc_semibold(size: messageFontSize)
        style.titleAlignment = .center
        style.messageAlignment = .center
        return style
    }
    
}
public extension UIView {
    /// 🍞提示
    /// 固定位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - position:位置
    func toast(message: String, duration: TimeInterval = 1.5, position: ToastPosition = .center) {
        self.hideAllToasts()
        self.makeToast(message, duration: duration, position: position, title: nil, image: nil, style: ACToastConfigure.shared.style, completion: nil)
    }
    /// 🍞提示
    /// 自定义位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - xPoint:X轴的位置
    ///     - yPoint:Y轴的位置
    func toastByPoint(message: String, duration: TimeInterval = 1.5, xPoint: CGFloat = ACSwiftTool.screenWidth / 2, yPoint: CGFloat = ACSwiftTool.screenHeight / 2) {
        self.hideAllToasts()
        self.makeToast(message, duration: duration, point: CGPoint(x: xPoint, y: yPoint), title: nil, image: nil, style: ACToastConfigure.shared.style, completion: nil)
    }
    /// 🍞提示
    /// 根视图显示，固定位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - position:位置
    func globalToast(message: String, duration: TimeInterval = 1.5, position: ToastPosition = .center) {
        if let view = UIApplication.shared.keyWindow {
            view.hideAllToasts()
            view.toast(message: message, duration: duration, position: position)
        }
    }
    /// 🍞提示
    /// 根视图显示，自定义位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - xPoint:X轴的位置
    ///     - yPoint:Y轴的位置
    func globalToastByPoint(message: String, duration: TimeInterval = 1.5, xPoint: CGFloat = ACSwiftTool.screenWidth / 2, yPoint: CGFloat = ACSwiftTool.screenHeight / 2) {
        if let view = UIApplication.shared.keyWindow {
            view.hideAllToasts()
            view.toastByPoint(message: message, duration: duration, xPoint: xPoint, yPoint: yPoint)
        }
    }
}

public extension UIViewController {
    /// 🍞提示
    /// 固定位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - position:位置
    func toast(message: String, duration: TimeInterval = 1.5, position: ToastPosition = .center) {
        self.view.hideAllToasts()
        self.view.makeToast(message, duration: duration, position: position, title: nil, image: nil, style: ACToastConfigure.shared.style, completion: nil)
    }
    /// 🍞提示
    /// 自定义位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - xPoint:X轴的位置
    ///     - yPoint:Y轴的位置
    func toastByPoint(message: String, duration: TimeInterval = 1.5, xPoint: CGFloat = ACSwiftTool.screenWidth / 2, yPoint: CGFloat = ACSwiftTool.screenHeight / 2) {
        self.view.hideAllToasts()
        self.view.makeToast(message, duration: duration, point: CGPoint(x: xPoint, y: yPoint), title: nil, image: nil, style: ACToastConfigure.shared.style, completion: nil)
    }
    /// 🍞提示
    /// 根视图显示，固定位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - position:位置
    func globalToast(message: String, duration: TimeInterval = 1.5, position: ToastPosition = .center) {
        if let view = UIApplication.shared.keyWindow {
            view.hideAllToasts()
            view.toast(message: message, duration: duration, position: position)
        }
    }
    /// 🍞提示
    /// 根视图显示，自定义位置
    /// - Parameters:
    ///     - message:提示信息
    ///     - duration:显示时间
    ///     - xPoint:X轴的位置
    ///     - yPoint:Y轴的位置
    func globalToastByPoint(message: String, duration: TimeInterval = 1.5, xPoint: CGFloat = ACSwiftTool.screenWidth / 2, yPoint: CGFloat = ACSwiftTool.screenHeight / 2) {
        if let view = UIApplication.shared.keyWindow {
            view.hideAllToasts()
            view.toastByPoint(message: message, duration: duration, xPoint: xPoint, yPoint: yPoint)
        }
    }
}
