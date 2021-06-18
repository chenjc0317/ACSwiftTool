//
//  TapBuzzTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

extension SwiftTool{
    public static let buzz = TapBuzz.self
}
/// 振动反馈
public class TapBuzzTool{
    public static func light() {
        TapticEngine.impact.feedback(.light)
    }

    public static func medium() {
        TapticEngine.impact.feedback(.medium)
    }

    public static func heavy() {
        TapticEngine.impact.feedback(.heavy)
    }

    public static func selection() {
        TapticEngine.selection.feedback()
    }

    public static func success() {
        TapticEngine.notification.feedback(.success)
    }

    public static func warning() {
        TapticEngine.notification.feedback(.warning)
    }

    public static func error() {
        TapticEngine.notification.feedback(.error)
    }
}
