//
//  ChefzPaymentPresenter.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 17/07/2022.
//

import Foundation

protocol ChefzPayment {
    func didSucessPayment()
    func didFailPayment(with message: String)
    func willPayWith3DS(link: String)
}


class ChefzPaymentPresenter {
    
    var delegate: ChefzPayment?
    
    init (delegate: ChefzPayment) {
        self.delegate = delegate
    }
    
    
    func payNewCard(token: String , bin: String , refrence: String , cvv: String , isDefault: Bool) {
        PaymentService.payNewCard(token: token, bin: bin, refrence: refrence, cvv: cvv, isDefault: isDefault)  { [weak self] success, thereeDS , errorMessage in
            if success == true {
                if thereeDS != "" {
                    self?.delegate?.willPayWith3DS(link: thereeDS)
                } else {
                    self?.delegate?.didSucessPayment()
                }
            } else {
                self?.delegate?.didFailPayment(with: errorMessage)
            }
        }
    }
    
    func verifyCard(token: String , refrence: String , cvv: String , isDefault: Bool) {
        PaymentService.verifyCard(token: token, refrence: refrence, cvv: cvv, isDefault: isDefault)  { [weak self] success, thereeDS , errorMessage in
            if success == true {
                if thereeDS != "" {
                    self?.delegate?.willPayWith3DS(link: thereeDS)
                } else {
                    self?.delegate?.didSucessPayment()
                }
            } else {
                self?.delegate?.didFailPayment(with: errorMessage)
            }
        }
    }
    
    func paySavedCard(cardId: String , refrence: String) {
        PaymentService.paySavedCard(cardId: cardId, refrence: refrence) { [weak self] success, thereeDS , errorMessage in
            if success == true {
                if thereeDS != "" {
                    self?.delegate?.willPayWith3DS(link: thereeDS)
                } else {
                    self?.delegate?.didSucessPayment()
                }
            } else {
                self?.delegate?.didFailPayment(with: errorMessage)
            }
        }
    }
    
}
