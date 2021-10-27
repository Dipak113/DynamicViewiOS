//
//  CustomNavigationBar.swift
//  AudiAutoInspekt
//
//  Created by jagadeesh k on 06/05/21.
//

import UIKit

class CustomNavigationBar: UIView {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var headerLBL: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func instanceViewFromNib() -> UIView {
        return UINib(nibName: "CustomNavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
