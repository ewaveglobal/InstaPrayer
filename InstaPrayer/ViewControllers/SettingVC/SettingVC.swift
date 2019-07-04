//
//  SettingVC.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 05/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class SettingVC: InstaPrayerBaseVc {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didClickTerms(_ sender: AnyObject) {
        let terms : TermsVC = TermsVC(nibName: "TermsVC", bundle: nil)
        self.navigationController?.pushViewController(terms, animated: true)
    }
    @IBAction func didClickContactUs(_ sender: AnyObject) {
        let contact : ContactUsVc = ContactUsVc(nibName: "ContactUsVc", bundle: nil)
        self.navigationController?.pushViewController(contact, animated: true)
    }
}
