//
//  ViewController.swift
//  MFCAUDIDynamicViews
//
//  Created by MacBook Pro on 01/10/21.
//

import UIKit
import KRProgressHUD
class ViewController: UIViewController {
    let tbleViewHeader = [String]()
    typealias JsonDictionay = [String : Any]
    var arrOfFields = [Section]()
    var arrOfSubReq = [SubmitRequest]()
    var arrOfSections = [String]()
    var arrOfSectionName = [String]()
    var arrOfElementId = [Any]()
    var arrOfDisplayName = [String]()
    var arrOfFieldType = [String]()
    var txtCommon = UITextField()
    var hiddenSections = Set<Int>()
    var imageDict = [String:UIImage]() //ImageViewDictionary
    var dateDict = [[String:String]:String]() //DateDictionary
    var UpdateDict = [[String:String]:String]() //Update Option Dictionary
    var labelDict = [[String:String]:String]() //Static values Dictionary
    var txtFieldDict = [[String:String]:String]() //Static values Dictionary
    var figures = [SectionField]()
    var welcome = DynamicModel.self
    var pickerPopUpView = SelectDatePickerView()
    var homeNavBarView = CustomNavigationBar()
    var arrEvalSubData = [String:Any]()
    var fieldElementDict = [SectionField]()
    var dictOfImage = [String:UIImage]()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewForVehicleDetailPage: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
                configPickerPopUp()
                configNavBar()
               parseJSON()
              //  print(self.tblViewForVehicleDetailPage.contentSize)
                //
               //
               // self.tblViewForVehicleDetailPage.register(CustomeCell.self, forCellReuseIdentifier: "cell")
                self.tblViewForVehicleDetailPage.register(CustomeCell.self, forCellReuseIdentifier: "cellId")
                self.tblViewForVehicleDetailPage.register(TextInputCell.self, forCellReuseIdentifier: "newID")
                
                self.tblViewForVehicleDetailPage.register(ImageOptionCell.self, forCellReuseIdentifier: "imageId")
                
