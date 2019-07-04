//
//  ThankYouVC.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 01/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class ThankYouVC: UIViewController {
    var Prayer : PrayerObj = PrayerObj()
    
    @IBOutlet weak var lblThankYou: UILabel!
    init(Prayer : PrayerObj)
    {
        super.init( nibName: "ThankYouVC", bundle: nil)
        
        self.Prayer = Prayer
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      
self.lblThankYou.text = NSLocalizedString("thank_you", comment: "")
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = true
    }

   

    @IBAction func didClickShare(_ sender: AnyObject) {
        let image : UIImage = self.Prayer.UserImg!
        let textToShare = ""
      
            let objectsToShare : [AnyObject] = [textToShare as AnyObject,image]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
    }

    @IBAction func didClickFinish(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
