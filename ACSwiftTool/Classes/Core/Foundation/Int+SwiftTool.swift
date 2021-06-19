//
//  Int+SwiftTool.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
public extension Int{
    var string:String{
        return "\(self)"
    }
    
    var random:Int{
        return Int(arc4random())%self
    }
}
