//
//  ImagesView.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class ImagesView: UIView {
    
    // MARK: -
    // MARK: Properties
    
    public var tableView: UITableView? = nil
    private var constr: ImagesViewConstraints = ImagesViewConstraints()
    
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
    
    private func commonInit() {
        let table = UITableView(frame: CGRect.zero)
        self.addSubview(table)
        self.tableView = table
        self.tableView?.translatesAutoresizingMaskIntoConstraints = false
        self.tableView?.backgroundColor = isTesting ? .red : backgroundWhiteColor
    }
    
    // MARK: -
    // MARK: Methods
    
    public func setConstr(){
        self.prepareConstraints()
    }
    
    private func prepareConstraints() {
        var makeConstraints: [NSLayoutConstraint] = []
        self.constr.tableConstraints.outConstraints()
            .forEach{ (attribute, typeOfView, value) in
                let item = (typeOfView == .main) ? self : nil
                if let view = self.tableView {
                    makeConstraints.append(NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: 1.0, constant: value))
                }
        }
        self.removeConstraints(self.constraints)
        self.addConstraints(makeConstraints)
    }
}
