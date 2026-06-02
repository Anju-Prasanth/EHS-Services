//
//  NotesModel.swift
//  Express Home
//
//  Created by Bincy C A on 18/05/23.
//

import Foundation
import Alamofire

class NotesModel:Codable
{
    var appointmentNoteId:Int?
    var appointmentId:Int?
    var noteTypeId:Int?
    var note:String?
    var createdDateUTC:String?
    
    enum CodingKeys: String, CodingKey
    {
        case appointmentNoteId = "appointmentNoteId"
        case appointmentId = "appointmentId"
        case noteTypeId = "noteTypeId"
        case note = "note"
        case createdDateUTC = "createdDateUtc"
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appointmentNoteId = try? values.decodeIfPresent(Int.self, forKey: .appointmentNoteId)
        appointmentId = try? values.decodeIfPresent(Int.self, forKey: .appointmentId)
        noteTypeId = try? values.decodeIfPresent(Int.self, forKey: .noteTypeId)
        note = try? values.decodeIfPresent(String.self, forKey: .note)
        createdDateUTC = try? values.decodeIfPresent(String.self, forKey: .createdDateUTC)
    }
    
}

public class NoteViewModel{
    
    // creating Notes
    
    
    func noteCreateapi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:NotesModel?,_ message:String) -> ()){
        let data = AppURL.appointmentNotes
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Creating notes. Please wait...")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
        //            .responseJSON { response in
        //            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        //            print(response)
        //            if let jsonData = response.data {
        //                let jsonString = String(data: response.data!, encoding: .utf8)!
        //                print(jsonString)
        //                let notesList = try? JSONDecoder().decode(NotesModel.self, from: jsonData)
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
                ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
                switch response.result {
                case .success:
                    // Handle successful response
                    if let jsonData = response.data {
                        let jsonString = String(data: response.data!, encoding: .utf8)!
                        print(jsonString)
                        do {
                            let decodedData = try? JSONDecoder().decode(NotesModel.self, from: jsonData)
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
    
    // Updating Notes
    
    func noteUpdateapi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:NotesModel?,_ message:String) -> ())
    {
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let data = AppURL.appointmentNotes
        let url = data
        ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Updating notes. Please Wait...")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default ,headers: header)
        //            .responseJSON { response in
        //            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        //            print(response)
        //            if let jsonData = response.data {
        //                let jsonString = String(data: response.data!, encoding: .utf8)!
        //                print(jsonString)
        //                let notesList = try? JSONDecoder().decode(NotesModel.self, from: jsonData)
        //                completion(true,notesList,"Notes Updated  Successfully")
        //                return
        //            } else {
        //                completion(false,nil,"Notes Creation Failed")
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
                            let decodedData = try? JSONDecoder().decode(NotesModel.self, from: jsonData)
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
    // get appointment notes by id
    func getAppointmentNotesapi(parameters:[String:Any], completion : @escaping (_ success:Bool,_ object:[NotesModel]?,_ message:String) -> ())
    {
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
        let url = AppURL.getAppointmentNotes + "\(appointmentId)"
        //ClientManager.SharedHM.showhideHUD(viewtype: .SHOW, title: "Fetching appointment notes.")
        if !(ClientManager.SharedHM.connectedToNetwork()) {
            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
            completion(false,nil, AppAlertMsg.netWorkAlertMessage)
            return
        }
        let header:HTTPHeaders = ["Authorization":"Bearer "+token ,"Content-Type":"application/json"]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default ,headers: header)
        //            .responseJSON { response in
        //            ClientManager.SharedHM.showhideHUD(viewtype: .HIDE, title: "")
        //            print(response)
        //            if let jsonData = response.data {
        //                let jsonString = String(data: response.data!, encoding: .utf8)!
        //                print(jsonString)
        //                let notesList = try? JSONDecoder().decode([NotesModel].self, from: jsonData)
        //                completion(true,notesList,"Notes Fetched  Successfully")
        //                return
        //            } else {
        //                completion(false,nil,"Notes Fetched Failed")
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
                            let decodedData = try? JSONDecoder().decode([NotesModel].self, from: jsonData)
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

