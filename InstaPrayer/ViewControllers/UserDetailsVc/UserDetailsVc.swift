//
//  UserDetailsVc.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 31/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
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



class UserDetailsVc: InstaPrayerBaseVc,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet var imageView: UIImageView? = UIImageView()
    @IBOutlet weak var ivPrayerImage: UIImageView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lblApprove: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var ivLastNameChack: UIImageView!
    @IBOutlet weak var ivEmailCheck: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    var  pricing : BaseRespone?
    var isCamera : Bool = false
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
 
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var ivFirstNameCheck: UIImageView!
    
    var Prayer : PrayerObj = PrayerObj()
    
    var pic : UIImage?
    init(pic:UIImage)
    {
        super.init( nibName: "UserDetailsVc", bundle: nil)
        
        self.pic = pic
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
       self.scrollView.delegate = self
       self.scrollView.contentSize  = CGSize(width: self.scrollView.contentSize.width, height:0)
        
        
        self.title = "Your Information"
        self.ivPrayerImage.clipsToBounds = true
        self.ivPrayerImage.image = self.pic
        self.tfEmail.attributedPlaceholder = AppUtils.addTextFeildAttributes("Email", langht: 5)
        self.tfFirstName.attributedPlaceholder = AppUtils.addTextFeildAttributes("First name", langht: 10)
        self.tfLastName.attributedPlaceholder = AppUtils.addTextFeildAttributes("Last name", langht: 9)
        self.tfEmail.delegate = self
        self.tfFirstName.delegate = self
        self.tfLastName.delegate = self
        self.tfEmail.autocapitalizationType = .sentences
        self.tfFirstName.autocapitalizationType = .sentences
        self.tfLastName.autocapitalizationType = .sentences
        self.addToolBar(self.tfFirstName)
        self.addToolBar(self.tfEmail)
         self.addToolBar(self.tfLastName)
    }
    
    
    
    
    func animateTextField(_ textField: UITextField, up: Bool)
    {
        let movementDistance:CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    @IBAction func didClickChangeImage(_ sender: AnyObject) {
        
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
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView!.contentMode = .scaleAspectFit
            self.imageView!.image = pickedImage
            if self.isCamera {
             UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
            }
            
        }
        dismiss(animated: true, completion: nil)
        DispatchQueue.main.async(execute: {
            self.ivPrayerImage.image = self.imageView?.image!
        })
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DidClickContinue(_ sender: AnyObject) {
        if self.tfFirstName.text!.characters.count < 2 {
            AppUtils.ShowAlertView("", bodyKey: "Please Enter First Name", buttonKey: "Ok")
            return
        }
        else if self.tfLastName.text!.characters.count < 2 {
            AppUtils.ShowAlertView("", bodyKey: "Please Enter Last Name", buttonKey: "Ok")
            return
        }
        else if self.tfEmail.text == ""  {
            AppUtils.ShowAlertView("", bodyKey: "Please Enter Your Email Address", buttonKey: "Ok")
            return
        }
        else if !AppUtils.isValidEmail(self.tfEmail.text!){
            AppUtils.ShowAlertView("", bodyKey: "The Email You Entered Is Invalid", buttonKey: "Ok")
            return
        }
        else if self.btnCheckBox.isSelected == false {
            AppUtils.ShowAlertView("", bodyKey: "Please agree to the terms and conditions", buttonKey: "Ok")
            return
            
        }
        getPricing()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.isScrollEnabled = true
          self.scrollViewHeight.constant = 200
    scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y + textField.frame.size.height), animated: false)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.tfFirstName {
            textField.resignFirstResponder()
            tfLastName.becomeFirstResponder()
            
        }
        else if textField == self.tfLastName{
            textField.resignFirstResponder()
            tfEmail.becomeFirstResponder()
        }
        else {
              textField.resignFirstResponder()
            self.scrollView.isScrollEnabled = false
            self.scrollViewHeight.constant = 0
            
        }
       
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

        switch textField.tag {
        case 0:
             
            if textField.text?.characters.count > 1{
             
                self.ivFirstNameCheck.image = UIImage(named: "v_green.png")
            }
            else {
                self.ivFirstNameCheck.image = UIImage(named: "v_red.png")
            }
        case 1:
              
            if textField.text?.characters.count > 1{
                self.ivLastNameChack.image = UIImage(named: "v_green.png")
            }
            else {
                self.ivLastNameChack.image = UIImage(named: "v_red.png")
            }
        case 2:
           
            if AppUtils.isValidEmail(textField.text!){
                self.ivEmailCheck.image = UIImage(named: "v_green.png")
            }
            else {
                self.ivEmailCheck.image = UIImage(named: "v_red.png")
            }
             scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
              self.scrollViewHeight.constant = 0
        default:
            break;
        }
        
    }
    @IBAction func didClickTerms(_ sender: AnyObject) {
        let term : TermsVC = TermsVC(nibName: "TermsVC", bundle: nil)
        self.navigationController?.pushViewController(term, animated: true)
    }
    
    @IBAction func didClickAgree(_ sender: AnyObject) {
        if self.btnCheckBox.isSelected == true {
            self.btnCheckBox.isSelected = false
            self.btnCheckBox.setImage(UIImage(named: "checkbox.png"), for: UIControlState())
        }
        else {
            self.btnCheckBox.isSelected = true
            self.btnCheckBox.setImage(UIImage(named: "checkbox_on.png"), for: UIControlState())
        }
    }
    func getPricing() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServices.sharedInstance.getPricing({ (Sucsses) in
            if Sucsses.Success == true {
                self.pricing = Sucsses
                
                
                DispatchQueue.main.async(execute: {
                    
                    self.Prayer.firstName = self.tfFirstName.text!
                    self.Prayer.lestName = self.tfLastName.text!
                    self.Prayer.email = self.tfEmail.text!
                    self.Prayer.UserImg = self.ivPrayerImage.image!
                    let imageData:Data = UIImagePNGRepresentation(self.ivPrayerImage.image!)!
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
   
}