                self.tblViewForVehicleDetailPage.register(DateInputCell.self, forCellReuseIdentifier: "dateId")
                
    }
    
    //MARK: - Data Parsing from given json request
        func parseJSON(){

            if let path = Bundle.main.path(forResource: "newForm_sections", ofType: "json") {

                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONDecoder().decode(welcome.self, from: data)

                    let arrOfSections = jsonResult.forms[0].sections
                    arrOfFields = arrOfSections
                    for sectioned in arrOfSections{
                        arrOfSectionName.append(sectioned.sectionName)
                        for field in sectioned.fields{
                            arrOfDisplayName.append(field.displayTitle)
                            arrOfElementId.append(field.tagid)
                            arrOfFieldType.append(field.fieldType.rawValue)
                        }

                    }
                    print(arrOfFieldType.count,arrOfDisplayName.count,arrOfElementId.count)
                    DispatchQueue.main.async {
                            self.tblViewForVehicleDetailPage.tableFooterView = self.getfooterView()
                            self.tblViewForVehicleDetailPage.reloadData()
                            self.tableHeight.constant = self.getTableViewHeight()
                            print(self.arrOfFields)
                         }

                } catch {
                   print(error)
                }
            }
        }
    
    func getTableViewHeight() -> CGFloat{
        tblViewForVehicleDetailPage.reloadData()
        tblViewForVehicleDetailPage.layoutIfNeeded()

        return tblViewForVehicleDetailPage.contentSize.height  + CGFloat(arrOfDisplayName.count + arrOfFields.count + 55 + 64) + tblViewForVehicleDetailPage.contentInset.bottom + tblViewForVehicleDetailPage.contentInset.top
        }
    
    internal func configNavBar() {
      homeNavBarView = homeNavBarView.instanceViewFromNib() as! CustomNavigationBar
        homeNavBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (self.navigationController?.navigationBar.bounds.height) ?? 64.0)
      homeNavBarView.backBtn.addTarget(self, action: #selector(self.goBack(_:)), for: .touchUpInside)
        homeNavBarView.viewBG.backgroundColor = UIColor(hexString: "#BB0A30")

      self.homeNavBarView.headerLBL.alpha = 1.0
      self.homeNavBarView.headerLBL.textAlignment = .left
       self.homeNavBarView.headerLBL.text = "Vehicle Detail"

      self.navigationController?.navigationBar.addSubview(self.homeNavBarView)
  }
    
    
    @objc func goBack(_ Sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
        
        func getfooterView() -> UIView
        {
            let Header = UIView(frame: CGRect(x:0, y: 0, width: Double(self.tblViewForVehicleDetailPage.frame.size.width), height: 55))
            //Header.backgroundColor = .systemYellow
            let button = UIButton()
             button.frame = CGRect(x: 35, y: 5, width: Header.frame.size.width - 70 , height: Header.frame.size.height - 10)
           // button.backgroundColor = .brown
            button.backgroundColor = UIColor(hexString: "#BB0A30")
            button.setTitle("Submit", for: .normal)
            button.setTitleColor(.white, for: .normal)
           // button.addTarget(self, action: #selector(SubmitAction), for: UIControl.Event.touchUpInside)

            Header.addSubview(button)
            Header.bringSubviewToFront(button)
            return Header
        }

}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(arrOfSectionName.count)
        return  arrOfSectionName.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            if self.hiddenSections.contains(section) {
//                return 0
//            }
        print(arrOfFields[section].fields.count)
        return arrOfFields[section].fields.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        if section < arrOfSections.count {
//            return arrOfSections[section]
//        }
//
//        return nil
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        var sectionButton = UIButton()
        if (UIDevice.isPad){
           sectionButton = UIButton(frame: CGRect(x:10, y: 0, width: Int(self.view.frame.width), height: 40))
        }else {
            sectionButton = UIButton(frame: CGRect(x:10, y: 0, width: Int(self.view.frame.width - 10), height: 40))
        }
       
        // 2
        sectionButton.setTitle(arrOfSectionName[section],
                               for: .normal)
//        sectionButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 100, height: 0, enableInsets: false)
       
        // 3
        sectionButton.backgroundColor = UIColor(hexString: "#BB0A30")
        
        sectionButton.setTitleColor(.white,
                               for: .normal)
        
        sectionButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16.0)
//        sectionButton.titleLabel?.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        sectionButton.contentEdgeInsets = UIEdgeInsets(top: 5, left:8, bottom: 5, right: 5)
        sectionButton.contentHorizontalAlignment = .left
        //sectionButton.anchor(top: .top, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 100, height: 0, enableInsets: false)
        // 4
        sectionButton.tag = section
        
        // 5
//        sectionButton.addTarget(self,
//                                action: #selector(self.hideSection(sender:)),
//                                for: .touchUpInside)

        return sectionButton
     }
    
    @objc private func hideSection(sender: UIButton) {
        let section1 = sender.tag
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<arrOfFields[section1].fields.count {
                indexPaths.append(IndexPath(row: row,
                                            section: section1))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section1) {
            self.hiddenSections.remove(section1)
            self.tblViewForVehicleDetailPage.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.insert(section1)
            self.tblViewForVehicleDetailPage.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrOfFields[indexPath.section].fields[indexPath.row]
        let fieldType = arrOfFields[indexPath.section].fields[indexPath.row].fieldType
        print(fieldType as Any)

            switch fieldType {
            case .text:
                print("Nothing")
                guard let cell = self.tblViewForVehicleDetailPage.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? CustomeCell else {
                        fatalError("Dequeued cell is not an instance of CharacterDetailsTableViewCell class.")
                    }
                cell.categoryTxtField.tag = (indexPath.section * 1000) + indexPath.row
                cell.categoryTxtField.delegate = self
                cell.labeltxtField.tag = (indexPath.section * 1000) + indexPath.row
                cell.configCell(text:"\(data.displayTitle)" , titleName: "\(data.displayTitle)", dict: txtFieldDict, tag: (indexPath.section * 1000) + indexPath.row)
                return cell
            case .options:
                guard let cell = self.tblViewForVehicleDetailPage.dequeueReusableCell(withIdentifier: "newID", for: indexPath) as? TextInputCell else {
                        fatalError("Dequeued cell is not an instance of CharacterDetailsTableViewCell class.")
                    }
                
                
                cell.imageButton.tag = (indexPath.section * 1000) + indexPath.row
                cell.nameLabel.tag = (indexPath.section * 1000) + indexPath.row
                cell.containerView.tag = (indexPath.section * 1000) + indexPath.row
                cell.imageButton.addTarget(self, action: #selector(buttonNewUpdatePressed(_:)), for: .touchUpInside)
                
                cell.cofigedCell(text: data.displayTitle, btntitle: data.defaultValue.rawValue, labelDict: UpdateDict, buttonDict: labelDict, tag: (indexPath.section * 1000) + indexPath.row,data: arrOfFields)
              
//                    if data.fieldDynamic == false && (data.staticValue != nil){
////                                        print(data.fieldType,data.displayTitle,data.fieldDynamic)
//                                        if let dict = data.staticValue{
//                                            let stringType = dict.valueType
//                                            if stringType == "array"{
//                                                print(data.fieldType,data.displayTitle,data.fieldDynamic)
//                                                cell.imageButton.isUserInteractionEnabled = false
//                                    cell.imageButton.addTarget(self, action: #selector(buttonUpdatePressed), for: .touchUpInside)
//                                                cell.imageButton.backgroundColor = .blue
//                                            }
//                                        }
//                        print("Dhondge\(indexPath.section),\(indexPath.row),\(data.displayTitle)")
//
//                    }else if data.fieldDynamic == true && (data.dynamicValue != nil){
//                        cell.imageButton.addTarget(self, action: #selector(listUpdatePressed), for: .touchUpInside)
//                                        cell.imageButton.backgroundColor = .red
//                print("Dipak\(indexPath.section),\(indexPath.row),\(data.displayTitle)")
//                        cell.imageButton.isUserInteractionEnabled = true
//                        }
//
//                    cell.configCell(text: "\(data.displayTitle)", titleName: "\(data.displayTitle)", txtdict: UpdateDict, imgDict: labelDict, tag:  (indexPath.section * 1000) + indexPath.row, data: arrOfFields)
              
                return cell

            case .image:
                guard let cell = self.tblViewForVehicleDetailPage.dequeueReusableCell(withIdentifier: "imageId", for: indexPath) as? ImageOptionCell else {
                        fatalError("Dequeued cell is not an instance of CharacterDetailsTableViewCell class.")
                    }
//                    cell.backgroundColor = UIColor.lightGray
                cell.profileImageView.tag = (indexPath.section * 1000) + indexPath.row
                cell.imageLabel.tag = (indexPath.section * 1000) + indexPath.row
                cell.configCell(text: "\(data.displayTitle)", titleName: "\(data.displayTitle)", txtdict: UpdateDict, imgDict: imageDict, tag:  (indexPath.section * 1000) + indexPath.row)
                return cell
//                imageContainerView = UIView(frame: CGRect(x: 5, y: 0, width: Int(self.view.frame.width - 10), height: 44))
//                imageLabel = UILabel(frame: CGRect(x:5, y: 5, width:180, height: 35))
//                imageLabel.text = "\(data.displayTitle)"
//
//                profileImageView = UIImageView(frame:CGRect(x:Int(containerView.frame.width - 90), y: 5, width: 40, height: 40))
//                profileImageView.contentMode = .scaleAspectFit
//                //print(indexPath.row)
//                if let image = imageDict["\(indexPath.row)"] {
//                    //if profileImageView == view.viewWithTag(indexPath.row){
//                        profileImageView.image = image
//                        profileImageView.layer.borderWidth = 0.5
//                        profileImageView.layer.borderColor = UIColor.black.cgColor
//                    //}
//                } else {
//                    //profileImageView.image = UIImage(named: "place_h_Image")
////                    profileImageView.layer.borderWidth = 0.5
////                    profileImageView.layer.borderColor = UIColor.lightGray.cgColor
//                    let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//                    profileImageView.image = UIImage(systemName: "camera.fill", withConfiguration: boldConfig)?.withTintColor(.orange, renderingMode: .alwaysOriginal)
//                }
//                    //            profileImageView.contentMode = .scaleAspectFit
//                    //
//                   // imageContainerView.backgroundColor = .brown
//                    imageContainerView.addSubview(imageLabel)
//                    //containerView.addSubview(profileImageView)
//                    imageContainerView.addSubview(profileImageView)
//                    cell.contentView.addSubview(imageContainerView)
//                    cell.selectionStyle = .none
//
            default:
                guard let cell = self.tblViewForVehicleDetailPage.dequeueReusableCell(withIdentifier: "dateId", for: indexPath) as? DateInputCell else {
                        fatalError("Dequeued cell is not an instance of CharacterDetailsTableViewCell class.")
                    }
                
                cell.imageButtonForDate.tag = (indexPath.section * 1000) + indexPath.row
                cell.imageButtonForDate.addTarget(self, action: #selector(showPickerPopup), for: .touchUpInside)
                cell.configCell(text: "\(data.displayTitle)", titleName: "\(data.displayTitle)", DateDict: dateDict, tag: (indexPath.section * 1000) + indexPath.row)
                return cell
                //return cell
//                containerView = UIView(frame: CGRect(x: 5, y: 5, width: Int(self.view.frame.width - 10), height: 44))
//
//                imageButton = UIButton(frame: CGRect(x:Int(containerView.frame.width - 140), y: 5, width: 140, height: 35))
//                //imageButton.backgroundColor = .yellow
//                imageButton.setTitle("Update", for: .normal)
//                imageButton.setTitleColor(.black, for: .normal)
//                imageButton.tag = (indexPath.section * 1000) + indexPath.row
//
//
//                nameLabel = UILabel(frame: CGRect(x:5, y: 5, width:200, height: 35))
//                nameLabel.backgroundColor = .clear
//                nameLabel.textColor = .black
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
       // }
           // return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if arrOfFields.count > 0 {
                print("selectpath \(indexPath.row) \(indexPath.section)")
                let data = arrOfFields[indexPath.section].fields[indexPath.row]
                if let fieldType:FieldType  = FieldType(rawValue: "\(data.fieldType)") {
                    switch fieldType {
                    case .text:
                        print("text")
                    case .options:
                        print("Options")
                    case .image:
                        self.showImagePicker(currentIndex: (indexPath.section * 1000) + indexPath.row)
                    default:
                        print("Date")
                    }
                }
            }
    }
    
    @objc func SubmitAction(_ sender:UIButton){
        print("Submit Button Pressed")
        print(arrOfSubReq)
        print(arrEvalSubData)
        for (index,value) in self.fieldElementDict.enumerated(){
            print("\(index)","----\(value.apiKey)")
            print(arrOfSubReq[index].valueFrom)
            if value.apiKey == arrOfSubReq[index].valueFrom{
                if let Newtitle = arrEvalSubData["\(value.apiKey)"] {
                    arrOfSubReq[index].selectedValue = Newtitle as! String
                }
            }
        }
        print(arrOfSubReq)
      //  print(arrOfSubReq)
    }
    
//        for var element in arrOfSubReq {
//            if arrEvalSubData.keys.contains("\(element.valueFrom)") {
//                if let Newtitle = arrEvalSubData["\(element.valueFrom)"] {
//                    element.selectedValue = ("\(Newtitle)")//appending(Newtitle as! String)
//                }
//                print(arrOfSubReq)
//            }
//        }
    
    
    @objc func buttonNewUpdatePressed(_ sender: UIButton){
        print("\(sender.tag)")
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        print("ButtonNewUpdatePressed Section \(section),Row \(row)")
        let data = arrOfFields[section].fields[row]
        if data.fieldDynamic == false && (data.staticValue != nil){
           buttonUpdatePressed(sender)
        }else if data.fieldDynamic == true && (data.dynamicValue != nil){
            listUpdatePressed(sender)
        }
    }
    
    @objc func buttonUpdatePressed(_ sender: UIButton){
        print("\(sender.tag)")
        var array:[String] = []
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        print("Section \(section),Row \(row)")
        let data = arrOfFields[section].fields[row]
        if let dict = data.staticValue{
            array = dict.value
            print(array)
        }
        
       if data.displayTitle == "Fuel Leakage"{
            
        }
        
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

           for title in array {
             let action = UIAlertAction(title: title, style: .default) { (action) in
               print("Title: \(title)")
                self.UpdateDict.updateValue(title, forKey:["\(section)":"\(row)"])
                self.arrEvalSubData.updateValue(title, forKey: self.arrOfFields[section].fields[row].apiKey)
              //  self.arrOfFields[section].fields[row].defaultValue = title
                self.tblViewForVehicleDetailPage.reloadData()
             }

//             let icon = UIImage.init(named: title.icon)

             //action.setValue(icon, forKey: "image")
             action.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

             actionSheetAlertController.addAction(action)
           }

           let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           actionSheetAlertController.addAction(cancelActionButton)
        
        if let presenter = actionSheetAlertController.popoverPresentationController {
                presenter.sourceView = sender
                presenter.sourceRect = sender.bounds
            }

        present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    @objc func listUpdatePressed(_ sender: UIButton){
        self.view.endEditing(true)
       
        print("Sender tag ..\(sender.tag)")
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        let indexPat = IndexPath.init(row: row, section: section)
        print("Section \(section),Row \(row)")
        let selectMMVData = arrOfFields[section].fields[row].dynamicValue?.requestValue.requestValueFor
        var dictOfData = [String:String]()
        if let dynamicValue = arrOfFields[section].fields[row].dynamicValue?.requestValueDynamic{
            
            for item in dynamicValue{
                for fieldItem in arrOfFields[section].fields {
                    if fieldItem.apiKey == item.tagid{
                        print(fieldItem.selectedValue)
                        dictOfData.updateValue(fieldItem.selectedValue, forKey: item.apiKey)
                    }
                //valueByElementId = item.apiKey
                   //
                    
                }
            }
            
            dictOfData.updateValue(selectMMVData!, forKey:"for")
        }else{
            dictOfData.updateValue(selectMMVData!, forKey:"for")
        }
        
        print(dictOfData)
       
        
        if !dictOfData.isEmpty{
            getCities(Model:arrOfFields[section].fields[row].dynamicValue!, requestData: dictOfData,IndexPath1: indexPat)
        }

    }
    
internal func getCities(Model:DynamicValue,requestData:JsonDictionay?,IndexPath1:IndexPath) {
        var apiKey = String()
        var type = String()
        var requestValue = String()
        var valueType = String()
        var api = String()
        
       
        
        for element in [Model] {
            apiKey = element.apiURL ?? ""
            type = element.type ?? ""
            requestValue = element.requestValue.requestValueFor
            valueType = element.valueType ?? ""
            api = element.apiURL
        }
        
        //DispatchQueue.main.async {
             KRProgressHUD.show()
        // }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData! as JsonDictionay)
        var request = URLRequest(url:URL(string: api)!)
        request.httpMethod = "POST"

        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
               // DispatchQueue.main.async {
                 
                 //}
                DispatchQueue.main.async {
                    KRProgressHUD.dismiss()
                    let newdropdownVC = newDropDownListVC.instantiate(fromStoryBoard: .Main)
                    newdropdownVC.list = responseJSON[requestValue] as! [String]
                    newdropdownVC.NewindexPath = IndexPath1
                    
                    newdropdownVC.addCompletionHandler { value,text,variantData,NewIndexPath in
                        
                        print(value,text,variantData,NewIndexPath)
                        
                        self.arrOfFields[NewIndexPath.section].fields[NewIndexPath.row].selectedValue.append(value)
                        self.labelDict.updateValue(value, forKey:["\(NewIndexPath.section)":"\(NewIndexPath.row)"])
                        self.arrEvalSubData.updateValue(value, forKey: self.arrOfFields[NewIndexPath.section].fields[NewIndexPath.row].apiKey)
                        self.tblViewForVehicleDetailPage.reloadData()
                    }
                    
                    
                    let navController = UINavigationController(rootViewController: newdropdownVC)
                    self.present(navController, animated: true, completion: nil)
                }
               
            }
        }
        task.resume()
    }
    
    
    @objc func valueChanged(_ textField: UITextField){
       
    }
    
    func getIndexPathFromView(_ sender : UIView) -> IndexPath? {
        let point = sender.convert(CGPoint.zero, to: self.tblViewForVehicleDetailPage)
        let indexPath = self.tblViewForVehicleDetailPage.indexPathForRow(at: point)
        return indexPath
    }
}

//MARK: - Select Date for reschedule
extension ViewController {
    // Adding Sortpopup to view
    @objc internal func showPickerPopup(_ sender: UIButton) {
        //print(sender.tag)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.pickerPopUpView.backgroundColor = UIColor(white: 0.1, alpha: 0.6)
                self.pickerPopUpView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
                //self.pickerPopUpView.initiateView(Val: sender.tag)
                self.pickerPopUpView.isHidden = false
            }
        }
    }
    internal func configPickerPopUp() {
        DispatchQueue.main.async {
            self.pickerPopUpView = self.pickerPopUpView.instanceViewFromNib() as! SelectDatePickerView
            self.pickerPopUpView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            self.view.addSubview(self.pickerPopUpView)
            self.pickerPopUpView.isHidden = true
            self.pickerPopUpView.doneBtn.addTarget(self, action: #selector(self.pickerDoneDidTapped(_:)), for: .touchUpInside)
            self.pickerPopUpView.cancelBtn.addTarget(self, action: #selector(self.hideDatePicker), for: .touchUpInside)
            
        }
    }
    
    @objc func pickerDoneDidTapped(_ sender: UIButton) {
        if let selecteddate = self.pickerPopUpView.valueLabel.text {
            self.hideDatePicker()
            print("Sender tag ..\(sender.tag)")
            let row = sender.tag % 1000
            let section = sender.tag / 1000
            //print("Section \(section),Row \(row)")
            self.dateDict.updateValue(selecteddate, forKey:["\(section)":"\(row)"])
            //self.arrOfFields[section].fields[row].defaultValue = selecteddate
            tblViewForVehicleDetailPage.reloadData()
            self.arrEvalSubData.updateValue(selecteddate, forKey: self.arrOfFields[section].fields[row].apiKey)
            //debugPrint("followupdate :\(selecteddate)-\(self.pickerPopUpView.tag)\n")
        }
    }
    
    @objc func hideDatePicker() {
        UIView.animate(withDuration: 0.2) {
            DispatchQueue.main.async {
                self.pickerPopUpView.isHidden = true
            }
        }
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePicker(currentIndex:Int) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.view.tag = currentIndex
               
        let alert = UIAlertController(title: "Choose Image", message: "", preferredStyle: .alert)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style:.default, handler: {(action:UIAlertAction!) -> Void in
                picker.sourceType = .camera
                picker.showsCameraControls = true
                DispatchQueue.main.async {
                    self.present(picker, animated: true, completion: nil)
                }
            }))
        }
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction!) -> Void in
            picker.sourceType = .photoLibrary
            if UIDevice.current.userInterfaceIdiom == .pad {
                    picker.allowsEditing = false
                } else {
                    picker.allowsEditing = true
                }
            DispatchQueue.main.async {
                self.present(picker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action:UIAlertAction!) -> Void in
            alert.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imageDict.removeValue(forKey: "\(picker.view.tag)")
        var newImage: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
         } else {
            return
        }
      
        let row = picker.view.tag % 1000
        let section = picker.view.tag / 1000
