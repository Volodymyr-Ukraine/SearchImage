//
//  RealmClass.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/22/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//
import Foundation
import RealmSwift

class RealmClass: Object {
    
    // MARK: -
    // MARK: Properties
    
    @objc dynamic var text: String = ""
    @objc dynamic var file: Data? = nil
    
    // MARK: -
    // MARK: Methods
    
    public func prepare(search request: String, rawImage raw: Data?) {
        self.text = request
        self.file = raw
    }
}
