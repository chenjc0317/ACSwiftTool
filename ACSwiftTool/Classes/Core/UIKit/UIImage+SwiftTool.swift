//
//  UIImage+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public extension UIImage{
    /// 根据颜色生成图片
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    /// 质量压缩
    func compress(maxSize: Int) -> Data? {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: 1) else { return nil }
        if data.count < maxSize {
            return data
        }
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxSize){
                min = compression
            } else if data.count > maxSize {
                max = compression
            } else {
                break
            }
        }
        return data
    }
    
    /// 尺寸压缩
    func compress(maxLength: CGFloat) -> UIImage? {
        
        if maxLength <= 0 {
            return self
        }
        
        var imgMax:CGFloat = 0
        if self.size.width/self.size.height >= 1{
            imgMax = self.size.width
        }else{
            imgMax = self.size.height
        }
        if imgMax > maxLength {
            let ratio = maxLength/imgMax
            let newW  = self.size.width * ratio
            let newH  = self.size.height * ratio
            
            let newSize = CGSize(width: newW, height: newH)
            UIGraphicsBeginImageContext(newSize)
            self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            guard let _img = img else { return  nil}
            return _img
        }else{
            return self
        }
    }
    /// 切成圆形
    func circleImage() -> UIImage? {
        // NO代表透明
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 获得上下文
        let ctx = UIGraphicsGetCurrentContext()
        // 添加一个圆
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ctx?.addEllipse(in: rect)
        // 裁剪
        ctx?.clip()
        // 将图片画上去
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //返回一个将白色背景变透明的UIImage
    func imageByRemoveWhiteBg()  -> UIImage?{
        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        return transparentColor(colorMasking: colorMasking)
    }
    
    //返回一个将黑色背景变透明的UIImage
    func imageByRemoveBlackBg() -> UIImage? {
        let colorMasking: [CGFloat] = [0, 32, 0, 32, 0, 32]
        return transparentColor(colorMasking: colorMasking)
    }
    
    func transparentColor(colorMasking:[ CGFloat ]) ->  UIImage? {
        if  let  rawImageRef =  self .cgImage {
            UIGraphicsBeginImageContext ( self .size)
            if  let  maskedImageRef = rawImageRef.copy (maskingColorComponents: colorMasking) {
                let  context:  CGContext  =  UIGraphicsGetCurrentContext ()!
                context.translateBy(x: 0.0, y:  self .size.height)
                context.scaleBy(x: 1.0, y: -1.0)
                context.draw(maskedImageRef,in: CGRect (x:0, y:0, width: self .size.width,
                                                            height: self .size.height))
                let  result =  UIGraphicsGetImageFromCurrentImageContext ()
                UIGraphicsEndImageContext ()
                return  result
            }
        }
        return  nil
    }
}
