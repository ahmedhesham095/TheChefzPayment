//
//  Constants.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 17/07/2022.
//

import Foundation


public enum Environment {
    case sandBox
    case production
}

public enum Langugage {
    case en
    case ar
}

class PaymentConstants {
    
    static let UDK_TOKEN = "User_Token"
    static var CHECKOUT_PUBLIC_KEY = ""
    static let CHECKOUT_LIVE_BASEURL = "https://api.checkout.com"
    static let CHECKOUT_SANDBOX_BASEURL = "https://api.sandbox.checkout.com"
    static var BASE_URL = ""
    static var environment: Environment = .production
    static var langugae: Langugage? = .en
    static var paymentGateWay = 0
    
    enum PaymentEndPoints: String {
        case payNewCard = "/payment/checkoutv2/payments"
        case closeTransaction = "/payment/checkoutv2/close-transaction-by-id"
    }
    
   static func setUserToken(token: String) {
       UserDefaults.standard.set(token , forKey: PaymentConstants.UDK_TOKEN)
    }
    
    static func getUserToken() -> String {
        return  UserDefaults.standard.string(forKey: PaymentConstants.UDK_TOKEN) ?? ""
    }
    
}

