//
//  newDropDownListVC.swift
//  AudiAutoInspekt
//
//  Created by MacBook Pro on 01/10/21.
//

import UIKit

class newDropDownListVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchFooter: SearchFooter!
    var searchActive = false
    var selectedVar:String!
    var list = [String]()
    var filteredlist = [String]()
    var idlist = [String]()
    var NewindexPath:IndexPath = []
    var model = [DynamicValue]()
    var completionHandler:((String,String,String,IndexPath) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
        self.tableView.reloadData()
        }
        self.tableView.tableFooterView = UIView()
        addNavigationBarItem()
        
    }
    private func addNavigationBarItem() {
        navigationController?.navigationBar.barTintColor = .orange
//            UIColor(red: 14.0/255.0, green: 40.0/255.0, blue: 80.0/255.0, alpha: 1.0)
           //BACK Button
           let backButton = UIBarButtonItem(image: UIImage(named:"back.png"), style: .plain, target: self, action:#selector(cancelClicked(sender:)))
           navigationItem.leftBarButtonItem = backButton
           // Cancel Button
           let cancelItem = UIBarButtonItem(image: UIImage(named: "cancel.png"), style: .done, target: self, action: #selector(cancelClicked(sender:)))
           self.navigationItem.rightBarButtonItem = cancelItem
     }
    
    @objc func cancelClicked(sender:UIBarButtonItem) {
        self.completionHandler = nil
        dismiss(animated: true, completion: nil)
    }
    
    func addCompletionHandler(block:@escaping ((String,String,String,IndexPath) -> Void)) {
           self.completionHandler = block
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Table View
extension newDropDownListVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive == true {
            return filteredlist.count
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        if searchActive {
            cell.textLabel!.text = filteredlist[indexPath.row]
        } else {
            cell.textLabel!.text = list[indexPath.row]
        }
//        cell.textLabel?.font = UIFont(name: medium, size: 15.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedValue = ""
        if searchActive {
            selectedValue = filteredlist[indexPath.row]
        } else {
            selectedValue = list[indexPath.row]
        }
        if idlist.count != 0 {
            selectedVar =  idlist[indexPath.row]
        }
        self.dismiss(animated: true) { [weak self] in
            self?.completionHandler!(selectedValue, "\(indexPath.row+1)", self?.selectedVar ?? "", self?.NewindexPath ?? [])
        }
        print("Selectd value ..\(selectedValue) \(indexPath.row+1) \(selectedVar)")
    }
}
