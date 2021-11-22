//
//  Date+SwiftTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
/// 日期类型
public enum DateStringType {
    /// 0000-00-d00 00:00:00
    case YMDHMS
    /// 0000-00-00
    case YMD
    /// 0000-00
    case YM
    /// 0000
    case YYYY
    /// 0000年00月00日
    case ymd
}

public extension Date {
    /// 时间转换
    func toString(_ type: DateStringType) -> String {
        let formatter = DateFormatter()
        switch type {
        case .YMDHMS:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .YMD:
            formatter.dateFormat = "yyyy-MM-dd"
        case .YM:
            formatter.dateFormat = "yyyy-MM"
        case .YYYY:
            formatter.dateFormat = "yyyy"
        case .ymd:
            formatter.dateFormat = "yyyy年MM月dd日"
        }
        return formatter.string(from: self)
    }

    /// 当前时间戳
    func currentTimeInterval() -> Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        return Int64(timeInterval)
    }

    /// 当前时间戳
    func currentTimeInterval() -> UInt32 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        return UInt32(timeInterval)
    }
    
    /// 当前时间
    func currentTime() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyyMMddHHmmss"
        return timeFormatter.string(from: self)
    }
    /// 格式化时间
    func formatterTimeToDate(_ type: DateStringType, stringTime: String) -> Date {
        let formatter = DateFormatter()
        switch type {
        case .YMDHMS:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .YMD:
            formatter.dateFormat = "yyyy-MM-dd"
        case .YM:
            formatter.dateFormat = "yyyy-MM"
        case .YYYY:
            formatter.dateFormat = "yyyy"
        case .ymd:
            formatter.dateFormat = "yyyy年MM月dd日"
        }
        formatter.timeZone = TimeZone(abbreviation: "UTC") ?? TimeZone.current
        let date = formatter.date(from: stringTime) ?? Date()
        return date
    }

    /// 时间戳转换字符串
    func timeStampToString(timeStamp: String) -> String {
        let timeInterval: TimeInterval = TimeInterval(timeStamp) ?? Date().timeIntervalSince1970
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: timeInterval)
        return dfmatter.string(from: date)
    }

}
