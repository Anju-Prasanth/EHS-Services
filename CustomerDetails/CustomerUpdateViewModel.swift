//
//  CustomerUpdateViewModel.swift
//  EHS_Sales
//
//  Created by Anju on 11.05.2023.
//
import Foundation
import Alamofire

public class customerUpdateViewModel{

    
    var appointmentId=Int()
    
    
//    func customer_update(rawdata:[String:Any], completion : @escaping (_ success:Bool,_ object:[CustomerUpdate]?,_ message:String) -> ()){
//        let data = AppURL.customer_update
//        appointmentId=0
//        let url=data
//    print("url",url)
//    ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "")
//    if !(ClientManager.SharedHM.connectedToNetwork()) {
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        completion(false,nil, AppAlertMsg.netWorkAlertMessage)
//        return
//    }
//        AF.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default ,headers: nil).responseJSON { response in
////            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//        ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//        print(response)
//        if let jsonData = response.data {
//            let jsonString = String(data: response.data!, encoding: .utf8)!
//            print(jsonString)
//            let customerUpdateResult = try? JSONDecoder().decode([CustomerUpdate].self, from: jsonData)
//
//                completion(true,customerUpdateResult,"Customer list fetched successfully")
//                return
//        } else {
//            completion(false,nil,"Customer list fetching failed")
//            return
//        }
//
//    }
//}
    
    func customer_update(rawdata:[String:Any],completion : @escaping (_ success:Bool,_ object:CustomerList?,_ message:String) -> ()){
       // let data = AppURL.mark_as_confirmed
//        let rawData: [String: Any] = [
//            "customerId": 3,
//              "appointmentId": 3,
//              "firstName": "string",
//              "middleName": "string",
//              "lastName": "string",
//              "cellPhoneNumber": "string",
//              "homePhoneNumber": "string",
//              "emailAddress": "string",
//              "addressLineOne": "string",
//              "addressLineTwo": "string",
//              "city": "string",
//              "state": "string",
//              "zip": "string",
//              "gateCode": "string",
//              "crossStreets": "string"
//        ]
        let passeddata=rawdata

        let url=AppURL.customer_update
        let ulr =  NSURL(string:url as String)
         var request = URLRequest(url: ulr! as URL)
        
        
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONSerialization.data(withJSONObject: passeddata, options: JSONSerialization.WritingOptions.prettyPrinted)

                   let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                   if let json = json {
                       print(json)
                   }
                   request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);


                      AF.request(request)
                       .responseJSON { response in
                           // do whatever you want here
                          print(response.request)
                          print(response.response)
                          print(response.data)
                          print(response.result)

                           if let jsonData = response.data {
                               let jsonString = String(data: response.data!, encoding: .utf8)!
                               print(jsonString)
                               let customerList = try? JSONDecoder().decode(CustomerList.self, from: jsonData)
                               
                                   completion(true,customerList,"Confirmed successfully")
                                   return
                           } else {
                               completion(false,nil,"Confirmation failed")
                               return
                           }
                           
                       }

                   }
        
    
    func customer_updateAdress(rawdata:[String:Any],apppointmentAddressId:Int,completion : @escaping (_ success:Bool,_ object:CustomerList?,_ message:String) -> ()){
       // let data = AppURL.mark_as_confirmed
//        let rawData: [String: Any] = [
//            "customerId": 3,
//              "appointmentId": 3,
//              "firstName": "string",
//              "middleName": "string",
//              "lastName": "string",
//              "cellPhoneNumber": "string",
//              "homePhoneNumber": "string",
//              "emailAddress": "string",
//              "addressLineOne": "string",
//              "addressLineTwo": "string",
//              "city": "string",
//              "state": "string",
//              "zip": "string",
//              "gateCode": "string",
//              "crossStreets": "string"
//        ]
        let passeddata=rawdata

        let url=AppURL.AppointmentAddresses
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Updating address details. Please wait...")
        let ulr =  NSURL(string:url as String)
         var request = URLRequest(url: ulr! as URL)
        if apppointmentAddressId==0{
            request.httpMethod = "PUT"
        }else{
            request.httpMethod = "PATCH"
        }
        var token = UserDefaults.standard.value(forKey: "token") as! String
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let data = try! JSONSerialization.data(withJSONObject: passeddata, options: JSONSerialization.WritingOptions.prettyPrinted)

                   let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                   if let json = json {
                       print(json)
                   }
                   request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);


        AF.request(request)
                       .responseJSON { response in
                           // do whatever you want here
                          print(response.request)
                          print(response.response)
                          print(response.data)
                          print(response.result)
                           ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
                           if let jsonData = response.data {
                               let jsonString = String(data: response.data!, encoding: .utf8)!
                               print(jsonString)
                               let customerList = try? JSONDecoder().decode(CustomerList.self, from: jsonData)
                               
                                   completion(true,customerList,"")
                                   return
                           } else {
                               completion(false,nil,"")
                               return
                           }
                           
                       }

                   }
    func save_Adress(rawdata:[String:Any],apppointmentAddressId:Int,completion : @escaping (_ success:Bool,_ object:CustomerList?,_ message:String) -> ()){
       // let data = AppURL.mark_as_confirmed
//        let rawData: [String: Any] = [
//            "customerId": 3,
//              "appointmentId": 3,
//              "firstName": "string",
//              "middleName": "string",
//              "lastName": "string",
//              "cellPhoneNumber": "string",
//              "homePhoneNumber": "string",
//              "emailAddress": "string",
//              "addressLineOne": "string",
//              "addressLineTwo": "string",
//              "city": "string",
//              "state": "string",
//              "zip": "string",
//              "gateCode": "string",
//              "crossStreets": "string"
//        ]
        let passeddata=rawdata

        let url=AppURL.AppointmentAddresses
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Updating address details. Please wait...")
        let ulr =  NSURL(string:url as String)
         var request = URLRequest(url: ulr! as URL)
        
        if apppointmentAddressId==0{
            request.httpMethod = "PUT"
        }else{
            request.httpMethod = "PATCH"
        }
        
        var token = UserDefaults.standard.value(forKey: "token") as! String
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let data = try! JSONSerialization.data(withJSONObject: passeddata, options: JSONSerialization.WritingOptions.prettyPrinted)

                   let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                   if let json = json {
                       print(json)
                   }
                   request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);


        AF.request(request)
                       .responseJSON { response in
                           // do whatever you want here
                          print(response.request)
                          print(response.response)
                          print(response.data)
                          print(response.result)
                           ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
                           if let jsonData = response.data {
                               let jsonString = String(data: response.data!, encoding: .utf8)!
                               print(jsonString)
                               let customerList = try? JSONDecoder().decode(CustomerList.self, from: jsonData)
                               
                                   completion(true,customerList,"")
                                   return
                           } else {
                               completion(false,nil,"")
                               return
                           }
                           
                       }

                   }
}
    
    


   

