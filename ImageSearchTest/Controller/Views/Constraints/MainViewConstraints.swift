//
//  MainViewConstraints.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class MainViewConstraints {
    
    // MARK: -
    // MARK: Properties
    
    public var upperViewConstraints: PrepareConstraints
    public var lowerViewConstraints: PrepareConstraints
    
    // MARK: -
    // MARK: Init
    
    init() {
        let height: CGFloat = 100
        
        self.upperViewConstraints = PrepareConstraints(
            atributes: [.left, .right, .top, .height ],
            views:     [.main, .main,  .main,.nothing],
            offsets:   [0,     0,      0,     height ])
        
        self.lowerViewConstraints = PrepareConstraints(
            atributes: [.left, .right, .bottom, .top     ],
            views:     [.main, .main,  .main,   .neighbor],
            offsets:   [0,     0,      0,       height   ])
        
        
    }
}
