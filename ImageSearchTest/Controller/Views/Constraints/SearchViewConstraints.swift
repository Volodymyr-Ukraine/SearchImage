//
//  SearchViewConstraints.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class SearchViewConstraints {
    
    // MARK: -
    // MARK: Properties
    
    public var searchBarConstraints: PrepareConstraints
    
    // MARK: -
    // MARK: Init
    
    init() {
        let atributes: [NSLayoutConstraint.Attribute] =
            [.left, .right, .bottom, .height ]
        let views: [ViewTypeEnum] =
            [.main, .main,  .main, .nothing]
        let offsets: [CGFloat] =
            [10,    -10,     -15,      50]
        self.searchBarConstraints = PrepareConstraints(atributes: atributes, views: views, offsets: offsets)
    }
}
