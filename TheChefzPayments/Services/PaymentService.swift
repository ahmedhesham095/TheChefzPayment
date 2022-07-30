//
//  PaymentService.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 18/07/2022.
//

import Foundation
import Moya
import ObjectMapper

class PaymentService {
    
    static func payNewCard(token: String , bin: String , refrence: String , cvv: String , isDefault: Bool, callback:@escaping (Bool,String , String) -> Void) {
        
        let provider = MoyaProvider<PaymentAPI>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.payNewCard(token: token, bin: bin, refrence: refrence, cvv: cvv, isDefault: isDefault)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = Mapper<PaymentResult>().map(JSON:try response.mapJSON() as! [String : Any])
                    if result?.success ?? false {
                        if result?.data?.threedsUrl != nil {
                            callback(true , result?.data?.threedsUrl ?? "" , "")
                        } else {
                            callback(true , "", "")
                        }
                    } else {
                        callback(false , "" , result?.status_message ?? "")
                    }
                } catch {
                    callback(false , "", "")
                }
            case .failure(_):
                callback(false , "", "")
            }
        }
    }
    
    static func verifyCard(token: String , cvv: String , isDefault: Bool, callback:@escaping (Bool, String , String , String) -> Void) {
        
        let provider = MoyaProvider<PaymentAPI>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.verifyCard(token: token, cvv: cvv, isDefault: isDefault)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = Mapper<PaymentResult>().map(JSON:try response.mapJSON() as! [String : Any])
                    if result?.success ?? false {
                        if result?.data?.threedsUrl != nil {
                            callback(true , result?.data?.threedsUrl ?? "" ,"\(result?.data?.merchant_reference ?? 0)" , "")
                        } else {
                            callback(true , "", "\(result?.data?.merchant_reference ?? 0)" , "")
                        }
                    } else {
                        callback(false , "" , "\(result?.data?.merchant_reference ?? 0)" , result?.status_message ?? "")
                    }
                } catch {
                    callback(false , "", "", "")
                }
            case .failure(_):
                callback(false , "", "", "")
            }
        }
    }
    
    static func paySavedCard(cardId: String , refrence: String, callback:@escaping (Bool,String , String) -> Void) {
        
        let provider = MoyaProvider<PaymentAPI>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.payCardId(cardId: cardId, refrence: refrence)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = Mapper<PaymentResult>().map(JSON:try response.mapJSON() as! [String : Any])
                    if result?.success ?? false {
                        if result?.data?.threedsUrl != nil {
                            callback(true , result?.data?.threedsUrl ?? "" , "")
                        } else {
                            callback(true , "", "")
                        }
                    } else {
                        callback(false , "" , result?.status_message ?? "")
                    }
                } catch {
                    callback(false , "", "")
                }
            case .failure(_):
                callback(false , "", "")
            }
        }
    }
    
    static func payApplePay(token: String , refrence: String, callback:@escaping (Bool,String) -> Void) {
        
        let provider = MoyaProvider<PaymentAPI>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.payApplePay(token: token, refrence: refrence)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = Mapper<PaymentResult>().map(JSON:try response.mapJSON() as! [String : Any])
                    if result?.success ?? false {
                        callback(true , "")
                    } else {
                        callback(false , result?.status_message ?? "")
                    }
                } catch {
                    callback(false , "")
                }
            case .failure(_):
                callback(false , "")
            }
        }
    }
    
    static func closeTransaction(id: String , callback:@escaping (Bool,String) -> Void) {
        
        let provider = MoyaProvider<PaymentAPI>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.closeTransactionById(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = Mapper<PaymentResult>().map(JSON:try response.mapJSON() as! [String : Any])
                    if result?.success ?? false {
                        callback(true , "")
                    } else {
                        callback(false , result?.status_message ?? "")
                    }
                } catch {
                    callback(false , "")
                }
            case .failure(_):
                callback(false , "")
            }
        }
    }
}
