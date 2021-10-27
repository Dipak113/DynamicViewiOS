//
//  FollowupDatePickerView.swift
//  MFCDealer
//
//  Created by Raju@MFCWL on 14/10/19.
//  Copyright © 2019 Mahindra First Choice Wheels Ltd-Banglore. All rights reserved.
//

import UIKit

class SelectDatePickerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    func instanceViewFromNib() -> UIView {
        return UINib(nibName: "SelectDatePickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    func initiateView() {
        self.doneBtn?.isEnabled = false
        self.doneBtn?.isHidden = true
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else {return}
        self.datePicker?.minimumDate = tomorrow
        
//        if (@available(iOS 14, *)) {
//              UIDatePicker *picker = [UIDatePicker appearance];
//            picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
//        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        self.datePicker?.setDate(tomorrow, animated: true)
        self.displaySelectedDate(date: tomorrow)
    }
    
    @IBAction func dateValueChnaged(_ sender: UIDatePicker) {
        self.displaySelectedDate(date: sender.date)
    }
    
    internal func displaySelectedDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.DateTimeWebLeads.rawValue
        let dateStr = dateFormatter.string(from: date)
        
       
        self.valueLabel?.text = dateStr
        self.doneBtn?.isEnabled = true
        self.doneBtn?.isHidden = false
    }
    
}
