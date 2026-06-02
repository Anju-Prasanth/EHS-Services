//
//  FinanceproviderModelClass.swift
//  Express Home
//
//  Created by Anju on 22.05.2023.
//

import Foundation
//struct FinanceProvider : Codable {
//    let financeServiceProviderId : Int?
//    let financeServiceProviderName : String?
//    var isSelected = 0
//    var price = String()
//
//    enum CodingKeys: String, CodingKey {
//
//        case financeServiceProviderId = "financeServiceProviderId"
//        case financeServiceProviderName = "financeServiceProviderName"
//        case isSelected = "isSelected"
//        case price = "price"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        financeServiceProviderId = try values.decodeIfPresent(Int.self, forKey: .financeServiceProviderId)
//        financeServiceProviderName = try values.decodeIfPresent(String.self, forKey: .financeServiceProviderName)
//        isSelected = try values.decodeIfPresent(Int.self, forKey: .isSelected) ?? 0
//        price = try values.decodeIfPresent(String.self, forKey: .price) ?? ""
//    }
//
//}

struct FinanceProvider : Codable {
    let financeServiceProviderId : Int?
    let financeServiceProviderName : String?
    let financePaymentTypeId : Int?
    let financeServiceProviderUrl:String?
    var requiredFields : [RequiredFields]?
    var financePlans : [FinancePlans]?
    var isSelected = 0
    var price = String()
    var financePlanselected:String?
    var financeTypeSelected:String?
    var financePlanIdSelected:Int?
    

    enum CodingKeys: String, CodingKey {

        case financeServiceProviderId = "financeServiceProviderId"
        case financeServiceProviderName = "financeServiceProviderName"
        case financePaymentTypeId = "financePaymentTypeId"
        case requiredFields = "requiredFields"
        case financePlans = "financePlans"
        case isSelected = "isSelected"
        case price = "price"
        case financePlanselected = "financePlanselected"
        case financeTypeSelected = "financeTypeSelected"
        case financePlanIdSelected = "financePlanIdSelected"
        case financeServiceProviderUrl="financeServiceProviderUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        financeServiceProviderId = try values.decodeIfPresent(Int.self, forKey: .financeServiceProviderId)
        financeServiceProviderName = try values.decodeIfPresent(String.self, forKey: .financeServiceProviderName)
        financePaymentTypeId = try values.decodeIfPresent(Int.self, forKey: .financePaymentTypeId)
        requiredFields = try values.decodeIfPresent([RequiredFields].self, forKey: .requiredFields)
        financePlans = try values.decodeIfPresent([FinancePlans].self, forKey: .financePlans)
        isSelected = try values.decodeIfPresent(Int.self, forKey: .isSelected) ?? 0
        financePlanselected = try values.decodeIfPresent(String.self, forKey: .financePlanselected) ?? ""
        financeTypeSelected = try values.decodeIfPresent(String.self, forKey: .financeTypeSelected) ?? ""
        financePlanIdSelected = try values.decodeIfPresent(Int.self, forKey: .financePlanIdSelected) ?? 0
        financeServiceProviderUrl = try values.decodeIfPresent(String.self, forKey: .financeServiceProviderUrl)
    
    }

}
struct FinancePlans : Codable {
    let id : Int?
    let name : String?
    let minimumPaymentPercentage : Double?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case minimumPaymentPercentage = "minimumPaymentPercentage"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        minimumPaymentPercentage = try values.decodeIfPresent(Double.self, forKey: .minimumPaymentPercentage)
        
    }

}
struct RequiredFields : Codable {
    var id : Int?
    let name : String?
    let type : Int?
    var valueEntered=""
    var cardname=""

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
        case valueEntered = "valueEntered"
        case cardname = "cardname"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        valueEntered = try values.decodeIfPresent(String.self, forKey: .valueEntered) ?? ""
        cardname = try values.decodeIfPresent(String.self, forKey: .cardname) ?? ""
    }

}
