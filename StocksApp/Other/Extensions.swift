//
//  Extensions.swift
//  StocksApp
//
//  Created by 정준영 on 2023/04/03.
//

import Foundation
import UIKit

// MARK: - Fraiming

extension UIView {
    var with: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + with
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    var bottom: CGFloat {
        top + height
    }
}

