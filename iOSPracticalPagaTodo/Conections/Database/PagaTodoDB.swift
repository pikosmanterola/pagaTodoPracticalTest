//
//  PagaTodoDB.swift
//  iOSPracticalPagaTodo
//
//  MVP DESIGN PATTERN
//  
//  Development by PagaTodo
//  iOS Engineer Practical Test
//
//  Created by David Manterola on 26/04/20.
//  Copyright © 2020 PagaTodo. All rights reserved.
//

import Foundation

enum PagaTodoDB {
    
    public static func getlistBanks (completion: @escaping(_ result: Bool, _ banks: [BankItem]?) -> ()) {
        BankEntities().getList() { (result, banks) in
            completion(result, banks)
        }
    }
    
    public static func saveListBank(bankListArr: [BankItem], completion: @escaping(_ result: Bool) -> ()) {
        BankEntities().saveList(bankListArr: bankListArr) { (result) in
            completion(result)
        }
    }
    
}
