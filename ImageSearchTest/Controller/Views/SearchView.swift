//
//  SearchView.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    public var searchBar: UISearchBar? = nil
    private var constr: SearchViewConstraints = SearchViewConstraints()
  
    // MARK: -
    // MARK: Init and Deinit
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    private func commonInit(){
        self.backgroundColor = isTesting ? .blue : backgroundWhiteColor
        let bar = UISearchBar.init(frame: CGRect.zero)
        bar.barTintColor = isTesting ? .black : veryLightGrayColor
        bar.backgroundColor = bar.barTintColor
        self.searchBar = bar
        self.searchBar?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bar)
    }
    
    // MARK: -
    // MARK: Methods
    
    public func setConstr(){//constraints set: SearchViewConstraints) {
//        self.constr = set
        self.prepareConstraints()
    }
    
    private func prepareConstraints() {
        var makeConstraints: [NSLayoutConstraint] = []
        self.constr.searchBarConstraints.outConstraints()
            .forEach{ (attribute, typeOfView, value) in
                let item = (typeOfView == .main) ? self : nil
                if let view = self.searchBar {
                    makeConstraints.append(NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: 1.0, constant: value))
                }
        }
        self.removeConstraints(self.constraints)
        self.addConstraints(makeConstraints)
    }

}
