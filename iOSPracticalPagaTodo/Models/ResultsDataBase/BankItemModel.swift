//
//  BankItemModel.swift
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

struct BankItem : Decodable {
    let bankName : String
    let description : String
    let age : Int
    let url : String
}
