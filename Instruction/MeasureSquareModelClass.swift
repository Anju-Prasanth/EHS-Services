//
//  MeasureSquareModelClass.swift
//  Express Home
//
//  Created by Anju on 21.06.2023.
//

import Foundation

//struct MeasureSquareProjectByAppointmentID : Codable {
//    let projectId : String?
//    let name : String?
//    let revision : Int?
//    let ownerM2Id : String?
//    let creatorM2Id : String?
//    let usedM2Id : String?
//    let lastUpdatedOn : Int?
//    let size : Int?
//    let isArchived : Bool?
//    let applicationType : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case projectId = "projectId"
//        case name = "name"
//        case revision = "revision"
//        case ownerM2Id = "ownerM2Id"
//        case creatorM2Id = "creatorM2Id"
//        case usedM2Id = "usedM2Id"
//        case lastUpdatedOn = "lastUpdatedOn"
//        case size = "size"
//        case isArchived = "isArchived"
//        case applicationType = "applicationType"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        projectId = try values.decodeIfPresent(String.self, forKey: .projectId)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        revision = try values.decodeIfPresent(Int.self, forKey: .revision)
//        ownerM2Id = try values.decodeIfPresent(String.self, forKey: .ownerM2Id)
//        creatorM2Id = try values.decodeIfPresent(String.self, forKey: .creatorM2Id)
//        usedM2Id = try values.decodeIfPresent(String.self, forKey: .usedM2Id)
//        lastUpdatedOn = try values.decodeIfPresent(Int.self, forKey: .lastUpdatedOn)
//        size = try values.decodeIfPresent(Int.self, forKey: .size)
//        isArchived = try values.decodeIfPresent(Bool.self, forKey: .isArchived)
//        applicationType = try values.decodeIfPresent(String.self, forKey: .applicationType)
//    }
//
//}

