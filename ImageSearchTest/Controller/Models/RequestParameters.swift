//
//  RequestParameters.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/22/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import Foundation

struct RequestParameters {
    
    // MARK: -
    // MARK: Properties
    
    var urlComponents: URLComponents = URLComponents()
    
    // MARK: -
    // MARK: Init
    
    init() {
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "api.unsplash.com"
        self.urlComponents.path = "/search/photos"
        self.urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "a62b141714259e5c3c95d1ecb72a1c7bc162d3a8d03f48d29d3ee3e88526ba21"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "1")
        ]
    }
}
