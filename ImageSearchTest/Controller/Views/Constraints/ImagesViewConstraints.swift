//
//  ImagesViewConstraints.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class ImagesViewConstraints {
    
    // MARK: -
    // MARK: Properties
    
    public var tableConstraints: PrepareConstraints
    
    // MARK: -
    // MARK: Init
    
    init() {
        let atributes: [NSLayoutConstraint.Attribute] =
            [.left, .right, .bottom, .top ]
        let views: [ViewTypeEnum] =
            [.main, .main,  .main, .main]
        let offsets: [CGFloat] =
            [10,    -10,     -10,      10]
        self.tableConstraints = PrepareConstraints(atributes: atributes, views: views, offsets: offsets)
    }
}