//    struct MeasureSquareProjectByAppointmentID : Codable {
//        let projectId : String?
//        var name : String?
//        let revision : Int?
//        let ownerM2Id : String?
//        let creatorM2Id : String?
//        let usedM2Id : String?
//        let lastUpdatedOn : Int?
//        let size : Int?
//        let isArchived : Bool?
//        let applicationType : String?
//        let pricingDetails : PricingDetails?
//        var cardCheckArrayDict:[String:String]=[:]
//        var customPrice=String()
//        var discountDollars=""
//
//        enum CodingKeys: String, CodingKey {
//
//            case projectId = "projectId"
//            case name = "name"
//            case revision = "revision"
//            case ownerM2Id = "ownerM2Id"
//            case creatorM2Id = "creatorM2Id"
//            case usedM2Id = "usedM2Id"
//            case lastUpdatedOn = "lastUpdatedOn"
//            case size = "size"
//            case isArchived = "isArchived"
//            case applicationType = "applicationType"
//            case pricingDetails = "pricingDetails"
//            case cardCheckArrayDict="cardCheckArrayDict"
//            case customPrice="customPrice"
//            case discountDollars="discountDollars"
//        }
//
//        init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            cardCheckArrayDict=try values.decodeIfPresent([String:String].self, forKey: .cardCheckArrayDict) ?? [:]
//            name = try values.decodeIfPresent(String.self, forKey: .name)
//            projectId = try values.decodeIfPresent(String.self, forKey: .projectId)
//            name = try values.decodeIfPresent(String.self, forKey: .name)
//            revision = try values.decodeIfPresent(Int.self, forKey: .revision)
//            ownerM2Id = try values.decodeIfPresent(String.self, forKey: .ownerM2Id)
//            creatorM2Id = try values.decodeIfPresent(String.self, forKey: .creatorM2Id)
//            usedM2Id = try values.decodeIfPresent(String.self, forKey: .usedM2Id)
//            lastUpdatedOn = try values.decodeIfPresent(Int.self, forKey: .lastUpdatedOn)
//            size = try values.decodeIfPresent(Int.self, forKey: .size)
//            isArchived = try values.decodeIfPresent(Bool.self, forKey: .isArchived)
//            applicationType = try values.decodeIfPresent(String.self, forKey: .applicationType)
//            pricingDetails = try values.decodeIfPresent(PricingDetails.self, forKey: .pricingDetails)
//            customPrice = try values.decodeIfPresent(String.self, forKey: .customPrice) ?? ""
//            discountDollars = try values.decodeIfPresent(String.self, forKey: .discountDollars) ?? ""
//        }
//
//    }
//
//struct Labor : Codable {
//    let name : String?
//    let qty : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case qty = "qty"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
//    }
//
//}
//
//struct Pricing : Codable{
//    let name : String?
//    let salesAmount : Double?
//    let commissionTier : String?
//    let commissionEst : Double?
//    let isMax : Bool?
//    let isMin : Bool?
//    let displayPrice : Bool?
//    let highlightPrice : Bool?
//    let displayInSummary : Bool?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case salesAmount = "salesAmount"
//        case commissionTier = "commissionTier"
//        case commissionEst = "commissionEst"
//        case isMax = "isMax"
//        case isMin = "isMin"
//        case displayPrice = "displayPrice"
//        case highlightPrice = "highlightPrice"
//        case displayInSummary = "displayInSummary"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        salesAmount = try values.decodeIfPresent(Double.self, forKey: .salesAmount)
//        commissionTier = try values.decodeIfPresent(String.self, forKey: .commissionTier)
//        commissionEst = try values.decodeIfPresent(Double.self, forKey: .commissionEst)
//        isMax = try values.decodeIfPresent(Bool.self, forKey: .isMax)
//        isMin = try values.decodeIfPresent(Bool.self, forKey: .isMin)
//        displayPrice = try values.decodeIfPresent(Bool.self, forKey: .displayPrice)
//        highlightPrice = try values.decodeIfPresent(Bool.self, forKey: .highlightPrice)
//        displayInSummary = try values.decodeIfPresent(Bool.self, forKey: .displayInSummary)
//    }
//
//}
//
//struct PricingDetails : Codable {
//    let m2ProjectID : String?
//    let projectID : Int?
//    let projectName : String?
//    let rooms : [Rooms]?
//    let stairs : String?
//    let pricing : [Pricing]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case m2ProjectID = "m2ProjectID"
//        case projectID = "projectID"
//        case projectName = "projectName"
//        case rooms = "rooms"
//        case stairs = "stairs"
//        case pricing = "pricing"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        m2ProjectID = try values.decodeIfPresent(String.self, forKey: .m2ProjectID)
//        projectID = try values.decodeIfPresent(Int.self, forKey: .projectID)
//        projectName = try values.decodeIfPresent(String.self, forKey: .projectName)
//        rooms = try values.decodeIfPresent([Rooms].self, forKey: .rooms)
//        stairs = try values.decodeIfPresent(String.self, forKey: .stairs)
//        pricing = try values.decodeIfPresent([Pricing].self, forKey: .pricing)
//    }
//
//}
//
//struct Products : Codable {
//    let name : String?
//    let qty : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case qty = "qty"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
//    }
//
//}
//struct Rooms : Codable {
//    let id : Int?
//    let name : String?
//    let products : [Products]?
//    let accessories : [Accessories]?
//    let labor : [Labor]?
//    var sectiontapped=false
//    var isRoom=true
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case products = "products"
//        case accessories = "accessories"
//        case labor = "labor"
//        case sectiontapped = "sectiontapped"
//        case isRoom="isRoom"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        products = try values.decodeIfPresent([Products].self, forKey: .products)
//        accessories = try values.decodeIfPresent([Accessories].self, forKey: .accessories)
//        labor = try values.decodeIfPresent([Labor].self, forKey: .labor)
//        sectiontapped = try values.decodeIfPresent(Bool.self, forKey: .sectiontapped) ?? false
//        isRoom = try values.decodeIfPresent(Bool.self, forKey: .isRoom) ?? true
//    }
//
//}
//
//struct Accessories : Codable {
//    let name : String?
//    let qty : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case qty = "qty"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
//    }
//
//}
//struct Stairs : Codable {
//    let id : Int?
//    let name : String?
//    let products : [Products]?
//    let labor : [Labor]?
//    let accessories : [Accessories]?
//    var isRoom=false
//    var sectiontapped=false
//
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case products = "products"
//        case labor = "labor"
//        case accessories = "accessories"
//        case isRoom = "isRoom"
//        case sectiontapped = "sectiontapped"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        products = try values.decodeIfPresent([Products].self, forKey: .products)
//        accessories = try values.decodeIfPresent([Accessories].self, forKey: .accessories)
//        labor = try values.decodeIfPresent([Labor].self, forKey: .labor)
//        isRoom = try values.decodeIfPresent(Bool.self, forKey: .isRoom) ?? false
//        sectiontapped = try values.decodeIfPresent(Bool.self, forKey: .sectiontapped) ?? false
//    }
//
//}



