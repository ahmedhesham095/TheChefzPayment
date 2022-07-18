//
//  Constants.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 17/07/2022.
//

import Foundation


enum Environment {
    case sandBox
    case production
}

enum Langugage {
    case en
    case ar
}

class PaymentConstants {
    
    static let UDK_TOKEN = "User_Token"
    static let CHECKOUT_PUBLIC_KEY = "pk_test_a8c8e0b6-023b-4402-9704-47d4de12d6e4"
    static let CHECKOUT_SECRET_KEY = "sk_test_bcafb792-6890-4f8b-bf53-2f68ec2ace41"
    static let CHECKOUT_LIVE_BASEURL = "https://api.checkout.com"
    static let CHECKOUT_SANDBOX_BASEURL = "https://api.sandbox.checkout.com"
    static let BASE_PROD_URL = "https://api.thechefz.co/v9"
    static let BASE_STG_URL = "https://api-stg.chefztest.co/v9"
    static var environment: Environment = .production
    static var langugae: Langugage? = .en
    
    
    enum PaymentEndPoints: String {
        case payNewCard = "/payment/checkout/payments"
    }
    
   static func setUserToken(token: String) {
       UserDefaults.standard.set(token , forKey: PaymentConstants.UDK_TOKEN)
    }
    
    static func getUserToken() -> String {
        return  UserDefaults.standard.string(forKey: PaymentConstants.UDK_TOKEN) ?? ""
    }
    
}

