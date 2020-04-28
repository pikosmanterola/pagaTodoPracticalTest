//
//  BankListPresenter.swift
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

// MARK: - Bank List Protocol
/**
    Este protocolo obliga a a la vista a pasar por los cuatro estados generales para que se implemente en la vista la funcionalidad correspondiente
    
    Las acciones a devolver son:
 
        - startBankList: Implementar acción inicial de la tarea ejemplo un loarder
        - stopBankList: Implementar accion al final de la tarea ejemplo detener loarder
        - successBankList: Implementar acción cuando el servicio regrese un success
        - errorBankList: Implementar acción cuando el servicio regrese un error
 */

protocol BankListProtocol: NSObjectProtocol {
    func startBankList()
    func stopBankList()
    func successBankList(listBanks: [BankItem]?)
    func errorBankList(error: String)
}

// MARK: - Login Presenter
/**
    Este presentador se tiene la tarea de obtener el resultado de la accion de obtener la lista de bancos que retorna el servicio y pasar a la vista por medio de los metodos del protocolo, la Lista puede obtenerse offline y online
 */

class BankListPresenter {
    weak private var view: BankListProtocol?
    
    let defaults = UserDefaults.standard
    
    func attachView(view: BankListProtocol) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func getBankList(){
        
        let isBankSaved = defaults.bool(forKey: "isListBankSaved")
        
        if isBankSaved {
            self.getLocalBankList()
        }else{
            self.getRemoteBankList()
        }
    }
    
    private func getLocalBankList() {
        guard self.view != nil else { return }
        self.view?.startBankList()
        
        PagaTodoDB.getlistBanks(){ (result, object) in
            if result {
                self.view?.successBankList(listBanks: object)
            }else{
                self.getRemoteBankList()
            }
        }
        
    }
    
    private func getRemoteBankList() {
        guard self.view != nil else { return }
        self.view?.startBankList()
        
        PagaTodoAPI.getBanksListOnAPI(){ (result, object) in
            debugPrint("result get bank list", object)
            if result {
                PagaTodoDB.saveListBank(bankListArr: object!){(result) in
                    if result {
                        self.defaults.set(true, forKey: "isListBankSaved")
                        self.view?.successBankList(listBanks: object)
                    }else{
                        self.view?.successBankList(listBanks: object)
                    }
                }
            }else{
                let error = "No pudo obtenerse la lista de bancos"
                self.view?.errorBankList(error: error)
            }
            
        }
        
    }
    
    
}