struct MeasureSquareProjectByAppointmentID : Codable {
    let projectId : String?
    let name : String?
    let revision : Int?
    let ownerM2Id : String?
    let creatorM2Id : String?
    let usedM2Id : String?
    let lastUpdatedOn : Int?
    let size : Int?
    let isArchived : Bool?
    let applicationType : String?
    let pricingDetails : PricingDetails?
    var customPrice=String()
    var discountDollars=""
    var customPriceName=""
    var customerTypepricingArray:[Pricing]?
    var dispalyTypePricingArray:[Pricing]?
    var nofinanceModelcardCheckDetailArray:[[String:String]]=[]
    var nofinanceModelDepositFinanceProviderArray=[FinanceProvider]()
    var balanceNoFinanceSelectedModelcardCheckDetailArray:[[String:String]]=[]
    var balanceNoFinanceSelectedModelBalanceFinanceProviderArray=[FinanceProvider]()
    var voucherArray:[PromoOffers]?
    var promoArray:[String]?
    var isOfferApplied:Bool?
    var promofullArray:[String]?
    var ACHFieldArray=[RequiredFields]()
    var saleAmount=Double()
    var ACHfinanceServiceProviderId=0
    var promoAddedFullArray=[PromotionalCodes]()
    


    enum CodingKeys: String, CodingKey {

        case projectId = "projectId"
        case name = "name"
        case revision = "revision"
        case ownerM2Id = "ownerM2Id"
        case creatorM2Id = "creatorM2Id"
        case usedM2Id = "usedM2Id"
        case lastUpdatedOn = "lastUpdatedOn"
        case size = "size"
        case isArchived = "isArchived"
        case applicationType = "applicationType"
        case pricingDetails = "pricingDetails"
        case customPrice="customPrice"
        case discountDollars="discountDollars"
        case customPriceName="customPriceName"
        case customerTypepricingArray="customerTypepricingArray"
        case dispalyTypePricingArray="dispalyTypePricingArray"
        case nofinanceModelcardCheckDetailArray="nofinanceModelcardCheckDetailArray"
        case nofinanceModelDepositFinanceProviderArray="nofinanceModelDepositFinanceProviderArray"
        case balanceNoFinanceSelectedModelcardCheckDetailArray="balanceNoFinanceSelectedModelcardCheckDetailArray"
        case balanceNoFinanceSelectedModelBalanceFinanceProviderArray="balanceNoFinanceSelectedModelBalanceFinanceProviderArray"
        case voucherArray="voucherArray"
        case promoArray="promoArray"
        case isOfferApplied="isOfferApplied"
        case promofullArray="promofullArray"
        case ACHFieldArray="ACHFieldArray"
        case saleAmount="saleAmount"
        case ACHfinanceServiceProviderId="ACHfinanceServiceProviderId"
        case promoAddedFullArray="promoAddedFullArray"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        projectId = try values.decodeIfPresent(String.self, forKey: .projectId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        revision = try values.decodeIfPresent(Int.self, forKey: .revision)
        ownerM2Id = try values.decodeIfPresent(String.self, forKey: .ownerM2Id)
        creatorM2Id = try values.decodeIfPresent(String.self, forKey: .creatorM2Id)
        usedM2Id = try values.decodeIfPresent(String.self, forKey: .usedM2Id)
        lastUpdatedOn = try values.decodeIfPresent(Int.self, forKey: .lastUpdatedOn)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        isArchived = try values.decodeIfPresent(Bool.self, forKey: .isArchived)
        applicationType = try values.decodeIfPresent(String.self, forKey: .applicationType)
        pricingDetails = try values.decodeIfPresent(PricingDetails.self, forKey: .pricingDetails)
        customPrice = try values.decodeIfPresent(String.self, forKey: .customPrice) ?? ""
       discountDollars = try values.decodeIfPresent(String.self, forKey: .discountDollars) ?? ""
        customPriceName=try values.decodeIfPresent(String.self, forKey: .customPriceName) ?? ""
        customerTypepricingArray=try values.decodeIfPresent([Pricing].self, forKey: .customerTypepricingArray) ?? []
        dispalyTypePricingArray=try values.decodeIfPresent([Pricing].self, forKey: .dispalyTypePricingArray) ?? []
        nofinanceModelcardCheckDetailArray=try values.decodeIfPresent([[String:String]].self, forKey: .nofinanceModelcardCheckDetailArray) ?? []
        nofinanceModelDepositFinanceProviderArray=try values.decodeIfPresent([FinanceProvider].self, forKey: .nofinanceModelDepositFinanceProviderArray) ?? []
        balanceNoFinanceSelectedModelcardCheckDetailArray=try values.decodeIfPresent([[String:String]].self, forKey: .balanceNoFinanceSelectedModelcardCheckDetailArray) ?? []
        balanceNoFinanceSelectedModelBalanceFinanceProviderArray=try values.decodeIfPresent([FinanceProvider].self, forKey: .balanceNoFinanceSelectedModelBalanceFinanceProviderArray) ?? []
        voucherArray=try values.decodeIfPresent([PromoOffers].self, forKey: .voucherArray) ?? []
        promoArray=try values.decodeIfPresent([String].self, forKey: .promoArray) ?? []
        isOfferApplied=try values.decodeIfPresent(Bool.self, forKey: .isOfferApplied) ?? false
        promofullArray=try values.decodeIfPresent([String].self, forKey: .promofullArray) ?? []
        ACHFieldArray=try values.decodeIfPresent([RequiredFields].self, forKey: .ACHFieldArray) ?? []
        saleAmount=try values.decodeIfPresent(Double.self, forKey: .saleAmount) ?? 0
        ACHfinanceServiceProviderId=try values.decodeIfPresent(Int.self, forKey: .ACHfinanceServiceProviderId) ?? 0
        promoAddedFullArray=try values.decodeIfPresent([PromotionalCodes].self, forKey: .promoAddedFullArray) ?? []
    }
   
    

}

struct Accessories : Codable {
    let name : String?
    let qty : Double?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case qty = "qty"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
    }

}

