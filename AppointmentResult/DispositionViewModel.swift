//
//  DispositionViewModel.swift
//  Express Home
//
//  Created by Anju on 25.10.2023.
//

import Foundation
import Alamofire


public class DispositionViewModel{
    var token = UserDefaults.standard.value(forKey: "token") as! String
    
    func disposition_types(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[DispositionModelClass]?,_ message:String) -> ()){
        let data = AppURL.disposition_types
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Updating disposition details.Please wait...")
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
//                let dispositiopnTypes = try? JSONDecoder().decode([DispositionModelClass].self, from: jsonData)
//
//                completion(true,dispositiopnTypes,"Disposition Details Fetched Successfully")
//                return
//            } else {
//                completion(false,nil,"Disposition Details Fetching Failed")
//                return
//            }
//
//        }
        
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
                            let decodedData = try? JSONDecoder().decode([DispositionModelClass].self, from: jsonData)
                                completion(true, decodedData, "Disposition Details Fetched Successfully")
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
    
    func save_disposition(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[DispositionSave]?,_ message:String) -> ()){
        let data = AppURL.save_disposition
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Submitting disposition details.Please wait...")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
//            .responseJSON { response in
//            //            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//            print(response)
//            if let jsonData = response.data {
//                let jsonString = String(data: response.data!, encoding: .utf8)!
//                print(jsonString)
//                let dispositiopnSave = try? JSONDecoder().decode([DispositionSave].self, from: jsonData)
//
//                completion(true,dispositiopnSave,"Disposition Details Submitted Successfully")
//                return
//            } else {
//                completion(false,nil,"Disposition Details Submission Failed")
//                return
//            }
//
//        }
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
                            let decodedData = try? JSONDecoder().decode([DispositionSave].self, from: jsonData)
                                completion(true, decodedData, "Disposition Details Submitted Successfully")
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
    
    func save_dispositionAfterprojectSelect(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[DispositionSave]?,_ message:String) -> ()){
        let data = AppURL.save_disposition
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Submitting disposition details.Please wait...")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
//            .responseJSON { response in
//            //            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//            print(response)
//            if let jsonData = response.data {
//                let jsonString = String(data: response.data!, encoding: .utf8)!
//                print(jsonString)
//                let dispositiopnSave = try? JSONDecoder().decode([DispositionSave].self, from: jsonData)
//
//                completion(true,dispositiopnSave,"Disposition Details Submitted Successfully")
//                return
//            } else {
//                completion(false,nil,"Disposition Details Submission Failed")
//                return
//            }
//
//        }
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
                            let decodedData = try? JSONDecoder().decode([DispositionSave].self, from: jsonData)
                                completion(true, decodedData, "Disposition Details Submitted Successfully")
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
    func documentupload(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[DocumentUpload]?,_ message:String) -> ()){
            let data = "https://api.preview.platform.athenahealth.com/v1/\(195900)/patients/\(55751)/documents/clinicaldocument"
            let url = data
        let filePath = URL(string: "file:///Users/satheeshbek/Library/Developer/CoreSimulator/Devices/D2BE68D6-3BF6-4675-9C12-5B86311E6CAE/data/Containers/Data/Application/96C3C712-1D48-4E4D-A6DD-0A7924D1BA49/tmp/TheraScriptRx.pdf")
        let fileData = NSData(contentsOf: filePath!)
        let fileStream:String!=fileData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        var decodedString=String()
        if let decodedData = Data(base64Encoded: fileStream) {
            decodedString = String(data: decodedData, encoding: .utf8)!
        }
        let parameters = ["documentsubclass": "MENTALHEALTH",
            "departmentid": 21,
            "attachmenttype": "PDF",
            "originalfilename": "testdocument",
            "attachmentcontents": decodedString ?? ""] as [String : Any]
        
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            if !(ClientManager.SharedHM.connectedToNetwork()) {
                ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
                completion(false,nil, AppAlertMsg.netWorkAlertMessage)
                return
            }
        let headers:HTTPHeaders = [
                "Authorization": "Bearer hQrQSyGZcsKSEIxCDGTJwGJiby4R",
            ]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: headers)
            .responseJSON { response in
                //            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
                ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
                print(response)
                if let jsonData = response.data {
                    let jsonString = String(data: response.data!, encoding: .utf8)!
                    print(jsonString)
                    let dispositiopnSave = try? JSONDecoder().decode([DocumentUpload].self, from: jsonData)
                    
                    completion(true,dispositiopnSave,"Disposition Details Submitted Successfully")
                    return
                } else {
                    completion(false,nil,"Disposition Details Submission Failed")
                    return
                }
                
            }
        }
    }

