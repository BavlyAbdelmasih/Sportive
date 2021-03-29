//
//  Extensions.swift
//  Sportive
//
//  Created by iambavly on 3/27/21.
//

import Foundation
import UIKit
extension UIView{
    
    public var width :CGFloat{
        return self.frame.width
    }
    public var height :CGFloat{
        return self.frame.height
    }
    public var top :CGFloat{
        return self.frame.origin.y
    }
    public var bottom :CGFloat{
        return self.frame.height + self.frame.origin.y
    }
    public var left :CGFloat{
        return self.frame.origin.x
    }
    public var right :CGFloat{
        return self.frame.origin.x + self.frame.width
    }
    
}
