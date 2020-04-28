//
//  BankListViewController.swift
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
import UIKit
import KVNProgress

class BankListViewController: BaseViewController {
    
    @IBOutlet weak var banksTableView: UITableView!
    
    
    var arrBankList: [BankItem] = []
    private var bankListPresenter: BankListPresenter =  BankListPresenter()
    
    @IBAction func openMenuAction(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.prepareUI()
        
    }
    
    func prepareUI(){
        self.banksTableView.delegate = self
        self.banksTableView.dataSource = self
        self.banksTableView.separatorStyle = .none
        self.bankListPresenter.attachView(view: self)
        self.bankListPresenter.getBankList()
    }


}

extension BankListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.arrBankList.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankItemCell", for: indexPath) as! BankItemTableViewCell
        let row  = indexPath.row
        
        let age = self.arrBankList[row].age
        var ageText = ""
        
        if age > 1 {
            ageText = "\(age) años"
        }else if age == 1 || age == 0 {
            ageText = "\(age) año"
        }
        
        cell.setupCell()
        cell.bankName.text = self.arrBankList[row].bankName
        cell.descrip.text = self.arrBankList[row].description
        cell.ageLbl.text = ageText
        
        let urlString = self.arrBankList[row].url
        let url = NSURL(string: urlString)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = NSData(contentsOf: url! as URL)
            DispatchQueue.main.async {
                cell.logoBank.image = UIImage(data: data! as Data)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
    
}

extension BankListViewController : BankListProtocol {
    func startBankList() {
        KVNProgress.show()
    }
    
    func stopBankList() {
        
    }
    
    func successBankList(listBanks: [BankItem]?) {
        
        KVNProgress.showSuccess(completion: {
            self.arrBankList = listBanks!
            self.banksTableView.reloadData()
        })
    }
    
    func errorBankList(error: String) {
        
    }
    
    
}

