//
//  BaseAPI.swift
//  iOSPracticalPagaTodo
//
//  MVP DESIGN PATTERN
//  
//  Development by PagaTodo
//  iOS Engineer Practical Test
//
//  Created by David Manterola on 25/04/20.
//  Copyright © 2020 PagaTodo. All rights reserved.
//

import Foundation

class BaseAPI {

   let defaults = UserDefaults.standard
// MARK: - Base server propeties
    
    let baseURL = Constants.isProductionMode ? "https://api.jsonbin.io/" : "https://api.jsonbin.io/"
    
// MARK: - Endpoints
    let bankListEndpoint = "b/5ea2fa3e98b3d5375233ca89"
    
// MARK: - methods
    
    func addSimpleHeaders() -> Dictionary<String, String> {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    func addTokenHeaders(token: String) -> Dictionary<String, String> {
        
        return ["Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": token]
    }
    
}