struct Labor : Codable {
    let name : String?
    let qty : Double?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case qty = "qty"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
    }

}

struct Pricing : Codable {
    let name : String?
    let salesAmount : Double?
    let commissionTier : String?
    let commissionEst : Double?
    let isMax : Bool?
    let isMin : Bool?
    let displayPrice : Bool?
    let highlightPrice : Bool?
    let displayInSummary : Bool?
    var isSelected=false

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case salesAmount = "salesAmount"
        case commissionTier = "commissionTier"
        case commissionEst = "commissionEst"
        case isMax = "isMax"
        case isMin = "isMin"
        case displayPrice = "displayPrice"
        case highlightPrice = "highlightPrice"
        case displayInSummary = "displayInSummary"
        case isSelected = "isSelected"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        salesAmount = try values.decodeIfPresent(Double.self, forKey: .salesAmount)
        commissionTier = try values.decodeIfPresent(String.self, forKey: .commissionTier)
        commissionEst = try values.decodeIfPresent(Double.self, forKey: .commissionEst)
        isMax = try values.decodeIfPresent(Bool.self, forKey: .isMax)
        isMin = try values.decodeIfPresent(Bool.self, forKey: .isMin)
        displayPrice = try values.decodeIfPresent(Bool.self, forKey: .displayPrice)
        highlightPrice = try values.decodeIfPresent(Bool.self, forKey: .highlightPrice)
        displayInSummary = try values.decodeIfPresent(Bool.self, forKey: .displayInSummary)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
    }

}

struct PricingDetails : Codable {
    let m2ProjectID : String?
    let projectID : Int?
    let projectName : String?
    let rooms : [Rooms]?
    let stairs : [Stairs]?
    let pricing : [Pricing]?

    enum CodingKeys: String, CodingKey {

        case m2ProjectID = "m2ProjectID"
        case projectID = "projectID"
        case projectName = "projectName"
        case rooms = "rooms"
        case stairs = "stairs"
        case pricing = "pricing"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        m2ProjectID = try values.decodeIfPresent(String.self, forKey: .m2ProjectID)
        projectID = try values.decodeIfPresent(Int.self, forKey: .projectID)
        projectName = try values.decodeIfPresent(String.self, forKey: .projectName)
        rooms = try values.decodeIfPresent([Rooms].self, forKey: .rooms) ?? []

//        if let stairsValue = try? values.decodeIfPresent([Stairs].self, forKey: .stairs) {
//        stairs = stairsValue
//    } else {
//        stairs = nil
//    }
//
//        if let roomvalue = try? values.decodeIfPresent([Rooms].self, forKey: .rooms) {
//        rooms = roomvalue
//    } else {
//        rooms = nil
//    }
        stairs = try values.decodeIfPresent([Stairs].self, forKey: .stairs) ?? []
        pricing = try values.decodeIfPresent([Pricing].self, forKey: .pricing) ?? []
    }
}


