//
//  FinanceProviderViewModel.swift
//  Express Home
//
//  Created by Anju on 22.05.2023.
//

import Foundation
import Alamofire

public class FinanceProviderViewModel{
    var token = UserDefaults.standard.value(forKey: "token") as! String
    
    func finance_provider(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[FinanceProvider]?,_ message:String) -> ()){
        let data = AppURL.finance_providers
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Updating finance details. Please wait...")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers: header)
        //            .responseJSON { response in
        //            //            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
        //            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        //            print(response)
        //            if let jsonData = response.data {
        //                let jsonString = String(data: response.data!, encoding: .utf8)!
        //                print(jsonString)
        //                let promocodes = try? JSONDecoder().decode([FinanceProvider].self, from: jsonData)
        //
        //                completion(true,promocodes,"Finance details fetched successfully")
        //                return
        //            } else {
        //                completion(false,nil,"No finance details added")
        //                return
        //            }
        //
        //        }
        //    }
            .validate() // Add validation
            .responseJSON { response in
                ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
                switch response.result {
                case .success:
                    // Handle successful response
                    if let jsonData = response.data {
                        let jsonString = String(data: response.data!, encoding: .utf8)!
                        print(jsonString)
                        do {
                            let decodedData = try? JSONDecoder().decode([FinanceProvider].self, from: jsonData)
                            completion(true, decodedData, "")
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
