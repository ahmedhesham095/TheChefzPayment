//
//  PaymentResult.swift
//  TheChefzPayments
//
//  Created by Ahmed Hesham on 18/07/2022.
//

import Foundation
import ObjectMapper


class PaymentResult : NSObject, NSCoding, Mappable{

    var data : PaymentData?
    var success : Bool?
    var status_message: String?

    class func newInstance(map: Map) -> Mappable?{
        return PaymentResult()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        data <- map["data"]
        success <- map["success"]
        status_message <- map["status_message"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         data = aDecoder.decodeObject(forKey: "data") as? PaymentData
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}
