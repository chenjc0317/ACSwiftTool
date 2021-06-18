//
//  UIButton+SwiftTool.swift
//  SwiftTool
//
//  Created by Quinn on 2020/10/20.
//

import UIKit
extension UIButton {
    
    public var image : UIImage? {
        set {
            self.setImage(newValue, for: .normal)
        }
        get {
            return self.image(for: .normal)!
        }
    }
    
    public var backgroundImage : UIImage? {
        set {
            self.setBackgroundImage(newValue, for: .normal)
        }
        get {
            return self.backgroundImage(for: .normal)!
        }
    }
    
    public var title : String? {
        set {
            self.setTitle(newValue, for: .normal)
        }
        get {
            return self.title(for: .normal) ?? ""
        }
    }
    
    public var titleColor : UIColor? {
        set {
            self.setTitleColor(newValue, for: .normal)
        }
        get {
            return self.titleColor(for: .normal)!
        }
    }
    
    public var titleFont : UIFont? {
        set {
            self.titleLabel?.font = newValue
        }
        
        get {
            return self.titleLabel!.font
        }
    }
    
    // MARK:- 三、UIButton 图片 与 title 位置关系
    /// 图片 和 title 的布局样式
    enum ImageTitleLayout {
        case imgTop
        case imgBottom
        case imgLeft
        case imgRight
    }

    // MARK: 3.1、设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
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
extension UIButton{
    public convenience init(title: String?, titleColor: UIColor?, titleFont: UIFont?, backgroundColor: UIColor = UIColor.clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            self.cornerRadius = cornerRadius
        }
    }
    
    public convenience init(imageName: String) {
        self.init()
        self.image = UIImage(named: imageName)
    }
    
    public convenience init(normalImageName: String, selectImageName: String) {
        self.init()
        self.setImage(UIImage(named: normalImageName), for: .normal)
        self.setImage(UIImage(named: selectImageName), for: .selected)
        self.setImage(UIImage(named: selectImageName), for: .highlighted)
    }
}
