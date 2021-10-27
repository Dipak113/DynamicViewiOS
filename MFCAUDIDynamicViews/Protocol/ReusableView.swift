//
//  ReusableView.swift
//  SkodaValuation
//
//  Created by Raju@MFCWL on 30/10/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.nibName, bundle: nil)
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Could not deueue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionViewCell: NibLoadableView {}
extension UICollectionView {
    
//    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
//        let Nib = UINib(nibName: T.nibName, bundle: nil)
//        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
//    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Could not deueue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

