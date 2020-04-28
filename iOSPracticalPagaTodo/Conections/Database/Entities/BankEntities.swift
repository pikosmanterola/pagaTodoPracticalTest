//
//  BankEntities.swift
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
import CoreData
import UIKit

class BankEntities : ContextDataBase {
    
    func getList(completion: @escaping (_ result: Bool, _ banks: [BankItem]?) -> ()) {
        
        DispatchQueue.main.async {
            let contexto = self.conexion()
            let fetchRequest : NSFetchRequest<Banks> = Banks.fetchRequest()
            
            var result = [BankItem]()
            do {
                let resultados = try contexto.fetch(fetchRequest)
                print("Banks: \(resultados)")
                for res in resultados as [NSManagedObject] {
                    
                    let item = BankItem(
                        bankName: res.value(forKey: "bankName") as! String,
                        description: res.value(forKey: "descrip") as! String,
                        age: res.value(forKey: "age")  as! Int,
                        url: res.value(forKey: "url") as! String)
                   
                    result.append(item)
                }
                debugPrint("result Banks DB", result)
                completion(true, result)
                
            }catch{
                print("Error al mostrar", error.localizedDescription)
            }
        }
        
    }
    
    func saveList(bankListArr: [BankItem], completion: @escaping (_ result: Bool) -> ()) {
        DispatchQueue.main.async {
            let contexto = self.conexion()
            let entityBank = NSEntityDescription.entity(forEntityName: "Banks", in: contexto)
            
            for bankList in bankListArr {
                
                let newEntity = NSManagedObject(entity: entityBank!, insertInto: contexto)
                
                newEntity.setValue(Int16(bankList.age), forKey: "age")
                newEntity.setValue(bankList.bankName, forKey: "bankName")
                newEntity.setValue(bankList.description, forKey: "descrip")
                newEntity.setValue(bankList.url, forKey: "url")
                
            }
            
            do {
                try contexto.save()
                completion(true)
                print("guardo")
                
            } catch let error as NSError {
                completion(false)
                print("Error al guardar", error.localizedDescription)
            }
        }
    }
}
