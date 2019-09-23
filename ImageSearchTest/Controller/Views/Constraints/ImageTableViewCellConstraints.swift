//
//  ImageTableViewCellConstraints.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit


class ImageTableViewCellConstraints {
    
    // MARK: -
    // MARK: Properties
    
    public var cellConstraints: PrepareConstraints
    public var textConstraints: PrepareConstraints
    public var imageConstraints: PrepareConstraints
    public var cellHeight: CGFloat
    
    // MARK: -
    // MARK: Init
    
    init() {
        self.cellHeight = 150
        
        self.cellConstraints = PrepareConstraints(
            atributes: [.left, .right, .bottom, .top ],
            views:     [.main, .main,  .main,   .main],
            offsets:   [10,    -10,     -10,      10 ])

        self.textConstraints = PrepareConstraints(
            atributes: [.left, .centerY ],
            views:     [.main, .main],
            offsets:   [10,      0 ])
        
        self.imageConstraints = PrepareConstraints(
            atributes: [.right, .centerY, .width,   .height],
            views:     [.main,  .main,    .nothing, .nothing],
            offsets:   [-10,    0,        100,      100])
    }
}
