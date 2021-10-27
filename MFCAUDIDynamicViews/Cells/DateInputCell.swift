//
//  DateInputCell.swift
//  AudiDynamicPOC
//
//  Created by MacBook Pro on 07/09/21.
//

import UIKit
//protocol DateInputCellDelegate {
//    func dateChanged(_ sender: UIButton)
//}
class DateInputCell: UITableViewCell {
    var containerView:UIView = {
               let view = UIView()
               
               view.clipsToBounds = true // this will make sure its children do not go out of the boundary
               return view
           }()
    var nameLabel:UILabel = {
              let label = UILabel()
              label.font = UIFont.boldSystemFont(ofSize: 20)
              label.textColor = .black
              label.translatesAutoresizingMaskIntoConstraints = false
              return label
          }()
    
    var imageButtonForDate:UIButton = {
                  let imageButton = UIButton()
                  //imageButton  UIFont.boldSystemFont(ofSize: 20)
                  imageButton.titleLabel?.textColor = .black
                  imageButton.translatesAutoresizingMaskIntoConstraints = false
                  return imageButton
              }()
    // var delegate:DateInputCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
             super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView = UIView(frame: CGRect(x: 5, y: 5, width: Int(self.frame.width - 10), height: 44))
        imageButtonForDate = UIButton(frame: CGRect(x:Int(containerView.frame.width - 140), y: 5, width: 140, height: 35))
       // imageButton.backgroundColor = .yellow
        imageButtonForDate.setTitle("Update", for: .normal)
        imageButtonForDate.setTitleColor(.black, for: .normal)
        
    
        nameLabel = UILabel(frame: CGRect(x:5, y: 5, width:90, height: 35))
        //nameLabel.backgroundColor = .red
        nameLabel.textColor = .black
        
        containerView.addSubview(nameLabel)
                        //containerView.addSubview(profileImageView)
        containerView.addSubview(imageButtonForDate)
                        //containerView.bringSubviewToFront(profileImageView)
                        //containerView.backgroundColor = .red
        self.contentView.addSubview(containerView)
                      // cell.textLabel?.text = "\(data.displayTitle)"
        selectionStyle = .none
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 100, height: 0, enableInsets: false)
        
        if (UIDevice.isPad){
            nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop:10, paddingLeft:5, paddingBottom:10, paddingRight:0, width: self.frame.width - 10, height: 0, enableInsets: false)
            imageButtonForDate.anchor(top: topAnchor, left:nil, bottom: bottomAnchor, right: rightAnchor, paddingTop:10, paddingLeft:200, paddingBottom:10, paddingRight:140, width:0, height: 0, enableInsets: false)
        }else{
            nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop:10, paddingLeft:5, paddingBottom:10, paddingRight:0, width: self.frame.width - 100, height: 0, enableInsets: false)
            imageButtonForDate.anchor(top: topAnchor, left: nameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop:10, paddingLeft:10, paddingBottom:10, paddingRight:10, width:0, height: 0, enableInsets: false)
        }
       
        //                nameLabel.tag = indexPath.row
        //                nameLabel.text = "\(data.displayTitle)"
        //
        //
        //                if let text = dateDict[["\(indexPath.section)":"\(indexPath.row)"]] {
        //                    //nameLabel.text = text
        //                    imageButton.setTitle(text, for: .normal)
        //                }else{
        //                    nameLabel.text = "\(data.displayTitle)"
        //                }
        //
        //               ///nameLabel.text = "\(data.displayTitle)"
        //                containerView.addSubview(nameLabel)
        //                //containerView.addSubview(profileImageView)
        //                containerView.addSubview(imageButton)
        //                //containerView.bringSubviewToFront(profileImageView)
        //                //containerView.backgroundColor = .red
        //                cell.contentView.addSubview(containerView)
        //              // cell.textLabel?.text = "\(data.displayTitle)"
        //                cell.selectionStyle = .none

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(text:String,titleName:String,DateDict:[[String:String]:String],tag:Int){
        
        let row = tag % 1000
        let section = tag / 1000
        //imageButton.tag = (indexPath.section * 1000) + indexPath.row
        //                imageButton.addTarget(self, action: #selector(showPickerPopup), for: .touchUpInside)
        //nameLabel.tag = row
        nameLabel.text = "\(text)"
        
        if let text = DateDict[["\(section)":"\(row)"]] {
                            //nameLabel.text = text
            imageButtonForDate.setTitle(text, for: .normal)
        }else{
            nameLabel.text = "\(titleName)"
        }
                       ///nameLabel.text = "\(data.displayTitle)"
       
    }
    
//    func dateChangedAction(_ sender: UIButton){
//        self.delegate?.dateChanged(imageButton)
//    }

}
