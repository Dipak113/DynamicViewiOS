//
//  UIView+Extension.swift
//  SkodaValuation
//
//  Created by Raju@MFCWL on 29/10/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

extension UIView {
    
    // Corner Radius
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    // Border Color
    
    @IBInspectable var borderColor: UIColor {
        get {
            return (layer.borderColor as? UIColor)!
        }
        set {
            layer.borderColor = newValue.cgColor
            layer.borderWidth = 1
        }
    }
    
    // Circle
    
    @IBInspectable var circle: Bool {
        get {
            return layer.cornerRadius == self.bounds.width * 0.5
        }
        set {
            if newValue == true {
                self.layer.cornerRadius = self.bounds.width * 0.5
            }
        }
    }
    
    func dropShadow() {
        DispatchQueue.main.async {
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = 5
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

// CALayer Extension
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat, frameWidth: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frameWidth, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frameWidth, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frameWidth - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}


// MARK:- Activity indicator
fileprivate var ActivityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"
public extension UIView {
    var activityIndicatorView: UIActivityIndicatorView {
        get {
            if let activityIndicatorView = getAssociatedObject(&ActivityIndicatorViewAssociativeKey) as? UIActivityIndicatorView {
                return activityIndicatorView
            } else {
                let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width/3, height: self.frame.size.width/3))
                activityIndicatorView.layer.cornerRadius = 5
                //activityIndicatorView.backgroundColor = UIColor(white: 1.0, alpha: 0.6)
                if #available(iOS 13.0, *) {
                    activityIndicatorView.backgroundColor = UIColor.systemGroupedBackground
                } else {
                    // Fallback on earlier versions
                    activityIndicatorView.backgroundColor = UIColor.groupTableViewBackground
                }
                if #available(iOS 13.0, *) {
                    activityIndicatorView.style = UIActivityIndicatorView.Style.medium
                } else {
                    // Fallback on earlier versions
                    activityIndicatorView.style = .gray

                }
                activityIndicatorView.color = UIColor.black
                activityIndicatorView.center = center
                activityIndicatorView.hidesWhenStopped = true
                addSubview(activityIndicatorView)
                
                setAssociatedObject(activityIndicatorView, associativeKey: &ActivityIndicatorViewAssociativeKey, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activityIndicatorView
            }
        }
        
        set {
            addSubview(newValue)
            setAssociatedObject(newValue, associativeKey:&ActivityIndicatorViewAssociativeKey, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension NSObject {
    func setAssociatedObject(_ value: AnyObject?, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
        if let valueAsAnyObject = value {
            objc_setAssociatedObject(self, associativeKey, valueAsAnyObject, policy)
        }
    }
    
    func getAssociatedObject(_ associativeKey: UnsafeRawPointer) -> Any? {
        guard let valueAsType = objc_getAssociatedObject(self, associativeKey) else {
            return nil
        }
        return valueAsType
    }
}

