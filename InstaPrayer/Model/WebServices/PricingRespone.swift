//
//  PricingRespone.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 18/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class PricingRespone: NSObject {
    var prayerTitle : String = ""
    var prayerDescription : String = ""
    var prayerPrice : NSNumber?
    var confirmationTitle : String = ""
    var confirmationDescription : String = ""
    var confirmationPrice : NSNumber?
    var sameDayTitle : String = ""
    var sameDayDescription : String = ""
    var sameDayPrice : NSNumber?
    static func getParams() -> Dictionary<String, String> {
        return ["prayerTitle":"prayerTitle","prayerDescription":"prayerDescription","prayerPrice" : "prayerPrice","confirmationTitle":"confirmationTitle","confirmationDescription" : "confirmationDescription","confirmationPrice":"confirmationPrice","sameDayTitle" : "sameDayTitle","sameDayDescription" : "sameDayDescription","sameDayPrice":"sameDayPrice"];
    }

}
