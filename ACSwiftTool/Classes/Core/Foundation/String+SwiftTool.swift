//
//  String+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import UIKit
import CoreGraphics
import CommonCrypto
public extension String {
    /// base64 解码
    var base64Decoded: String? {
        let remainder = count % 4
        
        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }
        
        guard let data = Data(base64Encoded: self + padding,
                              options: .ignoreUnknownCharacters) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    /// base64 编码
    var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    /// md5
    var  md5:String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        
        return String(format: hash as String)
    }
    /// 是否包含emoji
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    var isContainEmoji: Bool {
        for scalar in unicodeScalars {
            return self.containEmoji(scalar)
        }
        return false
    }
    /// 转int
    var int: Int? {
        return Int(self)
    }
    /// 转Url
    var netUrl: URL? {
        return URL(string: self)
    }
    /// 转本地URL
    var localURL:URL?{
        return URL(fileURLWithPath: self, isDirectory: true)
    }
}
// MARK: - 转换
extension String {
    /// 转为数组
    func toArr() -> [String] {
        return self.map(String.init)
    }
    /// 字符串转字典
    func toDictionary() -> [String : Any] {
        
        var result = [String : Any]()
        guard !self.isEmpty else { return result }
        
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                                                       options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
        
    }
    /// 将原始的url编码为合法的url
    func urlEncoded() -> String? {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
                                                                .urlQueryAllowed)
        return encodeUrlString
    }
    
    /// 将编码后的url转换回原始的url
    func urlDecoded() -> String? {
        return self.removingPercentEncoding
    }
    
}
// MARK: - Methods
public extension String {
    /// 复制到剪贴板
    func copyToPasteboard() {
        UIPasteboard.general.string = self
    }
    
    /// 转日期
    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// 转 utf8Encoded
    func utf8Encoded() -> Data? {
        return self.data(using: String.Encoding.utf8)
    }
}

// MARK: - 计算个数，判空
public extension String {
    /// 移除表情
    func removeEmoji() -> String {
        var scalars = self.unicodeScalars
        scalars.removeAll(where: containEmoji(_:))
        return String(scalars)
    }
    
    /// 计算字符个数（英文 = 1，数字 = 1，汉语 = 2）
    /// - Returns: 返回字符的个数
    func countOfChars() -> Int {
        var count = 0
        guard self.count > 0 else { return 0}
        
        for i in 0...self.count - 1 {
            let c: unichar = (self as NSString).character(at: i)
            if (c >= 0x4E00) {
                count += 2
            }else {
                count += 1
            }
        }
        return count
    }
    /// String使用下标截取字符串
    /// string[index] 例如："abcdefg"[3] // c
    subscript (i:Int)->String{
        let startIndex = self.index(self.startIndex, offsetBy: i)
        let endIndex = self.index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    /// String使用下标截取字符串
    /// string[index..<index] 例如："abcdefg"[3..<4] // d
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    /// String使用下标截取字符串
    /// string[index,length] 例如："abcdefg"[3,2] // de
    subscript (index:Int , length:Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    /// 根据字符个数返回从指定位置向后截取的字符串（英文 = 1，数字 = 1，汉语 = 2）
    func subString(to index: Int) -> String {
        if self.count == 0 {
            return ""
        }
        
        var number = 0
        var strings: [String] = []
        for c in self {
            let subStr: String = "\(c)"
            let num = subStr.countOfChars()
            number += num
            if number <= index {
                strings.append(subStr)
            } else {
                break
            }
        }
        var resultStr: String = ""
        for str in strings {
            resultStr = resultStr + "\(str)"
        }
        return resultStr
    }
    /// 截取 从头到i位置
    func substring(to:Int) -> String{
        return self[0..<to]
    }
    /// 截取 从i到尾部
    func substring(from:Int) -> String{
        return self[from..<self.count]
    }
    /// 截取 从from到to位置
    func substring(from:Int,to:Int) -> String{
        return self[from..<to]
    }
}

// MARK: - Initializers
public extension String {
    /// 初始化 base64
    init?(base64: String) {
        guard let decodedData = Data(base64Encoded: base64) else { return nil }
        guard let str = String(data: decodedData, encoding: .utf8) else { return nil }
        self.init(str)
    }
}
// MARK: - 检测过滤
extension String {
    /// 获取宽度
    func getWidthForComment(font: UIFont, height: CGFloat) -> CGFloat {
        let font = font
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// 获取高度
    func getHeightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        let font = font
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    /// 是否包含表情
    /// - Parameter scalar: unicode 字符
    /// - Returns: 是表情返回true
    func containEmoji(_ scalar: Unicode.Scalar) -> Bool {
        switch Int(scalar.value) {
        case 0x1F600...0x1F64F: return true     // Emoticons
        case 0x1F300...0x1F5FF: return true  // Misc Symbols and Pictographs
        case 0x1F680...0x1F6FF: return true  // Transport and Map
        case 0x1F1E6...0x1F1FF: return true  // Regional country flags
        case 0x2600...0x26FF: return true    // Misc symbols
        case 0x2700...0x27BF: return true    // Dingbats
        case 0xE0020...0xE007F: return true  // Tags
        case 0xFE00...0xFE0F: return true    // Variation Selectors
        case 0x1F900...0x1F9FF: return true  // Supplemental Symbols and Pictographs
        case 127000...127600: return true    // Various asian characters
        case 65024...65039: return true      // Variation selector
        case 9100...9300: return true        // Misc items
        case 8400...8447: return true        //
        default: return false
        }
    }
    
    /// 是否是有效的电子邮件格式
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///        "john@doe.com".isValidEmail -> true
    ///
    var isValidEmail: Bool {
        // http://emailregex.com/
        let regex =
        "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// 检测手机号是否可用
    ///
    /// - Returns: 手机号是否可用
    func validateMobilNumber() -> Bool {
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
         * 联通：130,131,132,152,155,156,185,186,1709
         * 电信：133,1349,153,180,189,1700
         */
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    /// 谓词过滤
    /// - Parameter string: 被检测的字符串
    func isMatchsRegualExp(string: String) -> Bool {
        let predicate: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", string)
        return predicate.evaluate(with: self)
    }
    
    /// 判断是否为中文
    func isChinese() -> Bool{
        let match: String = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
}
