//
//  BankItemTableViewCell.swift
//  iOSPracticalPagaTodo
//
//  MVP DESIGN PATTERN
//  
//  Development by PagaTodo
//  iOS Engineer Practical Test
//
//  Created by David Manterola on 27/04/20.
//  Copyright © 2020 PagaTodo. All rights reserved.
//

import Foundation
import UIKit

class BankItemTableViewCell: UITableViewCell {
    
    //MARK: -   IBOUTLETS.
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var logoBank: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    
    //MARK: -   PROPERTIES.
    
    //MARK: -   IBACTIONS.
    
    //MARK: -   METHODS.
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell() {
        self.backView.layer.shadowColor = UIColor.lightGray.cgColor
        self.backView.layer.cornerRadius = 4.0
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowOffset = .zero
        self.backView.layer.shadowRadius = 3.0
    }
    
}
