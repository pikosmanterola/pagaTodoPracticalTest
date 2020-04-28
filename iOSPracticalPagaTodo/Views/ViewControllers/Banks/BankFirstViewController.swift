//
//  BankFirstViewController.swift
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
import UIKit
import KVNProgress

class BankFirstViewController: BaseViewController {
    
//MARK: - IBOutlets
    
    
//MARK: - IBActions
    
    @IBAction func openMenuAction(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    @IBAction func goToListAction(_ sender: Any) {
        debugPrint("entro a go to List")
        let storyBoardName = "BanksStoryboard"
        self.goToSection(storyBoard: storyBoardName)
    }
    
// MARK: - Properties.
    
    
// MARK: -   METHODS.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.prepareUI()
        
    }
    
    func prepareUI(){
        
    }


}

