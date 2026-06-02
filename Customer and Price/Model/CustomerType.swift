//
//  CustomerType.swift
//  Express Home
//
//  Created by Bincy C A on 23/05/23.
//

import Foundation
import Alamofire


class CustomerTypeModel:Codable
{
    var customerTypeId:Int?
    var customerTypeName:String?
    var customerTypeCommissionTier:Double?
    var customerTypeAdditionalCommissionTier:Double?
    var customerTypeCommissionTierDisplayName:String?
    
    enum CodingKeys: String, CodingKey
    {
        case customerTypeId = "customerTypeId"
        case customerTypeName = "customerTypeName"
        case customerTypeCommissionTier = "customerTypeCommissionTier"
        case customerTypeAdditionalCommissionTier = "customerTypeAdditionalCommissionTier"
        case customerTypeCommissionTierDisplayName = "customerTypeCommissionTierDisplayName"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customerTypeId = try? values.decodeIfPresent(Int.self, forKey: .customerTypeId)
        customerTypeName = try? values.decodeIfPresent(String.self, forKey: .customerTypeName)
        customerTypeCommissionTier = try? values.decodeIfPresent(Double.self, forKey: .customerTypeCommissionTier)
        customerTypeAdditionalCommissionTier = try? values.decodeIfPresent(Double.self, forKey: .customerTypeAdditionalCommissionTier)
        customerTypeCommissionTierDisplayName = try? values.decodeIfPresent(String.self, forKey: .customerTypeCommissionTierDisplayName)
    }
    
}

public class CustomerTypeViewModel
{
    var token = UserDefaults.standard.value(forKey: "token") as! String
    
    func customerTypeApi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:CustomerTypeModel?,_ message:String) -> ()){
        
        let data = AppURL.customerTypes
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Creating notes. Please wait...")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
//            .responseJSON { response in
//            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//            print(response)
//            if let jsonData = response.data {
//                let jsonString = String(data: response.data!, encoding: .utf8)!
//                print(jsonString)
//                let notesList = try? JSONDecoder().decode(CustomerTypeModel.self, from: jsonData)
//                completion(true,notesList,"Notes Created Successfully")
//                return
//            } else {
//                completion(false,nil,"Notes Creation Failed")
//                return
//            }
//
//        }
        
            .validate() // Add validation
            .responseJSON { response in
                switch response.result {
                case .success:
                    // Handle successful response
                    if let jsonData = response.data {
                        let jsonString = String(data: response.data!, encoding: .utf8)!
                        print(jsonString)
                        do {
                            let decodedData = try? JSONDecoder().decode(CustomerTypeModel.self, from: jsonData)
                                completion(true, decodedData, "Notes Created Successfully")
                        } catch {
                            completion(false, nil, jsonString)
                        }
                    }
                case .failure(let error):
                    // Handle failure
                    print("Error: \(error)")
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                        completion(false, nil, responseString)
                    }
                }
            }
    }
    
}
