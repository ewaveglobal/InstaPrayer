//
//  ChoosePlanVc.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 01/09/2016.
//  Copyright © 2016 Aviram Shakiv. All rights reserved.
//

import UIKit
import PassKit

class ChoosePlanVc: InstaPrayerBaseVc, PayPalPaymentDelegate, PayPalFuturePaymentDelegate , PayPalProfileSharingDelegate{
    var Prayer : PrayerObj = PrayerObj()
    let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
    let ApplePaySwagMerchantID = "merchant.WesternWallFoundation"
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var titleTop: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmationTitle: UILabel!
  
    @IBOutlet weak var btnApplePay: UIButton!
    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var btnConfirmationTop: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmationPrice: UILabel!
    @IBOutlet weak var lblConfirmationDesc: UILabel!
    @IBOutlet weak var lblDeliveryTitle: UILabel!
    @IBOutlet weak var lblDeleveyPrice: UILabel!
    @IBOutlet weak var lblDeleveryDesc: UILabel!
    @IBOutlet weak var btnPublish: UIButton!
   
    var pricing : BaseRespone?
    @IBOutlet weak var btnPay: UIButton!
    var environment:String = PayPalEnvironmentProduction{
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
 

    @IBOutlet weak var lblTotal: UILabel!
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration()
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        
            
        }
    }
    @IBOutlet weak var btnConfirmation: UIButton!
    @IBOutlet weak var btnFastDelevery: UIButton!
    var totalAmount : Int = 0
  
    init(Prayer : PrayerObj , pricing : BaseRespone)
    {
        super.init( nibName: "ChoosePlanVc", bundle: nil)
        
        self.Prayer = Prayer
        self.pricing = pricing
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmount = Int((self.pricing?.content?.prayerPrice!)!)
            let screenSize: CGRect = UIScreen.main.bounds
        if screenSize.height < 481 {
            self.titleTop.constant = 59;
            self.btnConfirmationTop.constant = 35
       
         
        }
      btnApplePay.isHidden = !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: SupportedPaymentNetworks)
         payPalConfig.acceptCreditCards = acceptCreditCards
        self.setPricing()
       
        self.title = "Complete and Send"
        self.lblTotal.text = "$" + String (totalAmount)
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "The Western Wall Foundation"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
       
        
        payPalConfig.payPalShippingAddressOption = .payPal;
       

      
    }
   
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        paymentViewController.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: self.view, animated: true)
          
            
        })

    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
          
          
           
