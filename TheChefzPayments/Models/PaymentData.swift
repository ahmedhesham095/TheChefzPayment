//
//  PaymentData.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 18/07/2022.
//
import Foundation
import ObjectMapper


class PaymentData : NSObject, NSCoding, Mappable{
    
    var threedsUrl : String?
    var merchant_reference: Int?
    
    class func newInstance(map: Map) -> Mappable?{
        return PaymentData()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        threedsUrl <- map["3ds_url"]
        merchant_reference <- map["merchant_reference"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        threedsUrl = aDecoder.decodeObject(forKey: "3ds_url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if threedsUrl != nil{
            aCoder.encode(threedsUrl, forKey: "3ds_url")
        }
        
    }
    
}

