//
//  ContactUsVc.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 01/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit
import MessageUI


class ContactUsVc: InstaPrayerBaseVc, MFMailComposeViewControllerDelegate ,UITextViewDelegate{

    @IBOutlet weak var tvContactUS: UITextView!
    @IBOutlet weak var btnMail: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Contact Us"
     
        self.btnMail.titleLabel?.adjustsFontSizeToFitWidth = true
        self.btnMail.titleLabel?.minimumScaleFactor = 0.2
        tvContactUS.delegate = self
   
    }

    override func viewDidLayoutSubviews() {
        tvContactUS.setContentOffset(CGPoint.zero, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
    }
  
    
    @IBAction func didClickSendMail(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["westernwallfoundation@gmail.com"])
      
      
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
       
       
        AppUtils.ShowAlertView("Could Not Send Email", bodyKey: "Your device could not send e-mail.  Please check e-mail configuration and try again.", buttonKey: "OK")
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
