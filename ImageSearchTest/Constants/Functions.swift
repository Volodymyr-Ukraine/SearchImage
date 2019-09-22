//
//  Functions.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/22/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import Foundation

public func prepareForRequest(string input: String) -> String {
    return input.replacingOccurrences(of: " ", with: "-")
}
