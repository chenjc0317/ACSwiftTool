//
//  UILabel+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
extension UILabel {
    /// 自定义初始化
    public convenience init(text : String?, textColor : UIColor?, textFont : UIFont?, textAlignment: NSTextAlignment = .left, numberLines: Int = 1) {
        self.init()
        self.text = text
        self.textColor = textColor ?? UIColor.black
        self.font = textFont ?? UIFont.systemFont(ofSize: 17.0)
        self.textAlignment = textAlignment
        self.numberOfLines = numberLines
        self.clipsToBounds = false
    }

    /// 预计高度
    /// - Parameters:
    ///   - maxWidth: 最大宽度
    ///   - maxLine: 最大列
    public func predictHeight(maxWidth: CGFloat,maxLine:Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: maxWidth,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.backgroundColor = backgroundColor
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = text
        label.textAlignment = textAlignment
        label.numberOfLines = maxLine
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// 预计宽度
    /// - Parameters:
    ///   - maxHeight: 最大高度
    ///   - maxLine: 最大列
    public func predictWidth(maxHeight: CGFloat,maxLine:Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: CGFloat.greatestFiniteMagnitude,
            height: maxHeight)
        )
        label.numberOfLines = 0
        label.backgroundColor = backgroundColor
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = text
        label.textAlignment = textAlignment
        label.numberOfLines = maxLine
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width
    }
    
    /// 改变行间距
    public func changeLineSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text?.count)!))
        self.attributedText = attributedString
        self.sizeToFit()
    }

    /// 改变字间距
    public func changeWordSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedString.Key.kern:space])
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text?.count)!))
        self.attributedText = attributedString
        self.sizeToFit()
    }

    /// 改变字间距和行间距  
    public func changeSpace(lineSpace:CGFloat, wordSpace:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedString.Key.kern:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text?.count)!))
        self.attributedText = attributedString
        self.sizeToFit()

    }
    
    /// UILabel根据文字的需要的高度
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// UILabel根据文字实际的行数
    public var lines: Int {
        return Int(requiredHeight / font.lineHeight)
    }
    
}