//            dictOfImage.updateValue(newImage, forKey: arrOfFields[section].fields[row].displayTitle)
        print(row,section)
        
//            awsS3InfoModel.configS3BucketForImageUpload(s3Image: newImage, imageName:arrOfFields[section].fields[row].displayTitle) { (imageUrl,imageName)  in
//                print("ImageUrl  ..\(imageUrl)\(imageName)")
//            }
        
        imageDict.updateValue(newImage, forKey: "\(row)")
        tblViewForVehicleDetailPage.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        let row = textField.tag % 1000
        let section = textField.tag / 1000
        //print("Section \(section),Row \(row)")
            let fieldType = arrOfFields[section].fields[row].fieldType
            print(fieldType)
            if fieldType.rawValue == "text"{
                if arrOfFields.count > 0 {
                    self.txtFieldDict.updateValue(textField.text ?? "", forKey:["\(section)":"\(row)"])
                   
                arrEvalSubData.updateValue(textField.text ?? "", forKey: arrOfFields[section].fields[row].apiKey)
                self.tblViewForVehicleDetailPage.reloadData()
                    
//                        if "\(arrOfFields[section].fields[row].displayTitle)" == "Name"{
//
//                                print("\(String(describing: textField.text))")
//                            }else if "\(arrOfFields[section].fields[row].displayTitle)" == "Mobile Number"{
//                                self.txtFieldDict.updateValue(textField.text ?? "", forKey:["\(section)":"\(row)"])
//                                arrEvalSubData.updateValue(textField.text ?? "", forKey: arrOfFields[section].fields[row].apiKey)
////                                arrOfFields[section].fields[row].defaultValue = textField.text ?? ""
//                                print("\(String(describing: textField.text))")
//                            }else if "\(arrOfFields[section].fields[row].displayTitle)" == "Registration Number"{
//                                self.txtFieldDict.updateValue(textField.text ?? "", forKey:["\(section)":"\(row)"])
//                                arrEvalSubData.updateValue(textField.text ?? "", forKey: arrOfFields[section].fields[row].apiKey)
////                                arrOfFields[section].fields[row].defaultValue = textField.text ?? ""
//                                print("\(String(describing: textField.text))")
//                            }else if "\(arrOfFields[section].fields[row].displayTitle)" == "Email Address"{
//                                self.txtFieldDict.updateValue(textField.text ?? "", forKey:["\(section)":"\(row)"])
//                                arrEvalSubData.updateValue(textField.text ?? "", forKey: arrOfFields[section].fields[row].apiKey)
//                                print("\(String(describing: textField.text))")
//                            }
                }
            }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let row = textField.tag % 1000
        let section = textField.tag / 1000
        ////print("Section \(section),Row \(row)")
        let fieldType = arrOfFields[section].fields[row].fieldType
            print(fieldType)
        if arrOfFields.count > 0 {
            if fieldType.rawValue == "text"{
                if "\(arrOfFields[section].fields[row].displayTitle)" == "Customer Name"{
                    return true
                }else if "\(arrOfFields[section].fields[row].displayTitle)" == "Mobile Number"{
                    return range.location <= 10
                }else if "\(arrOfFields[section].fields[row].displayTitle)" == "Registration Number"{
                    return range.location <= 12
                }
            }
          }
        
           return true
    }
}
extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}
