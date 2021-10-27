//
//  UIViewController+Extension.swift
//  SkodaValuation
//
//  Created by Raju@MFCWL on 29/10/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromStoryBoard storyboard: AppStoryboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}

enum AppStoryboard: String {
    case Main
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = viewControllerClass.storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

