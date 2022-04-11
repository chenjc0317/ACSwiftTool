//
//  UIButton+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.

import UIKit
extension UIButton {
    /// 图片
    public var image : UIImage? {
        set {
            self.setImage(newValue, for: .normal)
        }
        get {
            return self.image(for: .normal)!
        }
    }
    /// 背景图片
    public var backgroundImage : UIImage? {
        set {
            self.setBackgroundImage(newValue, for: .normal)
        }
        get {
            return self.backgroundImage(for: .normal)!
        }
    }
    /// 标题
    public var title : String? {
        set {
            self.setTitle(newValue, for: .normal)
        }
        get {
            return self.title(for: .normal) ?? ""
        }
    }
    /// 标题颜色
    public var titleColor : UIColor? {
        set {
            self.setTitleColor(newValue, for: .normal)
        }
        get {
            return self.titleColor(for: .normal)!
        }
    }
    /// 标题字体
    public var titleFont : UIFont? {
        set {
            self.titleLabel?.font = newValue
        }
        
        get {
            return self.titleLabel!.font
        }
    }
}
// MARK:- UIButton 图片 与 title 位置关系
extension UIButton {
    
    /// 图片 和 title 的布局样式
    enum ImageTitleLayout {
        case imgTop
        case imgBottom
        case imgLeft
        case imgRight
    }
    
    /// 设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
    /// - Parameters:
    ///   - layout: 布局
    ///   - spacing: 间距
    /// - Returns: 返回自身
    @discardableResult
    func setImageTitleLayout(_ layout: ImageTitleLayout, spacing: CGFloat = 0) -> Self {
        switch layout {
        case .imgLeft:
            alignHorizontal(spacing: spacing, imageFirst: true)
        case .imgRight:
            alignHorizontal(spacing: spacing, imageFirst: false)
        case .imgTop:
            alignVertical(spacing: spacing, imageTop: true)
        case .imgBottom:
            alignVertical(spacing: spacing, imageTop: false)
        }
        return self
    }
    
    /// 水平方向
    /// - Parameters:
    ///   - spacing: 间距
    ///   - imageFirst: 图片是否优先
    private func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -edgeOffset,
                                       bottom: 0,
                                       right: edgeOffset)
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: edgeOffset,
                                       bottom: 0,
                                       right: -edgeOffset)
        if !imageFirst {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }
    
    /// 垂直方向
    /// - Parameters:
    ///   - spacing: 间距
    ///   - imageTop: 图片是不是在顶部
    private func alignVertical(spacing: CGFloat, imageTop: Bool) {
        guard let imageSize = self.imageView?.image?.size,
              let text = self.titleLabel?.text,
              let font = self.titleLabel?.font
        else {
            return
        }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let imageVerticalOffset = (titleSize.height + spacing) / 2
        let titleVerticalOffset = (imageSize.height + spacing) / 2
        let imageHorizontalOffset = (titleSize.width) / 2
        let titleHorizontalOffset = (imageSize.width) / 2
        let sign: CGFloat = imageTop ? 1 : -1
        
        imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign,
                                       left: imageHorizontalOffset,
                                       bottom: imageVerticalOffset * sign,
                                       right: -imageHorizontalOffset)
        titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign,
                                       left: -titleHorizontalOffset,
                                       bottom: -titleVerticalOffset * sign,
                                       right: titleHorizontalOffset)
        // increase content height to avoid clipping
        let edgeOffset = (min(imageSize.height, titleSize.height) + spacing)/2
        contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
    }
    
}
