//
//  MainVc.swift
//  prayerPilot
//
//  Created by Aviram Shakiv on 30/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class MainVc: InstaPrayerBaseVc,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
let imagePicker = UIImagePickerController()
     @IBOutlet var imageView: UIImageView? = UIImageView()

    @IBOutlet weak var cameraHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnSettingHeight: NSLayoutConstraint!
    @IBOutlet weak var homeHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    var isCamera : Bool = false
    @IBOutlet weak var mainTextView: UIView!
    
    @IBOutlet weak var btnHome: UIButton!

    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    
  
    @IBOutlet weak var ivHome: UIImageView!
    @IBOutlet weak var ivCamera: UIImageView!
    @IBOutlet weak var ivSettings: UIImageView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
          }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
   
        if self.containerView.isHidden {
        self.ivHome.image = UIImage(named:"house_on.png" )
    
        self.ivSettings.image = UIImage(named:"setting.png" )
        }
        else {
            self.ivHome.image = UIImage(named:"house.png" )
            
            self.ivSettings.image = UIImage(named:"setting_on.png" )
        }
         self.ivCamera.image = UIImage(named:"camera.png" )
    }
  
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    @IBAction func didClickTakePic(_ sender: AnyObject) {
     
        self.ivHome.image = UIImage(named:"house.png" )
        self.ivCamera.image = UIImage(named:"camera_on.png" )
        self.ivSettings.image = UIImage(named:"setting.png" )
      
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action:UIAlertAction!) in
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
        alertController.addAction(cameraAction)
        
        let OKAction = UIAlertAction(title: "Photo Library", style: .default) { (action:UIAlertAction!) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
             self.isCamera = false
              self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
      
        self.present(alertController, animated: true, completion:nil)
//
        
 
     
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
          
              self.imageView!.image = pickedImage
            if self.isCamera {
                UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
            }
          
        }
        
        DispatchQueue.main.async(execute: {
          
            let details : DetailesVc = DetailesVc(pic: self.imageView!.image!)
            self.navigationController?.pushViewController(details, animated: true)
             self.dismiss(animated: true, completion: nil)
        })
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func didClickHome(_ sender: AnyObject) {
        self.containerView.isHidden = true
        self.mainTextView.isHidden = false
           self.ivHome.image = UIImage(named:"house_on.png" )
          self.ivCamera.image = UIImage(named:"camera.png" )
        self.ivSettings.image = UIImage(named:"setting.png" )

    }

  
    @IBAction func didClickSettings(_ sender: AnyObject) {
        let setting : SettingVC = SettingVC(nibName: "SettingVC", bundle: nil)
         self.containerView.isHidden = false
           self.mainTextView.isHidden = true
        configureChildViewController(setting, onView: self.containerView)
       self.ivHome.image = UIImage(named:"house.png" )
        self.ivCamera.image = UIImage(named:"camera.png" )
          self.ivSettings.image = UIImage(named:"setting_on.png" )

    }
    
    
}
