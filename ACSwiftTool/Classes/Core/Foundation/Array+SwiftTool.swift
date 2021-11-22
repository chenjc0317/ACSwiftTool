//
//  Array+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//


import Foundation
extension Array {
    /// 去除数组重复元素
    /// - Returns: 去除数组重复元素后的数组
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
extension Array where Element: Hashable{
    /// 数组去重-有序
    var deduplicates : [Element] {
        var keys:[Element:()] = [:]
        return filter{keys.updateValue((), forKey:$0) == nil}
    }
}
extension Sequence where Element: Equatable {
    func count(where isIncluded: (Element) -> Bool) -> Int {
        self.filter(isIncluded).count
    }
}
