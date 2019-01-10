//
//  UIStoryboard+UIViewControllers.swift
//  Movie_App
//
//  Created by MAC110 on 1/9/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
}


extension UIStoryboard {
    
    var homeViewController: HomeViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController else {
            fatalError(String(describing: HomeViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    var searchViewConroller: SearchViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as? SearchViewController else {
            fatalError(String(describing: SearchViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    
    
}
