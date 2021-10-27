//
//  CustomeCell.swift
//  AudiDynamicPOC
//
//  Created by MacBook Pro on 30/08/21.
//

import UIKit
protocol CustomeCellDelegate {
    func valueChanged(_ textField: UITextField)
}
class CustomeCell: UITableViewCell, UITextFieldDelegate {

    var containerViewTxtField:UIView = {
                   let view = UIView()
                   view.translatesAutoresizingMaskIntoConstraints = false
                   view.clipsToBounds = true // this will make sure its children do not go out of the boundary
                   return view
               }()
    var labeltxtField:UILabel = {
                  let label = UILabel()
                  label.font = UIFont.boldSystemFont(ofSize: 10)
                  label.textColor = .black
                  return label
              }()
    var categoryTxtField:UITextField = {
                       let text = UITextField()
                       text.clipsToBounds = true // this will make sure its children do not go out of the boundary
                       return text
                   }()
   // weak var delegate : CustomeCellDelegate?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {

             super.init(style: style, reuseIdentifier: reuseIdentifier)
             //Do your cell set up
        containerViewTxtField = UIView(frame: CGRect(x: 0, y:2, width: Int(self.frame.width), height: 60))
        //containerViewTxtField.backgroundColor = .magenta
        labeltxtField = UILabel(frame: CGRect(x:5, y:2, width:Int(self.frame.width - 10), height: 20))
        //labeltxtField.backgroundColor = .cyan
        //labeltxtField.text = "\(data.displayTitle)"
        
        categoryTxtField = UITextField(frame: CGRect(x:0, y:Int(labeltxtField.frame.origin.y + labeltxtField.frame.size.height + 5), width: Int(self.frame.width - 10), height: 30))
       
        categoryTxtField.font = UIFont.systemFont(ofSize: 15)
        categoryTxtField.delegate = self
        //categoryTxtField.backgroundColor = .yellow
        //categoryTxtField.tag = (self.indexPath2?.section * 1000) + indexPath2?.row

        categoryTxtField.borderStyle = UITextField.BorderStyle.line
        categoryTxtField.autocorrectionType = UITextAutocorrectionType.no
        categoryTxtField.keyboardType = UIKeyboardType.default
        categoryTxtField.returnKeyType = UIReturnKeyType.done
        categoryTxtField.tintColor = .red
        //categoryTxtField.clearButtonMode = UITextField.ViewMode.whileEditing
        categoryTxtField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //categoryTxtField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        containerViewTxtField.addSubview(categoryTxtField)
      
        containerViewTxtField.addSubview(labeltxtField)
        
        
        labeltxtField.translatesAutoresizingMaskIntoConstraints = false
        categoryTxtField.translatesAutoresizingMaskIntoConstraints = false
        containerViewTxtField.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(containerViewTxtField)
        
        containerViewTxtField.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 100, height: 0, enableInsets: false)
        labeltxtField.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:5, paddingBottom:30, paddingRight: 0, width:0, height:0, enableInsets: false)
        categoryTxtField.anchor(top: labeltxtField.bottomAnchor, left: leftAnchor, bottom: bottomAnchor , right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 10, height:0, enableInsets: true)
       
          self.selectionStyle = .none
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(text:String,titleName:String,dict:[[String:String]:String],tag:Int){
        categoryTxtField.placeholder = "Please Enter \(titleName)"
        labeltxtField.text = "\(titleName)"
        let row = tag % 1000
        let section = tag / 1000
        //categoryTxtField.tag = (indexPath2.section * 1000) + indexPath2.row
        if let text = dict[["\(section)":"\(row)"]] {
            categoryTxtField.text = text
        }else{
            categoryTxtField.placeholder = "Please Enter \(text)"
        }
    }
    
  
//    func configCell(at indexPath: IndexPath,stext:String) {
//        let view = viewWithTag(indexPath.row)
//        print(view as Any)
//        self.contentView.addSubview(nameLabel)
//        nameLabel.text = stext
//        
//    }
    
//    override func prepareForReuse() {
//            super.prepareForReuse()
//            // Clear all content based views and their actions here
//        for view in self.contentView.subviews  {
//                if let txtField = view as? UITextField {
//                    txtField.text = ""
//                    print("txtField")
//                    txtField.removeFromSuperview()
//                }else if let label = view as? UILabel {
//                    label.text = ""
//                    print("label")
//                    label.removeFromSuperview()
//                }else if let viewContainer = view as? UIView {
//                    //print("containerView")
//                    viewContainer.removeFromSuperview()
//                }
//            }
//        self.contentView.subviews.forEach { $0.removeFromSuperview() }
//        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//            super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}


extension UITableViewCell{

    var tableView:UITableView?{
        return superview as? UITableView
    }

    var indexPath2:IndexPath?{
        return tableView?.indexPath(for: self)
    }

}
