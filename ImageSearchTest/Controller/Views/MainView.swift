//
//  MainView.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    
    // MARK: -
    // MARK: Properties
    
    public var upperView: SearchView? = nil
    public var bottomView: ImagesView? = nil
    private var constr: MainViewConstraints = MainViewConstraints()
    
    // MARK: -
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    private func commonInit() {
        let search = SearchView(frame: .zero)
        let images = ImagesView(frame: .zero)
        [search, images].forEach{ (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(element)
        }
        self.upperView = search
//        search.setConstr(constraints: self.constr.searchViewConstraints)
        
        self.bottomView = images
//        images.setConstr(constraints: self.constr.imagesViewConstraints)
    }
    
    // MARK: -
    // MARK: Methods
    
    public func setConstr(){//constraints set: MainViewConstraints) {
//        self.constr = set
        self.upperView?.setConstr()//constraints: set.searchViewConstraints)
        self.bottomView?.setConstr()//constraints: set.imagesViewConstraints)
        self.prepareConstraints()
    }
    
    public func paint(color: UIColor) {
        self.backgroundColor = color
    }
    
    public func prepareConstraints() {
        var makeConstraints: [NSLayoutConstraint] = []
        self.constr.upperViewConstraints.outConstraints()
        .forEach{ (attribute, typeOfView, value) in
            let item = (typeOfView == .main) ? self : nil
            if let view = self.upperView {
            makeConstraints.append(NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: 1.0, constant: value))
            }
        }
        self.constr.lowerViewConstraints.outConstraints()
            .forEach{ (attribute, typeOfView, value) in
                let item = (typeOfView == .main) ? self : (typeOfView == .neighbor) ? self.upperView : nil
                if let view = self.bottomView {
                    makeConstraints.append(NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: 1.0, constant: value))
                }
        }
        self.removeConstraints(self.constraints)
        self.addConstraints(makeConstraints)
    }
    
}
