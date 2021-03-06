//
//  ACSwiftTool.swift
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
/*
 到 2021 年的现在这个时间点，iPhone 的逻辑分辨率宽度进化到了
 320pt（非全面屏）、
 375pt（非全面屏）、
 414pt（非全面屏、全面屏）、
 390pt（全面屏）、
 428pt（全面屏）
 */
/// 别名
public typealias ACSwiftTool = SwiftTool

@objcMembers
public class SwiftTool: NSObject {
    // MARK: - 设备相关
    /// 信号量
    public static let lock = DispatchSemaphore(value: 1)
    /// app 显示名称
    public static var displayName: String {
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "xxx"
    }
    /// app 的bundleid
    public static var bundleID: String {
        return Bundle.main.bundleIdentifier ?? "xxx.xxx.xx"
    }
    /// build号
    public static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "1"
    }
    /// app版本号
    public static var versionS: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    /// 设备名称
    public static var deviceName: String {
        return UIDevice.current.localizedModel
    }
    /// 设备方向
    public static var deviceOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    /// 主窗口
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    /// 当前系统版本
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    /// 判断设备是不是iPhoneX
    public static var isX : Bool {
        var isX = false
        if #available(iOS 11.0, *) {
            let bottom : CGFloat = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
            isX = bottom > 0.0
        }
        return isX
    }
    // MARK: - 视图相关
    /// 视图
    public static let bounds = UIScreen.main.bounds
    /// 屏幕宽
    public static let screenWidth = UIScreen.main.bounds.size.width
    /// 屏幕高
    public static let screenHeight = UIScreen.main.bounds.size.height
    /// TableBar高度
    public static var tabBarHeight : CGFloat {
        return statusBarHeight == 44 ? 83 : 49
    }
    /// TableBar距底部区域高度
    public static var safeBottomHeight : CGFloat {
        var bottomH : CGFloat = 0.0
        if isX {
            bottomH = 34.0
        }
        return bottomH
    }
    /// 状态栏的高度
    public static var statusBarHeight : CGFloat {
        var height = UIApplication.shared.statusBarFrame.size.height
        height = height < 20 ? (safeBottomHeight > 0 ? 44 : 20) : height
        return height
    }
    /// 导航栏的高度
    public static var navBarHeight: CGFloat {
        return 44.0
    }
    /// 状态栏和导航栏的高度
    public static var statusWithNavBarHeight : CGFloat {
        let heigth = statusBarHeight + navBarHeight
        return heigth
    }
    /// 比例宽度
    public static func scaleW(_ width: CGFloat,fit:CGFloat = 375.0) -> CGFloat {
        return screenWidth / fit * width
    }
    /// 比例高度
    public static func scaleH(_ height: CGFloat,fit:CGFloat = 812.0) -> CGFloat {
        return screenWidth / fit * height
    }
    /// 比例
    public static func scale(_ value: CGFloat) -> CGFloat {
        return scaleW(value)
    }
    // MARK: - 控制器相关
    /// 根据控制器获取 顶层控制器
    public static func topVC(_ viewController: UIViewController?) -> UIViewController? {
        guard let currentVC = viewController else {
            return nil
        }
        if let nav = currentVC as? UINavigationController {
            // 控制器是nav
            return topVC(nav.visibleViewController)
        } else if let tabC = currentVC as? UITabBarController {
            // tabBar 的跟控制器
            return topVC(tabC.selectedViewController)
        } else if let presentVC = currentVC.presentedViewController {
            //modal出来的 控制器
            return topVC(presentVC)
        } else {
            // 返回顶控制器
            return currentVC
        }
    }
    
    /// 获取顶层控制器 根据window
    public static func topVC() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return topVC(vc)
    }
    
    ///  获取当前显示vc
    public static func currentVC() -> UIViewController? {
        var result: UIViewController? = nil
        // 获取默认的window
        var window = UIApplication.shared.keyWindow
        // app默认windowLevel是UIWindowLevelNormal，如果不是，找到它。
        if window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == .normal {
                    window = tmpWin
                    break
                }
            }
        }
        // 获取window的rootViewController
        result = window?.rootViewController
        while (result?.presentedViewController != nil) {
            result = result?.presentedViewController
        }
        if result is UITabBarController {
            result = (result as? UITabBarController)?.selectedViewController
        }
        if result is UINavigationController {
            result = (result as? UINavigationController)?.visibleViewController
        }
        return result
    }
    
    /// 全场toast
    public static func toast(message:String) {
        if let view = UIApplication.shared.keyWindow {
            view.toast(message: message)
        }
    }
    
    /// 当用户截屏时的监听
    public static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
                                                   object: nil,
                                                   queue: OperationQueue.main) { notification in
            action(notification)
        }
    }
    /// 主动崩溃
    public static func exitApp(){
        _ = Int("")!
    }
}
