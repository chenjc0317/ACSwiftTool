//
//  UIDevice+SwiftTool.swift
//  ACSwiftTool_Example
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public extension UIDevice {
    // MARK: - Get String Value
    /// 获取设备磁盘总容量 单位GB
    var totalDiskSpaceInGB: String {
       return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    /// 获取设备磁盘空余容量 单位GB
    var freeDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    /// 获取设备磁盘已使用量 单位GB
    var usedDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    /// 获取设备磁盘总容量 单位MB
    var totalDiskSpaceInMB: String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    /// 获取设备磁盘空余容量 单位MB
    var freeDiskSpaceInMB: String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    /// 获取设备磁盘已使用量 单位MB
    var usedDiskSpaceInMB: String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
    // MARK: - Get Int64 Value
    /// 总磁盘空间（以字节为单位）
    var totalDiskSpaceInBytes: Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    /// 可用磁盘空间（以字节为单位）
    var freeDiskSpaceInBytes: Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }
    /// 已用磁盘空间（以字节为单位）
    var usedDiskSpaceInBytes: Int64 {
       return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
    
    /// 格式化
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
}
