//
//  DispositionModelClass.swift
//  Express Home
//
//  Created by Anju on 25.10.2023.
//

import Foundation

struct DispositionModelClass : Codable {
    let id : Int?
    let resultName : String?
    let resultDetails : [ResultDetails]?
    let isSoldType:Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case resultName = "resultName"
        case resultDetails = "resultDetails"
        case isSoldType = "isSoldType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        resultName = try values.decodeIfPresent(String.self, forKey: .resultName)
        resultDetails = try values.decodeIfPresent([ResultDetails].self, forKey: .resultDetails)
        isSoldType = try values.decodeIfPresent(Bool.self, forKey: .isSoldType)
    }

}
struct ResultDetails : Codable {
    let id : Int?
    let detailName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case detailName = "detailName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        detailName = try values.decodeIfPresent(String.self, forKey: .detailName)
    }
}
struct DispositionSave : Codable {
    let success : String?
    let message : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        success = try values.decodeIfPresent(String.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
    }
}
        
        struct DocumentUpload : Codable {
                let success : String?
                let clinicaldocumentid : Int?
                

                enum CodingKeys: String, CodingKey {

                    case success = "success"
                    case clinicaldocumentid = "clinicaldocumentid"
                   
                }

                init(from decoder: Decoder) throws {
                    let values = try decoder.container(keyedBy: CodingKeys.self)
                   
                    success = try values.decodeIfPresent(String.self, forKey: .success)
                    clinicaldocumentid = try values.decodeIfPresent(Int.self, forKey: .clinicaldocumentid)
                   
                }

    }


