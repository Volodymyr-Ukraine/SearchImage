//
//  InputJSON.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import Foundation

public struct InputJSON: Decodable{
    
    // MARK: -
    // MARK: Coding Keys
    
    private enum CodingKeys: String, Codable, CodingKey {
        case results
        case total
        case totalPages = "total_pages"
    }
    
    // MARK: -
    // MARK: Properties
    
    public let results : [UnsplashPhoto]
    public let total: Int?
    public let totalPages: Int?
}
