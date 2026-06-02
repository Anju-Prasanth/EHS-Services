//
//  CustomerListModelClass.swift
//  EHS_Sales
//
//  Created by Anju on 02.05.2023.
//

import Foundation

struct CustomerList : Codable {
    var customerId : Int?
    var appointmentId : Int?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var cellPhoneNumber : String?
    var homePhoneNumber : String?
    var emailAddress : String?
    var addressLineOne : String?
    var addressLineTwo : String?
    var city : String?
    var state : String?
    var zip : String?
    var gateCode : String?
    var crossStreets : String?
    var addressTypeId : Int?
    var appointmentAddressId : Int?

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
        case addressTypeId = "addressTypeId"
        case appointmentAddressId = "appointmentAddressId"
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
        addressTypeId = try values.decodeIfPresent(Int.self, forKey: .addressTypeId)
        appointmentAddressId = try values.decodeIfPresent(Int.self, forKey: .appointmentAddressId)
    }

}
struct AppointmentListAddress : Codable {
    let appointmentAddressId : Int?
    let appointmentId : Int?
    let addressTypeId : Int?
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

        case appointmentAddressId = "appointmentAddressId"
        case appointmentId = "appointmentId"
        case addressTypeId = "addressTypeId"
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
        appointmentAddressId = try values.decodeIfPresent(Int.self, forKey: .appointmentAddressId)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        addressTypeId = try values.decodeIfPresent(Int.self, forKey: .addressTypeId)
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

struct Transaction : Codable {
    let isSuccessful : Bool?
    let transactionAmount : Int?
    let transactionId : String?
    let responseCode : String?
    let messageCode : String?
    let description : String?
    let authCode : String?
    let errorCode : String?
    let errorText : String?
    let generalFailureCode : String?
    let generalFailureDescription : String?
    let  profileId : String?

    enum CodingKeys: String, CodingKey {

        case isSuccessful = "isSuccessful"
        case transactionAmount = "transactionAmount"
        case transactionId = "transactionId"
        case responseCode = "responseCode"
        case messageCode = "messageCode"
        case description = "description"
        case authCode = "authCode"
        case errorCode = "errorCode"
        case errorText = "errorText"
        case generalFailureCode = "generalFailureCode"
        case generalFailureDescription = "generalFailureDescription"
        case profileId = "profileId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        transactionAmount = try values.decodeIfPresent(Int.self, forKey: .transactionAmount)
        transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        messageCode = try values.decodeIfPresent(String.self, forKey: .messageCode)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        authCode = try values.decodeIfPresent(String.self, forKey: .authCode)
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode)
        errorText = try values.decodeIfPresent(String.self, forKey: .errorText)
        generalFailureCode = try values.decodeIfPresent(String.self, forKey: .generalFailureCode)
        generalFailureDescription = try values.decodeIfPresent(String.self, forKey: .generalFailureDescription)
        profileId = try values.decodeIfPresent(String.self, forKey: .profileId)
    }

}
