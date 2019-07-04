//
//  InstaPrayerBaseVc.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 31/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class InstaPrayerBaseVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.AddNavigationBar()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func AddNavigationBar () -> Void {
        
        
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
      
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.black
      self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 20)!]
  
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    
      

      
        
    }

}
