//
//  TapBuzzTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

extension SwiftTool{
    public static let buzz = ACTapBuzzTool.self
}
/// 振动反馈
public class ACTapBuzzTool{
    /// 轻度
    public static func light() {
        ACTapticEngine.impact.feedback(.light)
    }
    /// 中度
    public static func medium() {
        ACTapticEngine.impact.feedback(.medium)
    }
    /// 重度
    public static func heavy() {
        ACTapticEngine.impact.feedback(.heavy)
    }
    /// 选择
    public static func selection() {
        ACTapticEngine.selection.feedback()
    }
    /// 成功
    public static func success() {
        ACTapticEngine.notification.feedback(.success)
    }
    /// 警告
    public static func warning() {
        ACTapticEngine.notification.feedback(.warning)
    }
    /// 错误
    public static func error() {
        ACTapticEngine.notification.feedback(.error)
    }
}
