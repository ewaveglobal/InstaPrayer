//
//  RequestBuilder.swift
//  prayerPilot
//
//  Created by Aviram Shakiv on 30/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit

class RequestBuilder: NSObject {
  
        fileprivate struct StringsForSevice{
        static let sandprayer : String = "api/InstantPrayer/CreateRequest";
        static let getPricings : String = "api/InstantPrayer/GetPricings";
            
    
        }
        fileprivate struct ServicePath
        {
            
            //Test
          static let Base : String = "http://prayersws.ewavetest.co.il/";
            
            //prod
//            static let Base : String = "http://ws.instaprayer.co/";
         
        }
        class func PrayerRequset() -> String{
            
            return  ServicePath.Base + StringsForSevice.sandprayer
        }

    class func GetPricings() -> String{
        
        return  ServicePath.Base + StringsForSevice.getPricings
    }
}
