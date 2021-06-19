//
//  UserDefaultTool.swift
//  ACSwiftTool_Example
//
//  Created by 阿潮 on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

public enum DefaultWrapperKey {
    /// 普通类型
    case base(String)
    /// handyJSON类型
    case handyJSON(String)
}
/// UserDefaults Wrapper
///
/// 使用
/// =============
///     // HandyJSON Type
///     class Person: HandyJSON {
///         var name = ""
///         required init() {}
///     }
///     @SSDefault(key: .handyJSON("person"), defaultValue: Person())
///     var person
///
///     // Base Type
///     @SSDefault(key: .base("username"), defaultValue: "")
///     var username: String
@propertyWrapper
public struct SSDefault<T: HandyJSON> {
    let key: DefaultWrapperKey
    let defaultValue: T
    public init(key: DefaultWrapperKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            switch key {
            case .base(let keyString):
                return UserDefaults.standard.value(forKey: keyString) as? T ?? defaultValue
            case .handyJSON(let keyString):
                if let string = UserDefaults.standard.value(forKey: keyString) as? String, let object = T.deserialize(from: string) {
                    return object
                }
                return defaultValue
            }
        }
        set {
            switch key {
            case .base(let keyString):
                UserDefaults.standard.set(newValue, forKey: keyString)
            case .handyJSON(let keyString):
                UserDefaults.standard.set(newValue.toJSONString() ?? "", forKey: keyString)
            }
        }
    }
}
