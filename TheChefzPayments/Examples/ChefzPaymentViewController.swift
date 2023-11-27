//
//  ChefzPaymentViewController.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 17/07/2022.
//

import UIKit

class ChefzPaymentViewController: UIViewController {
    
    private lazy var initializer: ChefzPaymentInitializer = {
        return ChefzPaymentInitializer(language: .ar, environment: .sandBox, userToken: "D7S5KRMVO7ftPFX59T3QeltGpbjOA0_Yyxq35elx", delegate: self, viewController: self, sdkToken: "pk_sbox_yr3lr2kh266cdiavzjsqdpp7l4e", baseUrl: "https://api-stg.chefztest.co/v9", paymentGateway: 4 )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializer.payWithNewCardCard(cardNumber: "4543474002249996", exipyMonth: "01", expiryYear: "29", cvv: "956", cardHolderName: "test", merchantReference: "8368824", isDefault: true)
        
  //      initializer.verifyCard(cardNumber: "4242424242424242", exipyMonth: "01", expiryYear: "29", cvv: "956", cardHolderName: "test", isDefault: true)
//        initializer.paySavedCard(cardId: "403480", merchantReference: "8361800")
    }
    

}

extension ChefzPaymentViewController: TheChefzPaymentResult {
    
    func didSucess() {
        print("success")
    }
    
    func didFail(with message: String) {
        print("fail")
    }
    
    func didSucess(ref: String) {
        print(ref)
    }
    
    func didFail(ref: String) {
        print(ref)
    }
    
}
