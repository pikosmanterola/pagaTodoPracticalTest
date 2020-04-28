//
//  MenuViewController.swift
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
import SideMenuSwift
import SafariServices

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}
 
class MenuViewController: BaseViewController, SFSafariViewControllerDelegate {
    var isDarkModeEnabled = false
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            // tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var selectionTableViewHeader: UILabel!
    @IBOutlet weak var subscriptionView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    private var themeColor = UIColor.white
    
    @IBAction func listBankAction(_ sender: Any) {
        let storyBoardName = "Main"
        self.goToSection(storyBoard: storyBoardName)
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuController.preferences.basic.direction = .left
        
        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        configureView()
        
        self.subscriptionView.layer.cornerRadius = 5.5
        self.subscriptionView.layer.borderColor = Constants.BORDER_BOX_COLOR
        self.subscriptionView.layer.borderWidth =  0.5
        
        self.footerView.layer.cornerRadius = 5.5
        self.footerView.layer.borderColor = Constants.BORDER_BOX_COLOR
        self.footerView.layer.borderWidth =  0.5
        
        sideMenuController?.delegate = self
    }
    
    private func configureView() {
        
        selectionMenuTrailingConstraint.constant = 0
        themeColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
        
        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        if showPlaceTableOnLeft {
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        }
         
        view.backgroundColor = themeColor
        tableView.backgroundColor = themeColor
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
}

extension MenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did hide.")
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionCell
        cell.layer.addBorder(edge: .left, color: Constants.BORDER_BOX_COLOR_UICOLOR, thickness: 0.5)
        cell.layer.addBorder(edge: .right, color: Constants.BORDER_BOX_COLOR_UICOLOR, thickness: 0.5)
        
        let row = indexPath.row
        if (row == 0) {
            cell.titleLabel?.text = "David Manterola website"
            cell.roundCorners([.topRight, .topLeft], radius: 5.5)
            cell.layer.addBorder(edge: .top, color: Constants.BORDER_BOX_COLOR_UICOLOR, thickness: 0.5)
            cell.iconCell?.image = UIImage(named: "about_icon")
        } else if row == 1 {
            cell.titleLabel?.text = "Linkedin"
            cell.iconCell?.image = UIImage(named: "linkedin_icon")
        }else if row == 2 {
            cell.titleLabel?.text = "Home"
            cell.iconCell?.image = UIImage(named: "home_icon")
        }
        cell.titleLabel?.textColor = isDarkModeEnabled ? .white : .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
                  
        sideMenuController?.hideMenu()
        
        if (row == 0) {
            guard let url = URL(string: "http://manterola.mx") else { return }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
            
        }else if (row == 1){
            guard let url = URL(string: "https://www.linkedin.com/in/david-ricardo-manterola-morales-a48a9052/") else { return }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        }else if (row == 2){
            let storyBoardName = "Main"
            self.goToSection(storyBoard: storyBoardName)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

class SelectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconCell: UIImageView!
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: thickness)
            
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.bounds.height - thickness,  width: self.bounds.width, height: thickness)
            
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0,  width: thickness, height: self.bounds.height)
            
        case UIRectEdge.right:
            border.frame = CGRect(x: self.bounds.width - thickness, y: 0,  width: thickness, height: self.bounds.height)
            
        default:
            break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}


