//
//  BaseViewController.swift
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

class BaseViewController: UIViewController {

    func goToSection(storyBoard: String){
        DispatchQueue.main.async {
            if let homeVC = UIStoryboard(name: storyBoard, bundle: nil).instantiateInitialViewController() {
                let home = homeVC
                home.modalPresentationStyle = .fullScreen
                self.present(home, animated: true, completion: nil)
            }
        }
    }
    
    func goToStoryBoard(storyBoard: String, controller: String = ""){
        debugPrint("entro a goToStoryBoard: ")
         let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        let initialViewController: UIViewController
        if controller == "" {
            initialViewController = storyboard.instantiateInitialViewController()!
        } else {
            initialViewController = storyboard.instantiateViewController(withIdentifier: controller)
        }
        appdelegate.window?.rootViewController = initialViewController
        appdelegate.window?.makeKeyAndVisible()
    }
    
}
