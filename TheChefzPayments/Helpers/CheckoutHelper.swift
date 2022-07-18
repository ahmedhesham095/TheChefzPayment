//
//  CheckoutHelpers.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 18/07/2022.
//

import Foundation
import Frames


class CheckoutHelper {
    
    static  func getCardToken(cardNumber: String , exipyMonth: String , expiryYear : String , cvv: String , cardHolderName: String , environment: Environment , callBack: @escaping (Bool , String? , String? , String?) -> Void) {
        
        // Create a CardTokenRequest instance with the phoneNumber and address values.
        let checkoutAPIClient = CheckoutAPIClient(
            publicKey: PaymentConstants.CHECKOUT_PUBLIC_KEY,
            environment: environment == .sandBox ? .sandbox : .live)
        
        let cardTokenRequest = CkoCardTokenRequest(
            number: cardNumber,
            expiryMonth: exipyMonth,
            expiryYear: expiryYear,
            cvv: cvv,
            name: cardHolderName)
        
        // Request the card token.
        checkoutAPIClient.createCardToken(card: cardTokenRequest) { result in
            switch result {
            case .success(let response):
                callBack(true , response.token , response.bin, "")
            case .failure(let error):
                callBack(false, "", "", error.localizedDescription)
            }
        }
    }
    
}
