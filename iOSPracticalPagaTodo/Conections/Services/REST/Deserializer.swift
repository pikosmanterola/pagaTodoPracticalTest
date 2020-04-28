//
//  Deserializer.swift
//  codi-ios-app
//
//  Created by Carlos Fuentes on 5/28/19.
//  Copyright © 2019 Ebreika. All rights reserved.
//

import Foundation
import UIKit

public protocol Deserializer {
    associatedtype ResponseType = Any
    
    var acceptHeader: String { get }
    
    init()
    
    func deserialize(_ data: Data) throws -> ResponseType
}

public class JSONDeserializer: Deserializer {
    public typealias ResponseType = JSON
    
    public let acceptHeader = "application/json"
    
    public required init() {
        
    }
    
    public func deserialize(_ data: Data) throws -> JSON {
        return try JSON(fromData: data)
    }
}

public class DecodableDeserializer<T: Decodable>: Deserializer {
    public typealias ResponseType = T
    
    public let acceptHeader = "application/json"
    
    public required init() {}
    
    public func deserialize(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

/// A `Deserializer` for `Void` (for use with servers that return no data).
public class VoidDeserializer: Deserializer {
    
    public typealias ResponseType = Void
    
    public let acceptHeader = "*/*"
    
    public required init() { }
    
    public func deserialize(_ data: Data) throws -> Void {
        // do nothing
        return Void()
    }
}

/// A `Deserializer` for `UIImage`
public class ImageDeserializer: Deserializer {
    
    public typealias ResponseType = UIImage
    
    public let acceptHeader = "image/*"
    
    public required init() { }
    
    public func deserialize(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NetworkingError.malformedResponse(data)
        }
        return image
    }
}

/// A `Deserializer` for `Data`
public class DataDeserializer: Deserializer {
    
    public typealias ResponseType = Data
    
    public let acceptHeader = "*/*"
    
    public required init() { }
    
    public func deserialize(_ data: Data) throws -> Data {
        return data
    }
}
