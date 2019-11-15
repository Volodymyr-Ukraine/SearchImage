// taken from https://github.com/unsplash/unsplash-photopicker-ios/blob/master/UnsplashPhotoPicker/UnsplashPhotoPicker/Classes/Models/UnsplashPhoto.swift
//  UnsplashPhoto.swift
//  Submissions
//
//  Created by Olivier Collet on 2017-04-10.
//  Copyright © 2017 Unsplash. All rights reserved.
//
//import UIKit
import Foundation

/// A struct representing a photo from the Unsplash API.
public struct UnsplashPhoto: Decodable, Encodable {
    public let width: Int
    public let height: Int
    public let urls: URLKind
    public let links: LinkKind
}

public struct URLKind: Codable {
    public let raw: String
    public let full: String
    public let regular: String
    public let small: String
    public let thumb: String
}

public struct LinkKind: Codable {
    
    // MARK: -
    // MARK: Coding Keys
    
    private enum CodingKeys: String, Codable, CodingKey {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
    
    // MARK: -
    // MARK: Properties
    
    public let own: String
    public let html: String
    public let download: String
    public let downloadLocation: String
}
