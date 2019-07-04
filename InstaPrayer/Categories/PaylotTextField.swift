//
//  PaylotTextField.swift
//  prayerPilot
//
//  Created by Aviram Shakiv on 30/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class PaylotTextField: UITextField {

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
   
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y + 8, width: bounds.size.width - 20, height: bounds.size.height - 16);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds);
    }
 

}
