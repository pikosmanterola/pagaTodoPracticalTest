//
//  GetBanksList.swift
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

class GetBanksList : BaseAPI {

    func execute(completion: @escaping(_ result: Bool, _ listBanks: [BankItem]?) -> ()) {
        
        guard let restCB = RestController.make(urlString: baseURL) else {
            print("Bad URL")
            return
        }
        
       
        var options = RestOptions()
        options.httpHeaders = self.addSimpleHeaders()
        
        restCB.get(withDeserializer: DataDeserializer(), at: bankListEndpoint, options: options) { (result, httpResponse) in
            debugPrint("responseHttp", httpResponse)
            do {
                let resultObj = try result.value()
                debugPrint("resultObj", resultObj)
                let arrResponse = try JSONSerialization.jsonObject(with: resultObj, options: .mutableContainers) as! NSArray
                
                var listBanks: [BankItem] = [BankItem]()
                
                for value in arrResponse {
                    
                    let item = value as! NSDictionary
                    
                    let itemBank = BankItem(
                        bankName:  item["bankName"] as! String,
                        description: item["description"] as! String,
                        age: item["age"] as! Int,
                        url: item["url"] as! String)
                    
                    listBanks.append(itemBank)
                }
                
                completion(true, listBanks)
                
            }catch{
                completion(false, nil)
            }
        }
        
        
    }
}
