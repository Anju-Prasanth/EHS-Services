//
//  CustomerUpdateModelclass.swift
//  EHS_Sales
//
//  Created by Anju on 11.05.2023.
//

import Foundation

struct CustomerUpdate : Codable {
    let customerId : Int?
    let appointmentId : Int?
    let firstName : String?
    let middleName : String?
    let lastName : String?
    let cellPhoneNumber : String?
    let homePhoneNumber : String?
    let emailAddress : String?
    let addressLineOne : String?
    let addressLineTwo : String?
    let city : String?
    let state : String?
    let zip : String?
    let gateCode : String?
    let crossStreets : String?

    enum CodingKeys: String, CodingKey {

        case customerId = "customerId"
        case appointmentId = "appointmentId"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case cellPhoneNumber = "cellPhoneNumber"
        case homePhoneNumber = "homePhoneNumber"
        case emailAddress = "emailAddress"
        case addressLineOne = "addressLineOne"
        case addressLineTwo = "addressLineTwo"
        case city = "city"
        case state = "state"
        case zip = "zip"
        case gateCode = "gateCode"
        case crossStreets = "crossStreets"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        cellPhoneNumber = try values.decodeIfPresent(String.self, forKey: .cellPhoneNumber)
        homePhoneNumber = try values.decodeIfPresent(String.self, forKey: .homePhoneNumber)
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress)
        addressLineOne = try values.decodeIfPresent(String.self, forKey: .addressLineOne)
        addressLineTwo = try values.decodeIfPresent(String.self, forKey: .addressLineTwo)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        gateCode = try values.decodeIfPresent(String.self, forKey: .gateCode)
        crossStreets = try values.decodeIfPresent(String.self, forKey: .crossStreets)
    }

}
struct CustomerUpdateAdress : Codable {
    let appointmentAddressId : Int?
    let addressTypeId : Int?
    let appointmentId : Int?
    let firstName : String?
    let middleName : String?
    let lastName : String?
    let cellPhoneNumber : String?
    let homePhoneNumber : String?
    let emailAddress : String?
    let addressLineOne : String?
    let addressLineTwo : String?
    let city : String?
    let state : String?
    let zip : String?
    let gateCode : String?
    let crossStreets : String?

    enum CodingKeys: String, CodingKey {

       
        case appointmentId = "appointmentId"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case cellPhoneNumber = "cellPhoneNumber"
        case homePhoneNumber = "homePhoneNumber"
        case emailAddress = "emailAddress"
        case addressLineOne = "addressLineOne"
        case addressLineTwo = "addressLineTwo"
        case city = "city"
        case state = "state"
        case zip = "zip"
        case gateCode = "gateCode"
        case crossStreets = "crossStreets"
        case appointmentAddressId = "appointmentAddressId"
        case addressTypeId = "addressTypeId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        cellPhoneNumber = try values.decodeIfPresent(String.self, forKey: .cellPhoneNumber)
        homePhoneNumber = try values.decodeIfPresent(String.self, forKey: .homePhoneNumber)
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress)
        addressLineOne = try values.decodeIfPresent(String.self, forKey: .addressLineOne)
        addressLineTwo = try values.decodeIfPresent(String.self, forKey: .addressLineTwo)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        gateCode = try values.decodeIfPresent(String.self, forKey: .gateCode)
        crossStreets = try values.decodeIfPresent(String.self, forKey: .crossStreets)
        appointmentAddressId = try values.decodeIfPresent(Int.self, forKey: .appointmentAddressId)
        addressTypeId = try values.decodeIfPresent(Int.self, forKey: .addressTypeId)
    }

}
