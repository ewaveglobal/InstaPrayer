//
//  DetailesVc.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 26/03/2017.
//  Copyright © 2017 Aviram Shakiv. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class DetailesVc: InstaPrayerBaseVc,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
      let imagePicker = UIImagePickerController()
    @IBOutlet weak var tblDetails: UITableView!
  
  
    var  pricing : BaseRespone?
    var Prayer : PrayerObj = PrayerObj()
    var isCamera : Bool = false
    var firstName : String = ""
     var lastName : String = ""
     var email : String = ""
    var pic : UIImage?
    init(pic:UIImage)
    {
        super.init( nibName: "DetailesVc", bundle: nil)
        
        self.pic = pic
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
       AppUtils.registerCellToTable("ImageCell", tableView: tblDetails)
        AppUtils.registerCellToTable("TableViewCell", tableView: tblDetails)
         AppUtils.registerCellToTable("checkboxCell", tableView: tblDetails)
       self.tblDetails.tableFooterView = UIView()
          self.title = "Your Information"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row == 0 {
            let cell : ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.ivImage.image = self.pic
            cell.btnEdit.addTarget(self, action: #selector(self.didClickEdit), for: .touchUpInside)
            return cell
        }
     
        else if indexPath.row != 4 {
             let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.tfDetails.delegate = self
            cell.tfDetails.tag = indexPath.row - 1
           
            switch indexPath.row {
            case 1:
             
                cell.tfDetails.attributedPlaceholder = AppUtils.addTextFeildAttributes("First name", langht: 10)
               cell.tfDetails.returnKeyType = .next
                   cell.tfDetails.autocapitalizationType = .sentences
                break
            case 2:
                 cell.tfDetails.attributedPlaceholder = AppUtils.addTextFeildAttributes("Last name", langht: 9)
                    cell.tfDetails.returnKeyType = .next
                    cell.tfDetails.autocapitalizationType = .sentences
                break
            case 3:
                   cell.tfDetails.attributedPlaceholder = AppUtils.addTextFeildAttributes("Email", langht: 5)
                   cell.tfDetails.keyboardType = .emailAddress
                      cell.tfDetails.returnKeyType = .go
                      cell.tfDetails.autocapitalizationType = .none
                break
            default:
                break
            }
            return cell
        }
        else
        {
            let cell : checkboxCell = tableView.dequeueReusableCell(withIdentifier: "checkboxCell", for: indexPath) as! checkboxCell
            cell.btnContinue.addTarget(self, action: #selector(self.DidClickContinue), for: .touchUpInside)
            cell.btnCheckbox.addTarget(self, action: #selector(self.didClickAgree), for: .touchUpInside)
            cell.btnTerms.addTarget(self, action: #selector(self.didClickTerms), for: .touchUpInside)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.size.height/2.2
        }
        else if indexPath.row == 4 {
            return 150
        }
        return 50
    }
    func didClickEdit(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        let cancelAction = UIAlertAction(title: "Camera", style: .default) { (action:UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = .camera
                self.isCamera = true
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else {
                AppUtils.ShowAlertView("", bodyKey: "Device camera Isn't available", buttonKey: "Ok")
            }
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Photo Library", style: .default) { (action:UIAlertAction!) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.isCamera = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let cell : ImageCell = self.tblDetails.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageCell
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cell.ivImage.contentMode = .scaleAspectFit
            cell.ivImage.image = pickedImage
            if self.isCamera {
                UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
            }
            
        }
        dismiss(animated: true, completion: nil)
        DispatchQueue.main.async(execute: {
         
        })
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func DidClickContinue(_ sender: AnyObject) {
        let firstNameCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 1, section: 0)) as! TableViewCell
        let lastNameCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 2, section: 0)) as! TableViewCell
        let emailCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 3, section: 0)) as! TableViewCell
        firstNameCell.tfDetails.resignFirstResponder()
        lastNameCell.tfDetails.resignFirstResponder()
        emailCell.tfDetails.resignFirstResponder()
          let cell : checkboxCell = self.tblDetails.cellForRow(at: IndexPath(row: 4, section: 0)) as! checkboxCell
        if self.firstName.characters.count < 2 {
            AppUtils.ShowAlertView("", bodyKey: "Please Enter First Name", buttonKey: "Ok")
            return
        }
        else if self.lastName.characters.count < 2 {
            AppUtils.ShowAlertView("", bodyKey: "Please Enter Last Name", buttonKey: "Ok")
            return
        }
        else if self.email == ""  {
            AppUtils.ShowAlertView("", bodyKey: "Please Enter Your Email Address", buttonKey: "Ok")
            return
        }
        else if !AppUtils.isValidEmail(self.email){
            AppUtils.ShowAlertView("", bodyKey: "The Email You Entered Is Invalid", buttonKey: "Ok")
            return
        }
        else if cell.btnCheckbox.isSelected == false {
            AppUtils.ShowAlertView("", bodyKey: "Please Agree To The Terms and Conditions", buttonKey: "Ok")
            return
            
        }
        getPricing()
    }
    func getPricing() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServices.sharedInstance.getPricing({ (Sucsses) in
            if Sucsses.Success == true {
                self.pricing = Sucsses
                
                
                DispatchQueue.main.async(execute: {
                      let cell : ImageCell = self.tblDetails.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageCell
                    self.Prayer.firstName = self.firstName
                    self.Prayer.lestName = self.lastName
                    self.Prayer.email = self.email
                    self.Prayer.UserImg = cell.ivImage.image
                    let imageData:Data = UIImagePNGRepresentation(cell.ivImage.image!)!
                    let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
                    
                    self.Prayer.ImgBase64 = strBase64
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let choosePlan : ChoosePlanVc = ChoosePlanVc(Prayer: self.Prayer , pricing:  self.pricing!)
                    self.navigationController?.pushViewController(choosePlan, animated: true)
                })
            }
            
        }) { (Error) in
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
        }
    }
 func didClickTerms() {
 
        let term : TermsVC = TermsVC(nibName: "TermsVC", bundle: nil)
        self.navigationController?.pushViewController(term, animated: true)
    }
    
    func didClickAgree() {
           let cell : checkboxCell = self.tblDetails.cellForRow(at: IndexPath(row: 4, section: 0)) as! checkboxCell
        if cell.btnCheckbox.isSelected == true {
            cell.btnCheckbox.isSelected = false
            cell.btnCheckbox.setImage(UIImage(named: "checkbox.png"), for: UIControlState())
        }
        else {
            cell.btnCheckbox.isSelected = true
             cell.btnCheckbox.setImage(UIImage(named: "checkbox_on.png"), for: UIControlState())
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
 
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.textAlignment = .left
          let lastNameCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 2, section: 0)) as! TableViewCell
          let emailCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 3, section: 0)) as! TableViewCell
        if textField.tag == 0 {
            textField.resignFirstResponder()
            lastNameCell.tfDetails.becomeFirstResponder()
            
        }
        else if textField.tag == 1{
            textField.resignFirstResponder()
            emailCell.tfDetails.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        
            
        }
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let firstNameCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 1, section: 0)) as! TableViewCell
        let lastNameCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 2, section: 0)) as! TableViewCell
        let emailCell : TableViewCell = self.tblDetails.cellForRow(at: IndexPath(row: 3, section: 0)) as! TableViewCell
        switch textField.tag {
        case 0:
            self.firstName = textField.text!
            if textField.text?.characters.count > 1{
                
               firstNameCell.ivCheck.image = UIImage(named: "v_green.png")
            }
            else {
                 firstNameCell.ivCheck.image = UIImage(named: "v_red.png")
            }
        case 1:
             self.lastName = textField.text!
            if textField.text?.characters.count > 1{
                lastNameCell.ivCheck.image = UIImage(named: "v_green.png")
            }
            else {
                 lastNameCell.ivCheck.image = UIImage(named: "v_red.png")
            }
        case 2:
             self.email = textField.text!
            if AppUtils.isValidEmail(textField.text!){
               emailCell.ivCheck.image = UIImage(named: "v_green.png")
            }
            else {
                emailCell.ivCheck.image = UIImage(named: "v_red.png")
            }
            
        default:
            break;
        }
        
    }

    
}
