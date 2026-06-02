//
//  CustomerlistViewModel.swift
//  EHS_Sales
//
//  Created by Anju on 02.05.2023.
//

import Foundation
import Alamofire

public class customerListViewModel{

    
    var appointmentId=Int()
    var token = UserDefaults.standard.value(forKey: "token") as! String
    
    func customer_list_by_appointmentid(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[CustomerList]?,_ message:String) -> ()){
        let data = AppURL.by_appointment_id
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let url="https://expressflooringbackend-test.azurewebsites.net/api/v1.0/Customers/by-appointment-id/"+String(appointmentId)
    print("url",url)
    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Loading customer details. Please wait…")
    if !(ClientManager.SharedHM.connectedToNetwork()) {
        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
        return
    }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers: header)
            //.responseJSON { response in
//            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let salesScheduleList = try? JSONDecoder().decode([CustomerList].self, from: jsonData)
//
//                completion(true,salesScheduleList,"Customer list fetched successfully")
//                return
//        } else {
//            completion(false,nil,"Customer list fetching failed")
//            return
//        }
//
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
                            let decodedData = try? JSONDecoder().decode([CustomerList].self, from: jsonData)
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

    
    
    func AppointmentAddresses_byappointmentid(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[CustomerList]?,_ message:String) -> ()){
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let data = AppURL.appointmentAdress_byappointmentid+"\(appointmentId)"
    let url = data
    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Loading customer details. Please wait…")
    if !(ClientManager.SharedHM.connectedToNetwork()) {
        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
        return
    }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers: header)
            //.responseJSON { response in
//            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let appointmentAddress = try? JSONDecoder().decode([CustomerList].self, from: jsonData)
//
//                completion(true,appointmentAddress,"AppointmentAddress fetched successfully")
//                return
//        } else {
//            completion(false,nil,"AppointmentAddress fetching failed.")
//            return
//        }
//
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
                            let decodedData = try? JSONDecoder().decode([CustomerList].self, from: jsonData)
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

    
    
    func transactionApi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:Transaction?,_ message:String) -> ()){
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let token = UserDefaults.standard.value(forKey: "token") as! String
        
        let data = AppURL.Transactioncreate
    let url = data
    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Processing payment. Please wait...")
    if !(ClientManager.SharedHM.connectedToNetwork()) {
        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
        return
    }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
            //.responseJSON { response in
//            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData)
//
//                completion(true,transaction,"Transaction successfull")
//                return
//        } else {
//            completion(false,nil,"Transaction failed.")
//            return
//        }
//
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
                            let decodedData = try? JSONDecoder().decode(Transaction.self, from: jsonData)
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
    func balncetransactionApi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:Transaction?,_ message:String) -> ()){
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let token = UserDefaults.standard.value(forKey: "token") as! String
        
        let data = AppURL.BalanceTransactioncreate
    let url = data
    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Processing payment. Please wait...")
    if !(ClientManager.SharedHM.connectedToNetwork()) {
        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
        return
    }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
            //.responseJSON { response in
//            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData)
//
//                completion(true,transaction,"Transaction successfull")
//                return
//        } else {
//            completion(false,nil,"Transaction failed.")
//            return
//        }
//
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
                            let decodedData = try? JSONDecoder().decode(Transaction.self, from: jsonData)
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
    func ACHtransactionApi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:Transaction?,_ message:String) -> ()){
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let token = UserDefaults.standard.value(forKey: "token") as! String
        
        let data = AppURL.ACHTransactioncreate
    let url = data
    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Processing payment. Please wait...")
    if !(ClientManager.SharedHM.connectedToNetwork()) {
        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
        return
    }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
            //.responseJSON { response in
//            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData)
//
//                completion(true,transaction,"Transaction successfull")
//                return
//        } else {
//            completion(false,nil,"Transaction failed.")
//            return
//        }
//
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
                            let decodedData = try? JSONDecoder().decode(Transaction.self, from: jsonData)
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
    func BalanceACHtransactionApi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:Transaction?,_ message:String) -> ()){
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let token = UserDefaults.standard.value(forKey: "token") as! String
        
        let data = AppURL.BalanceACHTransactioncreate
    let url = data
    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Processing payment. Please wait...")
    if !(ClientManager.SharedHM.connectedToNetwork()) {
        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
        return
    }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
            //.responseJSON { response in
//            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let transaction = try? JSONDecoder().decode(Transaction.self, from: jsonData)
//
//                completion(true,transaction,"Transaction successfull")
//                return
//        } else {
//            completion(false,nil,"Transaction failed.")
//            return
//        }
//
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
                            let decodedData = try? JSONDecoder().decode(Transaction.self, from: jsonData)
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


    func Design_ConsultantapiForAddress(parameters:[String:String], completion : @escaping (_ success:Bool,_ object:[CustomerList]?,_ message:String) -> ()){
        let data = AppURL.by_design_consultant
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Loading customer details. Please wait…")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers: header)
        //.responseJSON { response in
        //            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
        //        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        //        print(response)
        //        if let jsonData = response.data {
        //            let jsonString = String(data: response.data!, encoding: .utf8)!
        //            print(jsonString)
        //            let salesScheduleList = try? JSONDecoder().decode([CustomerList].self, from: jsonData)
        //
        //                completion(true,salesScheduleList,"")
        //                return
        //        } else {
        //            completion(false,nil,"")
        //            return
        //        }
        //
        //    }
        //}
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
                            let decodedData = try? JSONDecoder().decode([CustomerList].self, from: jsonData)
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
