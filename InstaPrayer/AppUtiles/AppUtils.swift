//
//  AppUtils.swift
//  prayerPilot
//
//  Created by Aviram Shakiv on 30/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class AppUtils: NSObject {
    class func registerCellToTable(_ cellName : String,tableView : UITableView) {
        
        let nibName = UINib(nibName: cellName, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellName)
        
    }
    class func registerCellToCollection(_ cellName : String, collectionView : UICollectionView)
    {
        let nibName = UINib(nibName: cellName, bundle: nil)
        //        collectionView.registerClass(NSClassFromString(cellName), forCellWithReuseIdentifier: cellName)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellName)
    }
    class func isValidEmail(_ email:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    class func addTextFeildAttributes(_ text : String , langht : Int )-> NSMutableAttributedString{
        var myMutableStringTitle = NSMutableAttributedString()
        let text  = text
        myMutableStringTitle = NSMutableAttributedString(string:text, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 17)]) // Font
        myMutableStringTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range:NSRange(location:0,length:langht))    // Color
        return myMutableStringTitle
        
    }
    class func ShowAlertView( _ titleKey :String,  bodyKey :String ,  buttonKey : String){
        let alert = UIAlertView()
        alert.title = NSLocalizedString(titleKey, comment: "")
        alert.message = NSLocalizedString(bodyKey, comment: "")
        alert.addButton(withTitle: NSLocalizedString(buttonKey, comment: ""))
        alert.delegate = self
        alert.show()
        
    }
}
