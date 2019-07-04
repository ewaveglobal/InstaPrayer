//
//  WebServices.swift
//  prayerPilot
//
//  Created by Aviram Shakiv on 30/08/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit


class WebServices: NSObject {
     static let sharedInstance : WebServices = WebServices();
    func createPostRequest(_ url:URL,params:NSDictionary) -> URLRequest
    {
        let request:NSMutableURLRequest  = NSMutableURLRequest(url: url);
        let jsonData:Data = try! JSONSerialization.data(withJSONObject: params, options: []);
        request.httpMethod = "post";
        request.httpBody = jsonData;
        request.timeoutInterval = 30
        print("url : \(url) \(params)")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request as URLRequest;
        
    }
    func createGetRequest(_ url:URL) -> URLRequest
    {
        let request:NSMutableURLRequest  = NSMutableURLRequest(url: url);
        request.httpMethod = "get";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("url : \(url)")
        
        return request as URLRequest;
        
    }
    func sendPrayerRequset  ( _ prayerRequst : PrayerObj, responseSuccess :@escaping (_ Sucsses : BaseRespone) -> Void ,Error :@escaping (_ Error : NSError?) ->Void){
        let mappingBase  :RKObjectMapping = RKObjectMapping(for: BaseRespone.self)
        mappingBase.addAttributeMappings(from: BaseRespone.getBaseParams() as [AnyHashable: Any])
        let responseDescription : RKResponseDescriptor = RKResponseDescriptor(mapping: mappingBase, method: RKRequestMethod.POST, pathPattern: nil, keyPath: nil, statusCodes: nil)
        
        let url : URL = URL(string: RequestBuilder.PrayerRequset())!
        let params : NSDictionary = ["firstName":prayerRequst.firstName,"lestName":prayerRequst.lestName,"email":prayerRequst.email,"ImgBase64":prayerRequst.ImgBase64,"confirmation":prayerRequst.confirmation,"fastDelevery" : prayerRequst.fastDelevery,"IsPublishAllowed" : prayerRequst.IsPublishAllowed];
        let operation : RKObjectRequestOperation = RKObjectRequestOperation(request: self.createPostRequest(url, params: params), responseDescriptors: [responseDescription])
        
        
        operation.setCompletionBlockWithSuccess({ (operation : RKObjectRequestOperation?,mapping : RKMappingResult?) -> Void in
            
            let baseRespone : BaseRespone = mapping!.firstObject as! BaseRespone
            
            
            responseSuccess(baseRespone)
        }) { (operation : RKObjectRequestOperation?,error : Error?) -> Void in
            Error(error as NSError?)
        }
        operation.start()
        
        
    }
    func getPricing  (  _ responseSuccess :@escaping (_ Sucsses : BaseRespone) -> Void ,Error :@escaping (_ Error : NSError?) ->Void){
        let mappingBase  :RKObjectMapping = RKObjectMapping(for: BaseRespone.self)
        mappingBase.addAttributeMappings(from: BaseRespone.getBaseParams() as [AnyHashable: Any])

        let mappingPricing  :RKObjectMapping = RKObjectMapping(for: PricingRespone.self)
        mappingPricing.addAttributeMappings(from: PricingRespone.getParams() as [AnyHashable: Any])
        mappingBase.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "content", toKeyPath: "content", with: mappingPricing))
        let responseDescription : RKResponseDescriptor = RKResponseDescriptor(mapping: mappingBase, method: RKRequestMethod.GET, pathPattern: nil, keyPath: nil, statusCodes: nil)
        
        let url : URL = URL(string: RequestBuilder.GetPricings())!
        
        let operation : RKObjectRequestOperation = RKObjectRequestOperation(request:self.createGetRequest(url), responseDescriptors: [responseDescription])
        
        
        operation.setCompletionBlockWithSuccess({ (operation : RKObjectRequestOperation?,mapping : RKMappingResult?) -> Void in
            
            let baseRespone : BaseRespone = mapping!.firstObject as! BaseRespone
            
            
            responseSuccess(baseRespone)
        }) { (operation : RKObjectRequestOperation?,error : Error?) -> Void in
            Error(error as NSError?)
        }
        operation.start()
        
        
    }

}
