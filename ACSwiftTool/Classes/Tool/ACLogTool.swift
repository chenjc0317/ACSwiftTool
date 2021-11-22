//
//  ACLogTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
public extension SwiftTool{
    static func log(_ items: Any...,
                    separator: String = " ",
                    terminator: String = "\n",
                    file: String = #file,
                    line: Int = #line,
                    method: String = #function)
    {
        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method)", terminator: separator)
        var i = 0
        let j = items.count
        for a in items {
            i += 1
            print(" ",a, terminator:i == j ? terminator: separator)
        }
        #endif
    }
}
