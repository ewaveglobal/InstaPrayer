//
//  BaseRespone.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 01/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class BaseRespone: NSObject {
    var Success : NSNumber?
    var ErrorCode : NSNumber?
    var ErrorMessage : String?
    var content : PricingRespone?
   
    static func getBaseParams() -> Dictionary<String, String> {
        return ["errorCode":"ErrorCode","errorMessage":"ErrorMessage","success" : "Success"];
    }


}
