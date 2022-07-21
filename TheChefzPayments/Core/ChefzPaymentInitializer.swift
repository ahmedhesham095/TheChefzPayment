//
//  ViewController.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 07/07/2022.
//

import UIKit
import Frames

public protocol TheChefzPaymentResult {
    func didSucess()
    func didFail(with message: String)
}


public class ChefzPaymentInitializer  {
    
    private  var delegate: TheChefzPaymentResult?
    weak var presentingVC: UIViewController?
    
    private lazy var presenter: ChefzPaymentPresenter = {
        return ChefzPaymentPresenter(delegate: self)
    }()
    
    public init(language: Langugage , environment: Environment , userToken: String , delegate: TheChefzPaymentResult , viewController: UIViewController) {
        self.delegate = delegate
        self.presentingVC = viewController
        PaymentConstants.langugae = language
        PaymentConstants.environment = environment
        PaymentConstants.setUserToken(token: userToken)
    }
    
    public func payWithNewCardCard(cardNumber: String , exipyMonth: String , expiryYear : String , cvv: String , cardHolderName: String , merchantReference: String , isDefault: Bool) {
        
        CheckoutHelper.getCardToken(cardNumber: cardNumber, exipyMonth: exipyMonth, expiryYear: expiryYear, cvv: cvv, cardHolderName: cardHolderName, environment: PaymentConstants.environment ) { [weak self]  success, token, bin, error  in
            if success == false {
                self?.delegate?.didFail(with: error ?? "")
            } else {
                self?.presenter.payNewCard(token: token ?? "", bin: bin ?? "", refrence: merchantReference, cvv: cvv, isDefault: isDefault)
            }
        }
    }
    
    public func verifyCard(cardNumber: String , exipyMonth: String , expiryYear : String , cvv: String , cardHolderName: String , merchantReference: String , isDefault: Bool) {
        
        CheckoutHelper.getCardToken(cardNumber: cardNumber, exipyMonth: exipyMonth, expiryYear: expiryYear, cvv: cvv, cardHolderName: cardHolderName, environment: PaymentConstants.environment ) { [weak self]  success, token, bin, error  in
            if success == false {
                self?.delegate?.didFail(with: error ?? "")
            } else {
                self?.presenter.verifyCard(token: token ?? "", refrence: merchantReference, cvv: cvv, isDefault: isDefault)
            }
        }
    }
    
    public func paySavedCard(cardId: String, merchantReference: String) {
        self.presenter.paySavedCard(cardId: cardId, refrence: merchantReference)
    }
    
    public func payWithApplePay(token: String , merchantRefrence: String)  {
        self.presenter.payApplePay(token: token, refrence: merchantRefrence)
    }
    
}

extension ChefzPaymentInitializer: ChefzPayment {
    
    func didSucessPayment() {
        delegate?.didSucess()
    }
    
    func didFailPayment(with message: String) {
        debugPrint(message)
        delegate?.didFail(with: message)
    }
    
    func willPayWith3DS(link: String) {
        debugPrint(link)
        let bundle = Bundle(for:ThreeDsViewController.self)
        let threeDsVC = ThreeDsViewController(nibName:"ThreeDsViewController" , bundle: bundle)
        threeDsVC.threeDsURL = link
        threeDsVC.delegate = self
        threeDsVC.modalPresentationStyle = .fullScreen
        presentingVC?.present(threeDsVC , animated: true)
    }
    
    
}

extension ChefzPaymentInitializer: ThreeDsResult {
    func threeDsSuccess() {
        debugPrint("3dsSuccess")
        delegate?.didSucess()
    }
    
    func threeDsFail() {
        debugPrint("3dsFail")
        delegate?.didFail(with: "")
    }
}
