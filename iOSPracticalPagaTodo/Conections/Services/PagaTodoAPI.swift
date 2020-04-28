//
//  PagaTodoAPI.swift
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

enum PagaTodoAPI {

    public static func getBanksListOnAPI (completion: @escaping(_ result: Bool, _ object: [BankItem]?) -> ()) {
        GetBanksList().execute() { (result, object) in
            completion(result, object)
        }
    }
    
}

