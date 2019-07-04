//
//  TermsVC.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 01/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class TermsVC: InstaPrayerBaseVc ,UITextViewDelegate{

    @IBOutlet weak var tvTerms: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvTerms.delegate = self
      
       self.title = "Terms & Conditions"
    }
    override func viewDidLayoutSubviews() {
         tvTerms.setContentOffset(CGPoint.zero, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
