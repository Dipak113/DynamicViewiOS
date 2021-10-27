//
//  UITextField+Extension.swift
//  SkodaValuation
//
//  Created by Raju@MFCWL on 29/10/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            }
            else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxlenght(textField:)), for: .editingChanged)
        }
    }
    
    @objc func checkMaxlenght(textField: UITextField) {
        
        guard let prospectiveText = self.text,prospectiveText.count > maxLength else {return }
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        //text = prospectiveText.substring(to: maxCharIndex)
        //let index = prospectiveText.index(prospectiveText.startIndex, offsetBy: max)
        text = String(prospectiveText[..<maxCharIndex])
        selectedTextRange = selection
    }
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
         // Create a UIDatePicker object and assign to inputView
         let screenWidth = UIScreen.main.bounds.width
         let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
         datePicker.datePickerMode = .date //2
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions

        }
         
         self.inputView = datePicker //3
       
         // Create a toolbar and assign it to inputAccessoryView
         let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
         let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
         let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
         let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
         toolBar.setItems([cancel, flexible, barButton], animated: false) //8
         self.inputAccessoryView = toolBar //9
     }
     
     @objc func tapCancel() {
         self.resignFirstResponder()
     }
    
    
    func setLeftPaddingPoints(_ space:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ space:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
@IBDesignable extension UITextField{
    
    @IBInspectable var setImageName: String {
        get{
            return ""
        }
        set{
            let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width:30, height: self.frame.height))
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            imageView.image = UIImage(named: newValue)!
            containerView.addSubview(imageView)
            imageView.center = containerView.center
            self.rightView = containerView
            self.rightViewMode = UITextField.ViewMode.always
        }
        
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func validatePANCardNumber() -> Bool{
        let regularExpression = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        let panCardValidation = NSPredicate(format : "SELF MATCHES %@", regularExpression)
        return panCardValidation.evaluate(with: self)
    }
    
    func validateGSTNumber() -> Bool{
        let regularExpression = "[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9]{1}"
        let gstValidation = NSPredicate(format : "SELF MATCHES %@", regularExpression)
        return gstValidation.evaluate(with: self)
    }
    
    func validateVehicleRegistrationNumber() -> Bool{
          let regularExpression = "[A-Z]{2} 0-9 a-zA-Z]"
//            "[a-zA-Z0-9]+" "[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}"
//
          let vehicleRegValidation = NSPredicate(format : "SELF MATCHES %@", regularExpression)
          return vehicleRegValidation.evaluate(with: self)
      }

     func textFieldAllow(_ allowCharcters: String, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool {
        let aSet = NSCharacterSet(charactersIn:allowCharcters).inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func whiteSpacesRemoved() -> String {
      return self.filter { $0 != Character(" ") }
    }
}

extension UIView {
     func statusBarColor(){
        if #available(iOS 13.0, *) {
             let app = UIApplication.shared
             let statusBarHeight: CGFloat = app.statusBarFrame.size.height
             let statusbarView = UIView()
             statusbarView.backgroundColor = UIColor.clear
             self.addSubview(statusbarView)
             statusbarView.translatesAutoresizingMaskIntoConstraints = false
             statusbarView.heightAnchor
                 .constraint(equalToConstant: statusBarHeight).isActive = true
             statusbarView.widthAnchor
                 .constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
             statusbarView.topAnchor
                 .constraint(equalTo: self.topAnchor).isActive = true
             statusbarView.centerXAnchor
                 .constraint(equalTo: self.centerXAnchor).isActive = true
         } else {
             let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
             statusBar?.backgroundColor = UIColor(red: 227/255, green: 110/255, blue: 30/255, alpha: 1.0)
         }
    }
}


