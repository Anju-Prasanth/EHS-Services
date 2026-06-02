//
//  MeaseureSquareViewModel.swift
//  Express Home
//
//  Created by Anju on 21.06.2023.
//

import Foundation
import Alamofire

public class MeasureSquareViewModel{

    
    var appointmentId=Int()
    
    
    func projects_by_appointmentid(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[MeasureSquareProjectByAppointmentID]?,_ message:String) -> ()){
        
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let token = UserDefaults.standard.value(forKey: "token") as! String
        
        //        let url="https://expressflooringbackend-dev.azurewebsites.net/api/v1.0/MeasureSquare/projects-by-appointment-id/3068"
//        let url="http://expressflooringbackend-test.azurewebsites.net/api/v1.0/MeasureSquare/projects-by-appointment-id/4302"
//        print("url",url)
//        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Loading project details. Please wait…")
//        if !(ClientManager.SharedHM.connectedToNetwork()) {
//            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
//            return
//        }
//        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
//
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers: header).responseJSON { response in
//            //            AF.request(url, method: .get, parameters: nil).responseObject { (response:DataResponse<SalesScheduleAppointmentList>) in
//            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
//            print(response)
//            if let jsonData = response.data {
//                let jsonString = String(data: response.data!, encoding: .utf8)!
//                var salesScheduleList:[MeasureSquareProjectByAppointmentID]!
//                print(jsonString)
//                do {
//                    salesScheduleList = try JSONDecoder().decode([MeasureSquareProjectByAppointmentID].self, from: jsonData)
//                    print("Success!")
//                } catch {
//                    print("Unexpected error: \(error).")
//                }
//                //let salesScheduleList = try? JSONDecoder().decode([MeasureSquareProjectByAppointmentID].self, from: jsonData)
//                print("salesScheduleList",salesScheduleList)
//                completion(true,salesScheduleList,"Project details fetched successfully.")
//                return
//            } else {
//                completion(false,nil,"")
//                return
//            }
//
//        }
//    }
    let urlString = "https://expressflooringbackend-test.azurewebsites.net/api/v1.0/MeasureSquare/projects-by-appointment-id/\(appointmentId)"
       
       guard let url = URL(string: urlString) else {
           completion(false, nil, "Invalid URL")
           return
       }
       
       let header: [String: String] = ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
       
       var request = URLRequest(url: url)
       request.httpMethod = "GET"
       for (key, value) in header {
           request.setValue(value, forHTTPHeaderField: key)
       }
       
       ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Loading project details. Please wait…")
       
       URLSession.shared.dataTask(with: request) { data, response, error in
           DispatchQueue.main.async {
               ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
           }
           if let error = error {
               completion(false, nil, "Error: \(error.localizedDescription)")
               return
           }
           
           guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
               completion(false, nil, "Invalid response")
               return
           }
           
           guard let jsonData = data else {
               completion(false, nil, "No data in response")
               return
           }
           
           do {
               let salesScheduleList = try JSONDecoder().decode([MeasureSquareProjectByAppointmentID].self, from: jsonData)
               completion(true, salesScheduleList, "")
           } catch {
               completion(false, nil, "Error decoding JSON: \(error)")
           }
       }.resume()
   }
 
}
