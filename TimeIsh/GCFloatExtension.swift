//
//  GCFloatExtension.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/14/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
    
}
