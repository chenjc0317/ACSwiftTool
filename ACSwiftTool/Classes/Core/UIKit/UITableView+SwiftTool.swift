//
//  UITableView+SwiftTool.swift
//  SpeedySwift
//
//  Created by Quinn on 2021/1/8.
//

import UIKit

public extension UITableView{
    /// 注册Header 或 Footer(Nib)
    ///
    /// - Parameter cell: cell类型
    public func registerNib<T: UITableViewHeaderFooterView>(_ view: T.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: "\(view)", bundle: bundle), forHeaderFooterViewReuseIdentifier: "\(view)")
    }
    
    /// 注册Header 或 Footer
    ///
    /// - Parameter cell: cell类型
    public func register<T: UITableViewHeaderFooterView>(_ view: T.Type) {
        register(view, forHeaderFooterViewReuseIdentifier: "\(view)")
    }
    
    /// 获取Header 或 Footer
    ///
    /// - Parameters:
    ///   - cell: cell类型
    ///   - indexPath: indexPath
    /// - Returns: cell实例
    public func get<T: UITableViewHeaderFooterView>(_ view: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(view)") as! T
    }
    
    /// 注册Cell(Nib)
    ///
    /// - Parameter cell: cell类型
    public func registerNib<T: UITableViewCell>(_ cell: T.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: "\(cell)", bundle: bundle), forCellReuseIdentifier: "\(cell)")
    }
    
    /// 注册Cell
    ///
    /// - Parameter cell: cell类型
    public func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: "\(cell)")
    }
    
    /// 获取Cell
    ///
    /// - Parameters:
    ///   - cell: cell类型
    ///   - indexPath: indexPath
    /// - Returns: cell实例
    public func get<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T
    }
    
    /// 根据View 获取对应Cell的indexpath
    func indexPath(by child:UIView)->IndexPath?{
        let point = child.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: point)
    }
    /// 根据 child view  获取对应Cell
    func cell(by child:UIView)->UITableViewCell?{
        let point = child.convert(CGPoint.zero, to: self)
        if let indexPath = self.indexPathForRow(at: point){
            return self.cellForRow(at: indexPath)
        }
        return nil
    }
}