struct Products : Codable {
    let name : String?
    let qty : Double?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case qty = "qty"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
    }

}


struct Rooms : Codable {
    let id : Int?
    let name : String?
    let products : [Products]?
    let accessories : [Accessories]?
    let labor : [Labor]?
    var sectiontapped=false
    var isRoom=true

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case products = "products"
        case accessories = "accessories"
        case labor = "labor"
        case isRoom = "isRoom"
        case sectiontapped = "sectiontapped"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        products = try values.decodeIfPresent([Products].self, forKey: .products) ?? []
        accessories = try values.decodeIfPresent([Accessories].self, forKey: .accessories) ?? []
        labor = try values.decodeIfPresent([Labor].self, forKey: .labor) ?? []
        isRoom = try values.decodeIfPresent(Bool.self, forKey: .isRoom) ?? false
        sectiontapped = try values.decodeIfPresent(Bool.self, forKey: .sectiontapped) ?? false

    }

}
struct Stairs : Codable {
    let id : Int?
    let name : String?
    let products : [Products]?
    let labor : [Labor]?
    let accessories : [Accessories]?
    var isRoom=false
    var sectiontapped=false


    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case products = "products"
        case labor = "labor"
        case accessories = "accessories"
        case isRoom = "isRoom"
        case sectiontapped = "sectiontapped"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        products = try values.decodeIfPresent([Products].self, forKey: .products) ?? []
        accessories = try values.decodeIfPresent([Accessories].self, forKey: .accessories) ?? []
        labor = try values.decodeIfPresent([Labor].self, forKey: .labor) ?? []
        isRoom = try values.decodeIfPresent(Bool.self, forKey: .isRoom) ?? false
        sectiontapped = try values.decodeIfPresent(Bool.self, forKey: .sectiontapped) ?? false
    }

}




