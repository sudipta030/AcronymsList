//
//  ViewController.swift
//
//  Created by Sudipta on 29/09/21.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var tblAcronymsList: UITableView!
    @IBOutlet weak var txtAcronyms: UITextField!
    private let viewmodel = AcronymsViewModel()
   private let acronymslistmodel = acronymslistviewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        acronymslistmodel.acronymslist.bind { [weak self] _ in
            // reload the table
            DispatchQueue.main.async {
                self?.tblAcronymsList.reloadData()
            }
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        txtAcronyms?.resignFirstResponder()
        if viewmodel.stringValidation(str: txtAcronyms?.text) {
            self.apiCall(strAcromine: txtAcronyms.text!)
        }
        else {
        
            self.showalert(message: "Text should not be empty.")
            
              }
        }
     // api call
    func apiCall(strAcromine: String) {
        viewmodel.getdatafromserver(key: strAcromine) { (acronymslist: [AcronymsList]?,message: String) in
                  if message == "data found"
                  {
                    if acronymslist!.count > 0 {
                    self.acronymslistmodel.acronymslist.value = acronymslist?[0].lfs.compactMap({Acronymslistcellviewmodel(lf: $0.lf ?? "")})
                    }
                  }
                    else
                  {
                    self.showalert(message: message)
                  }
        
                }
    }
    
    // alertview controller
    func showalert(message: String) {
        let alert = UIAlertController(title: "AcromineListFind", message: message, preferredStyle: .alert)

              // add an action (button)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

              // show the alert
              self.present(alert, animated: true, completion: nil)
    }
    // textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
}
// tableview datasource
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acronymslistmodel.acronymslist.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = acronymslistmodel.acronymslist.value?[indexPath.row].lf
        return cell
    }
}
