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
        //self.frame = UIScreen.main.bounds
        let searchFrame: CGRect = .zero
        let search = SearchView(frame: searchFrame)
        search.translatesAutoresizingMaskIntoConstraints = false
        self.upperView = search
        search.setConstr(constraints: self.constr.searchViewConstraints)
        self.addSubview(search)
        
        let images = ImagesView(frame: searchFrame)
        images.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView = images
        images.setConstr(constraints: self.constr.imagesViewConstraints)
        self.addSubview(images)
    }
    
    // MARK: -
    // MARK: Methods
    
    public func setConstr(constraints set: MainViewConstraints) {
        self.constr = set
        self.upperView?.setConstr(constraints: set.searchViewConstraints)
        self.bottomView?.setConstr(constraints: set.imagesViewConstraints)
        self.layoutSubviews()
    }
    
    public func paint(color: UIColor) {
        self.backgroundColor = color
    }
    
    override func layoutSubviews() {
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