//struct MeasureSquareProjectByAppointmentID : Codable {
//    let projectId : String?
//    let name : String?
//    let revision : Int?
//    let ownerM2Id : String?
//    let creatorM2Id : String?
//    let usedM2Id : String?
//    let lastUpdatedOn : Int?
//    let size : Int?
//    let isArchived : Bool?
//    let applicationType : String?
//    let pricingDetails : PricingDetails?
//    var customPrice=String()
//    var discountDollars=""
//    var customPriceName=""
//
//    enum CodingKeys: String, CodingKey {
//
//        case projectId = "projectId"
//        case name = "name"
//        case revision = "revision"
//        case ownerM2Id = "ownerM2Id"
//        case creatorM2Id = "creatorM2Id"
//        case usedM2Id = "usedM2Id"
//        case lastUpdatedOn = "lastUpdatedOn"
//        case size = "size"
//        case isArchived = "isArchived"
//        case applicationType = "applicationType"
//        case pricingDetails = "pricingDetails"
//        case customPrice="customPrice"
//        case discountDollars="discountDollars"
//        case customPriceName="customPriceName"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        projectId = try values.decodeIfPresent(String.self, forKey: .projectId)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        revision = try values.decodeIfPresent(Int.self, forKey: .revision)
//        ownerM2Id = try values.decodeIfPresent(String.self, forKey: .ownerM2Id)
//        creatorM2Id = try values.decodeIfPresent(String.self, forKey: .creatorM2Id)
//        usedM2Id = try values.decodeIfPresent(String.self, forKey: .usedM2Id)
//        lastUpdatedOn = try values.decodeIfPresent(Int.self, forKey: .lastUpdatedOn)
//        size = try values.decodeIfPresent(Int.self, forKey: .size)
//        isArchived = try values.decodeIfPresent(Bool.self, forKey: .isArchived)
//        applicationType = try values.decodeIfPresent(String.self, forKey: .applicationType)
//        pricingDetails = try values.decodeIfPresent(PricingDetails.self, forKey: .pricingDetails)
//        customPrice = try values.decodeIfPresent(String.self, forKey: .customPrice) ?? ""
//        discountDollars = try values.decodeIfPresent(String.self, forKey: .discountDollars) ?? ""
//        customPriceName=try values.decodeIfPresent(String.self, forKey: .customPriceName) ?? ""
//    }
//
//}
//
//struct Accessories : Codable {
//    let name : String?
//    let qty : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case qty = "qty"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        qty = try values.decodeIfPresent(Int.self, forKey: .qty)
//    }
//
//}
//
//struct Labor : Codable {
//    let name : String?
//    let qty : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case qty = "qty"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        qty = try values.decodeIfPresent(Int.self, forKey: .qty)
//    }
//
//}
//
//struct Pricing : Codable {
//    let name : String?
//    let salesAmount : Double?
//    let commissionTier : String?
//    let commissionEst : Double?
//    let isMax : Bool?
//    let isMin : Bool?
//    let displayPrice : Bool?
//    let highlightPrice : Bool?
//    let displayInSummary : Bool?
//    var isSelected=false
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case salesAmount = "salesAmount"
//        case commissionTier = "commissionTier"
//        case commissionEst = "commissionEst"
//        case isMax = "isMax"
//        case isMin = "isMin"
//        case displayPrice = "displayPrice"
//        case highlightPrice = "highlightPrice"
//        case displayInSummary = "displayInSummary"
//        case isSelected = "isSelected"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        salesAmount = try values.decodeIfPresent(Double.self, forKey: .salesAmount)
//        commissionTier = try values.decodeIfPresent(String.self, forKey: .commissionTier)
//        commissionEst = try values.decodeIfPresent(Double.self, forKey: .commissionEst)
//        isMax = try values.decodeIfPresent(Bool.self, forKey: .isMax)
//        isMin = try values.decodeIfPresent(Bool.self, forKey: .isMin)
//        displayPrice = try values.decodeIfPresent(Bool.self, forKey: .displayPrice)
//        highlightPrice = try values.decodeIfPresent(Bool.self, forKey: .highlightPrice)
//        displayInSummary = try values.decodeIfPresent(Bool.self, forKey: .displayInSummary)
//        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
//    }
//
//}
//
//struct PricingDetails : Codable {
//    let m2ProjectID : String?
//    let projectID : Int?
//    let projectName : String?
//    let rooms : [Rooms]?
//    let stairs : [Stairs]?
//    let pricing : [Pricing]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case m2ProjectID = "m2ProjectID"
//        case projectID = "projectID"
//        case projectName = "projectName"
//        case rooms = "rooms"
//        case stairs = "stairs"
//        case pricing = "pricing"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        m2ProjectID = try values.decodeIfPresent(String.self, forKey: .m2ProjectID)
//        projectID = try values.decodeIfPresent(Int.self, forKey: .projectID)
//        projectName = try values.decodeIfPresent(String.self, forKey: .projectName)
//        rooms = try values.decodeIfPresent([Rooms].self, forKey: .rooms)
//        stairs = try values.decodeIfPresent([Stairs].self, forKey: .stairs)
//        pricing = try values.decodeIfPresent([Pricing].self, forKey: .pricing)
//    }
//
//}
//
//struct Products : Codable {
//    let name : String?
//    let qty : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case qty = "qty"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        qty = try values.decodeIfPresent(Double.self, forKey: .qty)
//    }
//
//}
//
//struct Rooms : Codable {
//    let id : Int?
//    let name : String?
//    let products : [Products]?
//    let accessories : [Accessories]?
//    let labor : [Labor]?
//    var sectiontapped=false
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case products = "products"
//        case accessories = "accessories"
//        case labor = "labor"
//        case sectiontapped = "sectiontapped"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        products = try values.decodeIfPresent([Products].self, forKey: .products)
//        accessories = try values.decodeIfPresent([Accessories].self, forKey: .accessories)
//        labor = try values.decodeIfPresent([Labor].self, forKey: .labor)
//        sectiontapped = try values.decodeIfPresent(Bool.self, forKey: .sectiontapped) ?? false
//    }
//
//}
//
//struct Stairs : Codable {
//    let id : Int?
//    let name : String?
//    let products : [Products]?
//    let labor : [Labor]?
//    let accessories : [Accessories]?
//    var sectiontapped=false
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case products = "products"
//        case labor = "labor"
//        case sectiontapped = "sectiontapped"
//        case accessories = "accessories"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        products = try values.decodeIfPresent([Products].self, forKey: .products)
//        labor = try values.decodeIfPresent([Labor].self, forKey: .labor)
//        accessories = try values.decodeIfPresent([Accessories].self, forKey: .accessories)
//        sectiontapped = try values.decodeIfPresent(Bool.self, forKey: .sectiontapped) ?? false
//    }
//
//}
