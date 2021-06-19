//
//  UICollectionView+SwiftTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
extension UICollectionView {

    
    /// 注册Cell
    ///
    /// - Parameter cell: cell类型
    public func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: "\(cell)")
    }
    
    
    /// 注册Cell(Nib)
    ///
    /// - Parameter cell: cell类型
    public func registerNib<T: UICollectionViewCell>(_ cell: T.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: "\(cell)", bundle: bundle), forCellWithReuseIdentifier: "\(cell)")
    }

    /// 注册Header或者Footer
    ///
    /// - Parameters:
    ///   - cls: Header或者Footer类型
    ///   - kind: header还是footer
    ///      * UICollectionView.elementKindSectionHeader
    ///      * UICollectionView.elementKindSectionFooter
    public func register<T: UICollectionReusableView>(_ cls: T.Type, kind: String) {
        register(cls, forSupplementaryViewOfKind: kind, withReuseIdentifier: "\(cls)")
    }
    
    /// 注册Header或者Footer(Nib)
    ///
    /// - Parameters:
    ///   - cls: Header或者Footer类型
    ///   - kind: header还是footer
    ///      * UICollectionView.elementKindSectionHeader
    ///      * UICollectionView.elementKindSectionFooter
    public func registerNib<T: UICollectionReusableView>(_ cls: T.Type, kind: String, bundle: Bundle? = nil) {
        register(UINib(nibName: "\(cls)", bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: "\(cls)")
    }
    
    
    /// 获取Cell
    ///
    /// - Parameters:
    ///   - cell: cell类型
    ///   - indexPath: indexPath
    /// - Returns: cell实例
    public func get<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(cell)", for: indexPath) as! T
    }
    /// 获取Header或者Footer
    ///
    /// - Parameters:
    ///   - cls: Header或者Footer类型
    ///   - kind: header还是footer
    ///      * UICollectionView.elementKindSectionHeader
    ///      * UICollectionView.elementKindSectionFooter
    ///   - indexPath: indexPath
    /// - Returns: Header或者Footer实例
    public func get<T: UICollectionReusableView>(_ cls: T.Type, kind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(cls)", for: indexPath) as! T
    }
}
