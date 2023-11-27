//
//  PaymentProvider.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 18/07/2022.
//
import UIKit
import Moya

enum PaymentAPI {
    case payNewCard(token: String , bin: String , refrence: String , cvv: String , isDefault: Bool)
    case verifyCard(token: String , cvv: String , isDefault: Bool)
    case payCardId(cardId: String , refrence: String)
    case payApplePay(token: String , refrence: String)
    case closeTransactionById(id: String)
}

extension PaymentAPI: TargetType {
    
    
    var baseURL: URL {
        return URL(string: PaymentConstants.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .payNewCard:
            return PaymentConstants.PaymentEndPoints.payNewCard.rawValue
        case .verifyCard:
            return PaymentConstants.PaymentEndPoints.payNewCard.rawValue
        case .payCardId:
            return PaymentConstants.PaymentEndPoints.payNewCard.rawValue
        case .payApplePay:
            return PaymentConstants.PaymentEndPoints.payNewCard.rawValue
        case .closeTransactionById:
            return PaymentConstants.PaymentEndPoints.closeTransaction.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .payNewCard:
            return .post
        case .verifyCard:
            return .post
        case .payCardId:
            return .post
        case .payApplePay:
            return .post
        case .closeTransactionById:
            return .get
        }
    }
    
    var task : Task {
        switch self {
        case .payNewCard(let token , let bin , let refrence , let cvv , let isDefault) :
            
            let source: [String : Any] =  [
                "type": "token",
                "token": token
            ]
            
            return .requestParameters(parameters: ["source": source , "reference": refrence , "cvv": cvv , "is_default": isDefault , "bin" : bin , "payment_gateway": PaymentConstants.paymentGateWay == 4  ? "checkout_v2" : "checkout" ], encoding:  JSONEncoding.default)
            
        case .verifyCard(token: let token, cvv: let cvv, isDefault: let isDefault):
            let source: [String : Any] =  [
                "type": "token",
                "token": token
            ]
            
            return .requestParameters(parameters: ["source": source , "cvv": cvv , "is_default": isDefault ,  "verifyCard": true ,  "payment_gateway": PaymentConstants.paymentGateWay == 4  ? "checkout_v2" : "checkout"], encoding:  JSONEncoding.default)
            
        case .payCardId(cardId: let cardId, refrence: let refrence):
            let source: [String : Any] =  [
                "type": "card_id",
                "card_id": cardId
            ]
            return .requestParameters(parameters: ["source": source , "reference": refrence , "payment_gateway": PaymentConstants.paymentGateWay == 4  ? "checkout_v2" : "checkout"], encoding:  JSONEncoding.default)
            
        case .payApplePay(let token,let refrence):
            let source: [String : Any] =  [
                "type": "token",
                "token": token
            ]
            
            return .requestParameters(parameters: ["source": source , "reference": refrence , "payment_method_type" : "applepay" ,  "payment_gateway": PaymentConstants.paymentGateWay == 4  ? "checkout_v2" : "checkout"], encoding:  JSONEncoding.default)
        case .closeTransactionById(id: let id):
            return .requestParameters(parameters: ["id": id], encoding:  URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        
        var headers = [
            "Content-Type": "application/json",
            "Accept-Language": PaymentConstants.langugae == .en ? "en" : "ar"
        ]
        
        headers["Authorization"] = "Bearer \(PaymentConstants.getUserToken())"
        
        return headers
    }
    
    var sampleData: Data { return Data() }
    
}

