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
    
   /* public enum URLKind: String, Codable, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    public enum LinkKind: String, Codable {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
        
    } */
    
  /*  public let id: String?
    public let created_at: String?
    public let updated_at: String? */
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
    private enum CodingKeys: String, Codable, CodingKey {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
    
    public let own: String
    public let html: String
    public let download: String
    public let downloadLocation: String
}
  /*  public let color: String?
    public let description: String?
    public let alt_description: String?
 
    
    public let likes: Int?
    public let liked_by_user: Bool?
    
    public let user: UnsplashUser?
    public let current_user_collections: [String]? // */
    
    /*
    public let exif: UnsplashPhotoExif?
    public let likesCount: Int
    public let downloadsCount: Int?
    public let viewsCount: Int?
    
     
     {
     "id": "eOLpJytrbsQ",
     "created_at": "2014-11-18T14:35:36-05:00",
     "width": 4000,
     "height": 3000,
     "color": "#A7A2A1",
     "likes": 286,
     "liked_by_user": false,
     "description": "A man drinking a coffee.",
     "user": {
        "id": "Ul0QVz12Goo",
        "username": "ugmonk",
        "name": "Jeff Sheldon",
        "first_name": "Jeff",
        "last_name": "Sheldon",
        "instagram_username": "instantgrammer",
     "twitter_username": "ugmonk",
     "portfolio_url": "http://ugmonk.com/",
     "profile_image": {
     "small": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=7cfe3b93750cb0c93e2f7caec08b5a41",
     "medium": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=5a9dc749c43ce5bd60870b129a40902f",
     "large": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=32085a077889586df88bfbe406692202"
     },
     "links": {
     "self": "https://api.unsplash.com/users/ugmonk",
     "html": "http://unsplash.com/@ugmonk",
     "photos": "https://api.unsplash.com/users/ugmonk/photos",
     "likes": "https://api.unsplash.com/users/ugmonk/likes"
     }
     },
     "current_user_collections": [],
     "urls": {
     "raw": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f",
     "full": "https://hd.unsplash.com/photo-1416339306562-f3d12fefd36f",
     "regular": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=92f3e02f63678acc8416d044e189f515",
     "small": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=263af33585f9d32af39d165b000845eb",
     "thumb": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8aae34cf35df31a592f0bef16e6342ef"
     },
     "links": {
     "self": "https://api.unsplash.com/photos/eOLpJytrbsQ",
     "html": "http://unsplash.com/photos/eOLpJytrbsQ",
     "download": "http://unsplash.com/photos/eOLpJytrbsQ/download"
     }
     },
     
     
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height
        case width
        case color
        case exif
        case user
        case urls
        case links
        case likesCount = "likes"
        case downloadsCount = "downloads"
        case viewsCount = "views"
    }
    
   public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        color = try container.decode(UIColor.self, forKey: .color)
        exif = try? container.decode(UnsplashPhotoExif.self, forKey: .exif)
        user = try container.decode(UnsplashUser.self, forKey: .user)
        urls = try container.decode([URLKind: URL].self, forKey: .urls)
        links = try container.decode([LinkKind: URL].self, forKey: .links)
        likesCount = try container.decode(Int.self, forKey: .likesCount)
        downloadsCount = try? container.decode(Int.self, forKey: .downloadsCount)
        viewsCount = try? container.decode(Int.self, forKey: .viewsCount)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
        try? container.encode(color?.hexString, forKey: .color)
        try? container.encode(exif, forKey: .exif)
        try container.encode(user, forKey: .user)
        try container.encode(urls.convert({ ($0.key.rawValue, $0.value.absoluteString) }), forKey: .urls)
        try container.encode(links.convert({ ($0.key.rawValue, $0.value.absoluteString) }), forKey: .links)
        try container.encode(likesCount, forKey: .likesCount)
        try? container.encode(downloadsCount, forKey: .downloadsCount)
        try? container.encode(viewsCount, forKey: .viewsCount)
    }
     
}    // */


