//
//  ImageOptionCell.swift
//  AudiDynamicPOC
//
//  Created by MacBook Pro on 07/09/21.
//

import UIKit

class ImageOptionCell: UITableViewCell {
    var imageContainerView:UIView = {
               let view = UIView()
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
    var imageLabel:UILabel = {
              let label = UILabel()
              label.font = UIFont.boldSystemFont(ofSize: 20)
              label.textColor = .black
              label.translatesAutoresizingMaskIntoConstraints = false
              return label
          }()
          
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
             super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageContainerView = UIView(frame: CGRect(x: 5, y: 0, width: Int(self.frame.width - 10), height: 44))
        //imageContainerView.backgroundColor = .magenta
        imageLabel = UILabel(frame: CGRect(x:5, y: 5, width:90, height: 35))
        //imageLabel.backgroundColor = .yellow
        profileImageView = UIImageView(frame:CGRect(x:Int(self.frame.width - 90), y: 5, width: 40, height: 40))
        profileImageView.contentMode = .scaleAspectFit
        //imageLabel.backgroundColor = .red
        
        imageContainerView.addSubview(imageLabel)
                        //containerView.addSubview(profileImageView)
        imageContainerView.addSubview(profileImageView)
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
       
        self.contentView.addSubview(imageContainerView)
       // selectionStyle = .none
        imageContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 100, height: 0, enableInsets: false)
//        imageLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight:0, width:0, height:0, enableInsets: false)
//         profileImageView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight:50, width:50, height:50, enableInsets: false)
        
        
        if (UIDevice.isPad){
            imageLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop:10, paddingLeft:5, paddingBottom:10, paddingRight:0, width: self.frame.width - 10, height: 0, enableInsets: false)
             profileImageView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight:140, width:60, height:60, enableInsets: false)
        }else{
            imageLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop:10, paddingLeft:5, paddingBottom:10, paddingRight:0, width: self.frame.width - 100, height: 0, enableInsets: false)
             profileImageView.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight:80, width:40, height:40, enableInsets: false)
        }
    }
    
func configCell(text:String,titleName:String,txtdict:[[String:String]:String],imgDict:[String:UIImage],tag:Int){
        imageLabel.text = "\(text)"
    let row = tag % 1000
    let section = tag / 1000
    imageLabel.text = "\(titleName)"
    if let image = imgDict["\(row)"] {
                        //if profileImageView == view.viewWithTag(indexPath.row){
            profileImageView.image = image
            profileImageView.layer.borderWidth = 0.5
            profileImageView.layer.borderColor = UIColor.black.cgColor
                        //}
        } else {
            profileImageView.image = UIImage(named: "place_h_Image")
            //profileImageView.layer.borderWidth = 0.5
            //profileImageView.layer.borderColor = UIColor.lightGray.cgColor
            if #available(iOS 13.0, *) {
                let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
                profileImageView.image = UIImage(systemName: "camera.fill", withConfiguration: boldConfig)?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            } else {
                // Fallback on earlier versions
            }
          
    }
    
                        //            profileImageView.contentMode = .scaleAspectFit
                        //
                       // imageContainerView.backgroundColor = .brown
       
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