//            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            WebServices.sharedInstance.sendPrayerRequset(self.Prayer,  responseSuccess: { (Sucsses) in
                if Sucsses.Success == true && Sucsses.ErrorCode == 0 {
                DispatchQueue.main.async(execute: {
                      MBProgressHUD.hide(for: self.view, animated: true)
                    let thankYou : ThankYouVC = ThankYouVC(Prayer: self.Prayer)
                    self.navigationController?.pushViewController(thankYou, animated: true)
                    
                })
                }
                else {
                    AppUtils.ShowAlertView("", bodyKey: "There was a problem creating your order. Please contact us at westernwallfoundation@gmail.com for assistance.", buttonKey: "OK")
                }
                }, Error: { (Error) in
                     MBProgressHUD.hide(for: self.view, animated: true)
                     AppUtils.ShowAlertView("", bodyKey: "There was a problem creating your order. Please contact us at westernwallfoundation@gmail.com for assistance.", buttonKey: "OK")
                    
            })
           
           
        })
    }
    @IBAction func authorizeProfileSharingAction(_ sender: AnyObject) {
        let scopes = [kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]
        let profileSharingViewController = PayPalProfileSharingViewController(scopeValues: NSSet(array: scopes) as Set<NSObject>, configuration: payPalConfig, delegate: self)
        present(profileSharingViewController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   override func viewWillAppear(_ animated: Bool) {
    PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    @IBAction func didClickOneDay(_ sender: AnyObject) {
        if self.btnFastDelevery.isSelected == true {
            self.Prayer.fastDelevery = false
            self.btnFastDelevery.isSelected = false
            totalAmount = totalAmount - Int((self.pricing?.content?.sameDayPrice!)!)
            self.btnFastDelevery.setImage(UIImage(named: "radio.png"), for: UIControlState())
            
        }
        else {
            self.Prayer.fastDelevery = true
            self.btnFastDelevery.isSelected = true
            totalAmount = totalAmount + Int((self.pricing?.content?.sameDayPrice!)!)
            self.btnFastDelevery.setImage(UIImage(named: "radio_on.png"), for: UIControlState())
        }
         self.lblTotal.text = "$" + String (totalAmount)
    }
   


    @IBAction func didClickConfirmation(_ sender: AnyObject) {
        if self.btnConfirmation.isSelected == true {
            self.Prayer.confirmation = false
            self.btnConfirmation.isSelected = false
            totalAmount = totalAmount - Int((self.pricing?.content?.confirmationPrice!)!)
            self.btnConfirmation.setImage(UIImage(named: "radio.png"), for: UIControlState())
            
        }
        else {
          self.Prayer.confirmation = true
             self.btnConfirmation.isSelected = true
             self.btnConfirmation.setImage(UIImage(named: "radio_on.png"), for: UIControlState())
            totalAmount = totalAmount + Int((self.pricing?.content?.confirmationPrice!)!)
        }
         self.lblTotal.text = "$" + String (totalAmount)
    }
    @IBAction func authorizeFuturePaymentsAction(_ sender: AnyObject) {
        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: self)
        present(futurePaymentViewController!, animated: true, completion: nil)
    }
    
    
    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
        print("PayPal Future Payment Authorization Canceled")
       
        futurePaymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable: Any]) {
        print("PayPal Future Payment Authorization Success!")
        // send authorization to your server to get refresh token.
        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = futurePaymentAuthorization.description
         
        })
    }

    
    @IBAction func didClickPay(_ sender: AnyObject) {
         var PrayerDesc : String = "Prayer"
        if Prayer.confirmation == true && Prayer.fastDelevery == true
        {
           PrayerDesc = PrayerDesc +  " with " + self.pricing!.content!.confirmationTitle   +  " and " + self.pricing!.content!.sameDayTitle
            
        }
        else if Prayer.confirmation == true
        {
         PrayerDesc = PrayerDesc +  " with " + self.pricing!.content!.confirmationTitle
        }
        else if Prayer.fastDelevery == true
        {
             PrayerDesc = PrayerDesc + " with " + self.pricing!.content!.sameDayTitle
        }
        let item1 = PayPalItem(name: PrayerDesc, withQuantity: 1, withPrice: NSDecimalNumber(string: String(totalAmount)), withCurrency: "USD", withSku: "")
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0")
        let tax = NSDecimalNumber(string: "0")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: PrayerDesc, intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }

    }
    
    
    @IBAction func didClickPublish(_ sender: AnyObject) {
        if self.btnPublish.isSelected == true {
            self.Prayer.IsPublishAllowed = false
            self.btnPublish.isSelected = false
           
            self.btnPublish.setImage(UIImage(named: "radio.png"), for: UIControlState())
            
        }
        else {
            self.Prayer.IsPublishAllowed = true
            self.btnPublish.isSelected = true
            self.btnPublish.setImage(UIImage(named: "radio_on.png"), for: UIControlState())
           
        }
        
    }
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        print("PayPal Profile Sharing Authorization Canceled")
        
        profileSharingViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable: Any]) {
        print("PayPal Profile Sharing Authorization Success!")
        
        // send authorization to your server
        
        profileSharingViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = profileSharingAuthorization.description
            
        })
        
    }
    func setPricing(){
        self.lblTitle.text = self.pricing!.content!.prayerTitle + ":" + " " + "$" + String(describing: self.pricing!.content!.prayerPrice!)
        self.lblSubTitle.text = self.pricing!.content!.prayerDescription
        self.lblDeliveryTitle.text = self.pricing!.content!.sameDayTitle
        self.lblDeleveyPrice.text = "$" + String(describing: self.pricing!.content!.sameDayPrice!)
        self.lblDeleveryDesc.text = self.pricing!.content!.sameDayDescription
        
        self.lblConfirmationTitle.text = self.pricing!.content!.confirmationTitle
        self.lblConfirmationPrice.text = "$" + String(describing: self.pricing!.content!.confirmationPrice!)
        self.lblConfirmationDesc.text = self.pricing!.content!.confirmationDescription
        self.lblTotal.text = "$" + String(describing: self.pricing!.content!.prayerPrice!)
    
}
    
    @IBAction func didClickApplePay(_ sender: AnyObject) {
         var PrayerDesc : String = "Prayer"
        if Prayer.confirmation == true && Prayer.fastDelevery == true
        {
            PrayerDesc = PrayerDesc +  " with " + self.pricing!.content!.confirmationTitle   +  " and " + self.pricing!.content!.sameDayTitle
            
        }
        else if Prayer.confirmation == true
        {
            PrayerDesc = PrayerDesc +  " with " + self.pricing!.content!.confirmationTitle
        }
        else if Prayer.fastDelevery == true
        {
            PrayerDesc = PrayerDesc + " with " + self.pricing!.content!.sameDayTitle
        }

        
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: PrayerDesc, amount: NSDecimalNumber(string: String(totalAmount)))]
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self
        self.present(applePayController, animated: true, completion: nil)
    }
  
}
extension ChoosePlanVc: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (@escaping (PKPaymentAuthorizationStatus) -> Void)) {
        completion(PKPaymentAuthorizationStatus.success)
           MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServices.sharedInstance.sendPrayerRequset(self.Prayer,  responseSuccess: { (Sucsses) in
            if Sucsses.Success == true && Sucsses.ErrorCode == 0 {
                DispatchQueue.main.async(execute: {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let thankYou : ThankYouVC = ThankYouVC(Prayer: self.Prayer)
                    self.navigationController?.pushViewController(thankYou, animated: true)
                    
                })
            }
            else {
                AppUtils.ShowAlertView("", bodyKey: "There was a problem creating your order. Please contact us at westernwallfoundation@gmail.com for assistance.", buttonKey: "OK")
            }
            }, Error: { (Error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                AppUtils.ShowAlertView("", bodyKey: "There was a problem creating your order. Please contact us at westernwallfoundation@gmail.com for assistance.", buttonKey: "OK")
                
        })
      
        
        
   
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}
