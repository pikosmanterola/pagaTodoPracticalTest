//
//  Result.swift
//  codi-ios-app
//
//  Created by Carlos Fuentes on 5/28/19.
//  Copyright © 2019 Ebreika. All rights reserved.
//

import Foundation

public enum Result<T> {
    
    /// Success case
    /// - Parameter T: Resulting data from operation
    case success(T)
    
    /// Error case
    /// - Parameter Error: Error from operation
    case failure(Error)
    
    /// Gets encapsulated value
    ///
    /// - returns: Parameter 'T' contains encapsulated value
    /// - throws: Error if operation was failure
    public func value() throws -> T {
        switch (self) {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
