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
    func didVerifySucess(ref: String)
    func didVerifyFail(ref: String)
}

extension TheChefzPaymentResult {
    func didVerifySucess(ref: String) {}
    func didVerifyFail(ref: String) {}
}

public class ChefzPaymentInitializer  {
    
    private  var delegate: TheChefzPaymentResult?
    weak var presentingVC: UIViewController?
    
    private lazy var presenter: ChefzPaymentPresenter = {
        return ChefzPaymentPresenter(delegate: self)
    }()
    
    public init(language: Langugage , environment: Environment , userToken: String , delegate: TheChefzPaymentResult , viewController: UIViewController , sdkToken: String , baseUrl: String) {
        self.delegate = delegate
        self.presentingVC = viewController
        PaymentConstants.langugae = language
        PaymentConstants.environment = environment
        PaymentConstants.CHECKOUT_PUBLIC_KEY = sdkToken
        PaymentConstants.BASE_URL = baseUrl
        PaymentConstants.setUserToken(token: userToken)
    }
    
    public func payWithNewCardCard(cardNumber: String , exipyMonth: String , expiryYear : String , cvv: String , cardHolderName: String , merchantReference: String , isDefault: Bool) {
        
        CheckoutHelper.getCardToken(cardNumber: cardNumber, exipyMonth: exipyMonth, expiryYear: expiryYear, cvv: cvv, cardHolderName: cardHolderName, environment: PaymentConstants.environment ) { [weak self]  success, token, bin, error  in
            if success == false {
                self?.delegate?.didFail(with: error ?? "")
            } else {
                Loader.shared.showProgress(viewController: self?.presentingVC ?? UIViewController())
                self?.presenter.payNewCard(token: token ?? "", bin: bin ?? "", refrence: merchantReference, cvv: cvv, isDefault: isDefault)
            }
        }
    }
    
    public func verifyCard(cardNumber: String , exipyMonth: String , expiryYear : String , cvv: String , cardHolderName: String , isDefault: Bool) {
        
        CheckoutHelper.getCardToken(cardNumber: cardNumber, exipyMonth: exipyMonth, expiryYear: expiryYear, cvv: cvv, cardHolderName: cardHolderName, environment: PaymentConstants.environment ) { [weak self]  success, token, bin, error  in
            if success == false {
                self?.delegate?.didFail(with: error ?? "")
            } else {
                Loader.shared.showProgress(viewController: self?.presentingVC ?? UIViewController())
                self?.presenter.verifyCard(token: token ?? "", cvv: cvv, isDefault: isDefault)
            }
        }
    }
    
    public func paySavedCard(cardId: String, merchantReference: String) {
        Loader.shared.showProgress(viewController: presentingVC ?? UIViewController())
        self.presenter.paySavedCard(cardId: cardId, refrence: merchantReference)
    }
    
    public func payWithApplePay(token: String , merchantRefrence: String)  {
        Loader.shared.showProgress(viewController: presentingVC ?? UIViewController())
        self.presenter.payApplePay(token: token, refrence: merchantRefrence)
    }
    
}

extension ChefzPaymentInitializer: ChefzPayment {
    
    func didSuccessWithRef(ref: String) {
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
        delegate?.didVerifySucess(ref: ref)
    }
    
    func willVerifyWith3DS(link: String, ref: String) {
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
        let bundle = Bundle(for:ThreeDsViewController.self)
        let threeDsVC = ThreeDsViewController(nibName:"ThreeDsViewController" , bundle: bundle)
        threeDsVC.threeDsURL = link
        threeDsVC.delegate = self
        threeDsVC.merchantRef = ref
        threeDsVC.isVerfyCard = true
        threeDsVC.modalPresentationStyle = .fullScreen
        presentingVC?.present(threeDsVC , animated: true)
    }
    
    
    func didSucessPayment() {
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
        delegate?.didSucess()
    }
    
    func didFailPayment(with message: String) {
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
        debugPrint(message)
        delegate?.didFail(with: message)
    }
    
    func willPayWith3DS(link: String) {
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
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
    
    func closeTransactionById(Id: String) {
        presenter.closeTransactionById(id: Id)
    }
    
    
    func threeDsVerifySuccess(ref: String) {
        debugPrint(ref)
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
        delegate?.didVerifySucess(ref: ref)
    }
    
    func threeDsSuccess() {
        debugPrint("3dsSuccess")
        Loader.shared.hidePrgoress(viewController: presentingVC ?? UIViewController())
        delegate?.didSucess()
    }
    
}

