//
//  UIViewController+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

// MARK: -  处理界面跳转
public extension UIViewController {
    /// 跳转指定控制器
    func popAnyViewController(toVC: UIViewController){
        let vc = UIViewController()
        var targetVC : UIViewController!
        for controller in navigationController!.viewControllers {
            if controller.isKind(of: vc.classForCoder) {
                targetVC = controller
            }
        }
        if targetVC != nil {
            navigationController?.popToViewController(targetVC, animated: true)
        }
    }
    /// 跳转根控制器
    func popToRootViewController(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    /// 返回到根界面的某个控制器
    func popToRootVCInIndex(index: Int){
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
        self.navigationController?.tabBarController?.selectedIndex = index
        self.navigationController?.popToRootViewController(animated: true)
    }
    /// 返回两级界面
    func backTwoViewController(){
        if (self.navigationController?.viewControllers.count)! >= 2 {
            guard let vc = self.navigationController?.viewControllers[1] else { return }
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    /// 通过UIStoryboard创建UIViewController
    class func storyboard<T: UIViewController>(storyboardName: String, classType: T.Type, identifier: String = T.named) -> T? {
        if identifier.count == 0 {
            return nil
        }
        let vc = UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? T
        return vc
    }
    
    /// 前进到下一页面
    func go(_ viewController: UIViewController, animated: Bool = true) {
        if let nav = self.navigationController {
            nav.pushViewController(viewController, animated: animated)
        } else {
            present(viewController, animated: animated, completion: nil)
        }
    }
    
    /// 返回到下一页面
    func back(isPopToRoot: Bool? = false, animated: Bool = true) {
        if let nav = self.navigationController {
            if nav.viewControllers.count == 1 && nav.viewControllers.first == self, nav.presentingViewController != nil {
                nav.dismiss(animated: true, completion: nil)
            } else {
                if isPopToRoot == true {
                    nav.popToRootViewController(animated: animated)
                }else {
                    nav.popViewController(animated: animated)
                }
            }
        } else {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
    /// 返回到指定的页面 special
    func back(svc: UIViewController.Type) -> Bool {
        var isSuccess = false
        if let nav = self.navigationController {
            for vc in nav.viewControllers {
                if vc.isKind(of: svc) {
                    nav.popToViewController(vc, animated: true)
                    isSuccess = true
                    break
                }
            }
        }
        return isSuccess
    }
    
    // MARK: - 跳转到指定的VC
    func jump(_ jvc: UIViewController.Type) {
        
        // 就在当前界面
        if self.isKind(of: jvc) {
            return
        }
        
        // 情况1、存在navigationController
        var jumpVC: UIViewController?
        var jumpNav: UINavigationController?
        if let nav = self.navigationController {
            for tempVC in nav.viewControllers {
                if tempVC.isKind(of: jvc) {
                    jumpVC = tempVC
                    jumpNav = nav
                    break
                }
            }
        }
        
        if let finnalVC = jumpVC, let finalNav = jumpNav {
            finalNav.popToViewController(finnalVC, animated: true)
            return
        }
        
        // 情况2、存在tabBarController
        if let tabBarC = self.tabBarController, let nav = tabBarC.navigationController {
            for tempVC in nav.viewControllers {
                if tempVC.isKind(of: jvc) {
                    jumpVC = tempVC
                    jumpNav = nav
                    break
                }
            }
        }
        
        if let finnalVC = jumpVC, let finalNav = jumpNav {
            finalNav.popToViewController(finnalVC, animated: true)
            return
        }
        
        // 情况3、模态跳转出的界面，这种情况比较复杂
        var presentingVC = self
        while presentingVC.presentingViewController != nil {
            presentingVC = presentingVC.presentingViewController!
        }
        presentingVC.dismiss(animated: true, completion: nil)
    }
    
    /// 从导航栈中移除指定类型的VC
    func navRemove(_ vc: UIViewController.Type) {
        if let nav = self.navigationController {
            let originVCs = nav.viewControllers
            var newVCs:[UIViewController] = []
            for tempVC in originVCs {
                if !tempVC.isKind(of: vc) {
                    newVCs.append(tempVC)
                }
            }
            nav.viewControllers = newVCs
        }
    }
    /// 从导航栈中移除指定类型的[VC]
    func navRemove(_ vcs: [UIViewController.Type]) {
        if let nav = self.navigationController {
            let originVCs = nav.viewControllers
            var newVCs:[UIViewController] = []
            for tempVC in originVCs {
                var isContain = false
                for classType in vcs {
                    if tempVC.isKind(of: classType) {
                        isContain = true
                        break
                    }
                }
                if isContain == false {
                    newVCs.append(tempVC)
                }
            }
            nav.viewControllers = newVCs
        }
    }
    
}

public extension UIViewController{
    /// 显示Sheet
    @discardableResult
    func showActionSheet(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let allButtons = buttonTitles ?? [String]()
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        let action = UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
        })
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    @discardableResult
    func showAlert(
        title: String?,
        message: String?,
        buttonTitles: [String]? = nil,
        highlightedButtonIndex: Int? = nil,
        completion: ((Int) -> Void)? = nil) -> UIAlertController {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            var allButtons = buttonTitles ?? [String]()
            if allButtons.count == 0 {
                allButtons.append("确定")
            }
            
            for index in 0..<allButtons.count {
                let buttonTitle = allButtons[index]
                let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                    completion?(index)
                })
                alertController.addAction(action)
                // Check which button to highlight
                if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                    alertController.preferredAction = action
                }
            }
            present(alertController, animated: true, completion: nil)
            return alertController
        }
}


