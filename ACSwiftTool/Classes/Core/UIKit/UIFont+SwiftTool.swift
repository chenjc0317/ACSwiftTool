//
//  UIFont+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyFitsize

public extension UIFont {
    /// 苹方-简 常规体
    class func sc_regular(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Regular", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// 苹方-简 中粗体
    class func sc_semibold(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// 苹方-简 中黑体
    class func sc_medium(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Medium", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// 苹方-简 极细体
    class func sc_ultralight(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Ultralight", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// 苹方-简 纤细体
    class func sc_thin(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Thin", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// 苹方-简 黑体粗
    class func sc_bold(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Bold", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// 苹方-简
    class func sc_heavy(size:CGFloat) -> UIFont {
        return (UIFont(name: "PingFang-SC-Heavy", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// Arial-ItalicMT
    class func arial(size:CGFloat) -> UIFont {
        return (UIFont(name: "Arial-ItalicMT", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
    /// Arial-BoldItalicMT
    class func arial_blod(size:CGFloat) -> UIFont {
        return (UIFont(name: "Arial-BoldItalicMT", size: size) ?? UIFont.systemFont(ofSize: size))~
    }
}
