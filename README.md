# TheChefz Payments
an iOS SDK to handle payments with checkout payment gateway
## Installation steps 
### Add pod 'TheChefzPayments' to your pod file

Initialize the SDK
=
```swift
// delegate property to handle the success / failure actions from the SDK
// set the launcing View Controller to the SDK
// language ar / en 
// user token
//environment sandbox / production
    private lazy var initializer: ChefzPaymentInitializer = {
        return ChefzPaymentInitializer(language: .ar, environment: .sandBox, userToken: "TOKEN", delegate: self, viewController: self)
    }()
```
# Usage

### Add New Card

```swift
     initializer.payWithNewCardCard(cardNumber: "4543474002249996", exipyMonth: "01", expiryYear: "29", cvv: "956", cardHolderName: "test", merchantReference: "8361792", isDefault: true)
```

### Pay with Saved Card

```swift
     initializer.paySavedCard(cardId: "403480", merchantReference: "8361800")
```

### Verify Card

```swift
    initializer.verifyCard(cardNumber: "4543474002249996", exipyMonth: "01", expiryYear: "29", cvv: "956", cardHolderName: "test", merchantReference: "8361792", isDefault: true)
```

## You can verify the payment status through the following methods in 
TheChefzPaymentResult protocol 

```swift 
extension ViewController : TheChefzPaymentResult {
// payment success
    func didSucess() {
    
    }
    // did fail and return the message from the payment gateway
    func didFail(with message: String) {
        debugPprint(message)
    }
    
}
```
