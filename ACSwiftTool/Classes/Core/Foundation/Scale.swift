//
//  UI+Scale.swift
//  SwiftTool
//
//  Created by Ac on 2021/6/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
public extension CGFloat{
    var scale:CGFloat{
        return SwiftTool.scale(self)
    }
}

public extension Int{
    var scale:CGFloat{
        return SwiftTool.scale(CGFloat(self))
    }
}
public extension Double{
    var scale:CGFloat{
        return SwiftTool.scale(CGFloat(self))
    }
}
