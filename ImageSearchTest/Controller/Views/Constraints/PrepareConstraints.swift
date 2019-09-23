//
//  Constraints.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

struct PrepareConstraints {
    
    // MARK: -
    // MARK: Properties
    
    public let atributes: [NSLayoutConstraint.Attribute]
    public let views: [ViewTypeEnum]
    public let offsets: [CGFloat]
    
    // MARK: -
    // MARK: Methods
    
    public func outConstraints() -> [(NSLayoutConstraint.Attribute, ViewTypeEnum, CGFloat)] {
        var outArray: [(NSLayoutConstraint.Attribute, ViewTypeEnum, CGFloat)] = []
        zip(self.atributes, zip(self.views, self.offsets)).forEach{(attribute, value) in
            outArray.append((attribute, value.0, value.1) )
        }
        return outArray
    }
}
