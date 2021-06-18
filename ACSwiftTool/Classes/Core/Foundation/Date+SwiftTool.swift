//
//  Date+SwiftTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
/// 日期类型
public enum DateTypeString {
    /// yyyy年MM月dd日
    case YMD
    /// yyyy-MM-dd
    case ymd
    /// yyyy-MM-dd HH:mm:ss
    case YMDHMS
    /// yyyy-MM
    case YM
    /// yyyy
    case YYYY
}

public extension Date {
    /// 时间转换
    func toString(_ type: DateTypeString) -> String {
        let formatter = DateFormatter()
        switch type {
        case .YMD:
            formatter.dateFormat = "yyyy年MM月dd日"
        case .ymd:
            formatter.dateFormat = "yyyy-MM-dd"
        case .YMDHMS:
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .YM:
            formatter.dateFormat = "yyyy-MM"
        case .YYYY:
            formatter.dateFormat = "yyyy"
        }
        return formatter.string(from: self)
    }
    /// 当前时间间隔
    func currentTimeInterval() -> Int64 {
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return Int64(timeInterval)
    }
    /// 当前时间
    func currentTime() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyyMMddHHmmss"
        return timeFormatter.string(from: date)
    }
    /// 当前日期
    func currentDate(_ type: DateTypeString) -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        switch type {
        case .YMD:
            timeFormatter.dateFormat = "yyyy年MM月dd日"
        case .ymd:
            timeFormatter.dateFormat = "yyyy-MM-dd"
        case .YMDHMS:
            timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .YM:
            timeFormatter.dateFormat = "yyyy-MM"
        case .YYYY:
            timeFormatter.dateFormat = "yyyy"
        }
        return timeFormatter.string(from: date)
    }
    /// 格式化时间
    func formatterTimeToDate(stringTime: String) -> Date {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dfmatter.timeZone = TimeZone(abbreviation: "UTC") ?? TimeZone.current
        let date = dfmatter.date(from: stringTime) ?? Date()
        return date
    }
    /// 格式化时间
    func formatterTimeToDate(_ type: DateTypeString,stringTime: String) -> Date {
        let dfmatter = DateFormatter()
        switch type {
        case .YMD:
            dfmatter.dateFormat = "yyyy年MM月dd日"
        case .ymd:
            dfmatter.dateFormat = "yyyy-MM-dd"
        case .YMDHMS:
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .YM:
            dfmatter.dateFormat = "yyyy-MM"
        case .YYYY:
            dfmatter.dateFormat = "yyyy"
        }
        dfmatter.timeZone = TimeZone(abbreviation: "UTC") ?? TimeZone.current
        let date = dfmatter.date(from: stringTime) ?? Date()
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