/// A struct representing exif informations of a photo from the Unsplash API.
public struct UnsplashPhotoExif: Codable {
    
    public let aperture: String
    public let exposureTime: String
    public let focalLength: String
    public let iso: String
    public let make: String
    public let model: String
    
    private enum CodingKeys: String, CodingKey {
        case aperture
        case exposureTime = "exposure_time"
        case focalLength = "focal_length"
        case iso
        case make
        case model
    }
    
}

/// A struct representing a user's public profile from the Unsplash API.
public struct UnsplashUser: Codable {
    
    public enum ProfileImageSize: String, Codable {
        case small
        case medium
        case large
    }
    
    public enum LinkKind: String, Codable {
        case `self`
        case html
        case photos
        case likes
        case portfolio
    }
    
    public let id: String
    public let username: String
    public let name: String?
    public let first_name: String?
    public let last_name: String?
    public let instagram_username: String?
    public let twitter_username: String?
    public let portfolio_url: String?
    public let profile_image: [ProfileImageSize: String]
    public let links: [LinkKind: String]
    
    /*public let current_user_collections: [String]
    
    public let bio: String?
    public let location: String?
    public let portfolioURL: URL?
    public let totalCollections: Int
    public let totalLikes: Int
    public let totalPhotos: Int
 
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case name
        case profileImage = "profile_image"
        case bio
        case links
        case location
        case portfolioURL = "portfolio_url"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
    } // */
    
  /*  public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        username = try container.decode(String.self, forKey: .username)
        firstName = try? container.decode(String.self, forKey: .firstName)
        lastName = try? container.decode(String.self, forKey: .lastName)
        name = try? container.decode(String.self, forKey: .name)
        profileImage = try container.decode([ProfileImageSize: URL].self, forKey: .profileImage)
        bio = try? container.decode(String.self, forKey: .bio)
        links = try container.decode([LinkKind: URL].self, forKey: .links)
        location = try? container.decode(String.self, forKey: .location)
        portfolioURL = try? container.decode(URL.self, forKey: .portfolioURL)
        totalCollections = try container.decode(Int.self, forKey: .totalCollections)
        totalLikes = try container.decode(Int.self, forKey: .totalLikes)
        totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(username, forKey: .username)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(name, forKey: .name)
        try container.encode(profileImage.convert({ ($0.key.rawValue, $0.value.absoluteString) }), forKey: .profileImage)
        try container.encode(bio, forKey: .bio)
        try container.encode(links, forKey: .links)
        try container.encode(location, forKey: .location)
        try container.encode(portfolioURL, forKey: .portfolioURL)
        try container.encode(totalCollections, forKey: .totalCollections)
        try container.encode(totalLikes, forKey: .totalLikes)
        try container.encode(totalPhotos, forKey: .totalPhotos)
    }
    
}

// MARK: - Convenience
extension UnsplashUser {
    var displayName: String {
        if let name = name {
            return name
        }
        
        if let firstName = firstName {
            if let lastName = lastName {
                return "\(firstName) \(lastName)"
            }
            return firstName
        }
        
        return username
    }
    
    var profileURL: URL? {
        return URL(string: "https://unsplash.com/@\(username)")
    }
}

// MARK: - Equatable
extension UnsplashUser: Equatable {
    public static func == (lhs: UnsplashUser, rhs: UnsplashUser) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: [UnsplashUser.LinkKind: URL].Type, forKey key: Key) throws -> [UnsplashUser.LinkKind: URL] {
        let urlsDictionary = try self.decode([String: String].self, forKey: key)
        var result = [UnsplashUser.LinkKind: URL]()
        for (key, value) in urlsDictionary {
            if let kind = UnsplashUser.LinkKind(rawValue: key),
                let url = URL(string: value) {
                result[kind] = url
            }
        }
        return result
    }
 // */
}
