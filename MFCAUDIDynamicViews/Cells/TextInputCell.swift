//
//  TextInputCell.swift
//  AudiDynamicPOC
//
//  Created by MacBook Pro on 06/09/21.
//

import UIKit

class TextInputCell: UITableViewCell, UITextFieldDelegate {
    var containerView:UIView = {
               let view = UIView()
               view.translatesAutoresizingMaskIntoConstraints = false
               view.clipsToBounds = true // this will make sure its children do not go out of the boundary
               return view
           }()
    var imageContainerView:UIView = {
               let view = UIView()
               view.translatesAutoresizingMaskIntoConstraints = false
               view.clipsToBounds = true // this will make sure its children do not go out of the boundary
               return view
           }()
    var profileImageView:UIImageView = {
              let img = UIImageView()
              img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
              img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
              img.layer.cornerRadius = 35
              img.clipsToBounds = true
              return img
          }()
          
    var nameLabel:UILabel = {
              let label = UILabel()
              label.font = UIFont.boldSystemFont(ofSize: 20)
              label.textColor = .black
              label.translatesAutoresizingMaskIntoConstraints = false
              return label
          }()
    var imageLabel:UILabel = {
              let label = UILabel()
              label.font = UIFont.boldSystemFont(ofSize: 20)
              label.textColor = .black
              label.translatesAutoresizingMaskIntoConstraints = false
              return label
          }()
    var imageButton:UIButton = {
                  let imageButton = UIButton()
                  //imageButton  UIFont.boldSystemFont(ofSize: 20)
                  imageButton.titleLabel?.textColor = .black
                  imageButton.translatesAutoresizingMaskIntoConstraints = false
                  return imageButton
              }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
             super.init(style: style, reuseIdentifier: reuseIdentifier)
//MARK: - Construction of Objects
        containerView = UIView(frame: CGRect(x: 5, y: 0, width: Int(self.frame.width - 10), height: 44))
        
        imageButton = UIButton(frame: CGRect(x:Int(containerView.frame.width - 140), y: 5, width: 140, height: 35))
        //imageButton.backgroundColor = .yellow
        imageButton.setTitle("Update", for: .normal)
        imageButton.setTitleColor(.black, for: .normal)
        nameLabel = UILabel(frame: CGRect(x:5, y: 5, width:90, height: 35))
        //nameLabel.backgroundColor = .cyan
        //nameLabel.text = "\(data.displayTitle)"
        containerView.addSubview(nameLabel)
        //containerView.addSubview(profileImageView)
        containerView.addSubview(imageButton)
        //containerView.bringSubviewToFront(profileImageView)
        //containerView.backgroundColor = .red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(containerView)
//MARK: - Objects Constraint
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 100, height: 0, enableInsets: false)
        
        if (UIDevice.isPad){
            nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop:10, paddingLeft:5, paddingBottom:10, paddingRight:0, width: self.frame.width - 10, height: 0, enableInsets: false)
            imageButton.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop:10, paddingLeft:200, paddingBottom:10, paddingRight:140, width:0, height: 0, enableInsets: false)
        }else{
            nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop:10, paddingLeft:5, paddingBottom:10, paddingRight:0, width: self.frame.width - 100, height: 0, enableInsets: false)
            imageButton.anchor(top: topAnchor, left: nameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop:10, paddingLeft:10, paddingBottom:10, paddingRight:10, width:0, height: 0, enableInsets: false)
        }
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cofigedCell(text:String,btntitle:String,labelDict:[[String:String]:String],buttonDict:[[String:String]:String],tag:Int,data:[Section]){
        let row = tag % 1000
        let section = tag / 1000
        nameLabel.text = "\(text)"
        let Newdata = data[section].fields[row]
        if Newdata.fieldDynamic == false && (Newdata.staticValue != nil){
            if let Newtitle = labelDict[["\(section)":"\(row)"]] {
                imageButton.setTitle(Newtitle, for: .normal)
            }else{
                imageButton.setTitle(btntitle, for: .normal)
            }
        }else if Newdata.fieldDynamic == true && (Newdata.dynamicValue != nil){
            if let Newtitle = buttonDict[["\(section)":"\(row)"]] {
                imageButton.setTitle(Newtitle, for: .normal)
            }else{
                imageButton.setTitle(btntitle, for: .normal)
            }
        }
        
       
    }
    
    func configCell(text:String,titleName:String,txtdict:[[String:String]:String],imgDict:[[String:String]:String],tag:Int,data:[Section]){
        //categoryTxtField.placeholder = "Please Enter \(data.displayTitle)"
        let row = tag % 1000
        let section = tag / 1000
       
//        nameLabel.text = "\(titleName)"
        if let text = txtdict[["\(section)":"\(row)"]] {
            imageButton.setTitle(text, for: .normal)
        }else{
            nameLabel.text = "\(titleName)"
        }
        
        if data[section].fields[row].fieldDynamic == false{
            if let dict = data[section].fields[row].staticValue{
                let stringType = dict.valueType
                    if stringType == "array"{
            if let text = imgDict[["\(section)":"\(row)"]] {
                    imageButton.setTitle(text, for: .normal)
                }else{
                    nameLabel.text = "\(titleName)"
                }
               
            }
          }
            nameLabel.textColor = .red
            containerView.tag = (section * 1000) + row
            nameLabel.tag = (section * 1000) + row
            imageButton.tag = (section * 1000) + row
        }else if data[section].fields[row].fieldDynamic == true{
            
            if let text = imgDict[["\(section)":"\(row)"]] {
                    imageButton.setTitle(text, for: .normal)
                }else{
                    nameLabel.text = "\(titleName)"
                }
            nameLabel.textColor = .blue
            containerView.tag = (section * 1000) + row
            nameLabel.tag = (section * 1000) + row
            imageButton.tag = (section * 1000) + row
        }
        
                      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
