//
//  CustomerDetailsEditViewController.swift
//  EHS_Sales
//
//  Created by Anju on 04.04.2023.
//

import UIKit

class CustomerDetailsEditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    static func initialization() -> CustomerDetailsEditViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerDetailsEditViewController") as? CustomerDetailsEditViewController
    }
    @IBOutlet weak var customerEditTableView: UITableView!
    var customerlistViewModel=customerListViewModel()
    var customerlist=[CustomerList]()
    var salesViewModel=salesSchedulesViewmodel()
    var appointmentList=[CustomerList]()
    var billingAddress=[CustomerList]()
    var mailingAdresss=[CustomerList]()
    var locationAdresss=[CustomerList]()
    var create:Bool?
    var customerupdateViewModel=customerUpdateViewModel()
    var isfirSttimeLoaded=false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden=true
        customerEditTableView.register(UINib(nibName: "AddressHeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressHeadingTableViewCell")
        self.setNavigationBarbacklogoResetAndNext(name: "Customer Details")
        
        
        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillAppear(_ animated: Bool){
    //        let parameters = [String:Any]()
    //        customerlistViewModel.customer_list_by_appointmentid(parameters: parameters) { success, customerList, message in
    //            if success{
    //            self.customerDetails(data: customerList ?? [])
    //            }else{
    //
    //            }
    //
    //                }
    //    }
    
    
    override func viewWillAppear(_ animated: Bool){
        
        //            refreshMSALToken()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appCameToForeGround(notification:)),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
        if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
        {
            tokenexpirationCheck()
            
        }
        
    }
    
    func tokenexpirationCheck(){
        var token = UserDefaults.standard.value(forKey: "token") as! String
        print("token",token)
        var payload64 = token.components(separatedBy: ".")[1]
        
        // need to pad the string with = to make it divisible by 4,
        // otherwise Data won't be able to decode it
        while payload64.count % 4 != 0 {
            payload64 += "="
        }
        
        print("base64 encoded payload: \(payload64)")
        let payloadData = Data(base64Encoded: payload64,
                               options:.ignoreUnknownCharacters)!
        let payload = String(data: payloadData, encoding: .utf8)!
        print(payload)
        
        let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
        let exp = json["exp"] as! Int
        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
        let isValid = expDate.compare(Date()) == .orderedDescending
        print(isValid)
        if isValid{
            appointmentAdressApiCall()
        }else{
            intializeMSAL(isfromLoggedOut: false)
            
        }
    }
    @objc override func refreshTokenCheck(notification: Notification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let token = dict["token"] as? Int{
                UserDefaults.standard.set(token, forKey: "token")
                appointmentAdressApiCall()
            }
        }
        
    }
    
    @objc override func appCameToForeGround(notification: Notification) {
        if customerlist.count==0{
            
            if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
            {
                tokenexpirationCheck()
            }
        }
        
    }
    
    func appointmentAdressApiCall(){
        let parameters = [String:Any]()
        customerlistViewModel.AppointmentAddresses_byappointmentid(parameters: parameters) { success, customerList, message in
            if success{
                self.customerDetails(data: customerList ?? [])
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.appointmentAdressApiCall()
                    }
                    
                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                }else{
                    self.showAlertOk(message: message)
                }
            }
            
        }
    }
    
    
    //    override func performSegueToReturnBack(){
    //        let financeSummary = Finance_summaryViewController.initialization()!
    //
    //        self.navigationController?.pushViewController(financeSummary, animated: true)
    //    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return locationAdresss.count
        case 2:
            return 1
        case 3:
            return billingAddress.count
        case 4:
            return 1
        case 5:
            return mailingAdresss.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressHeadingTableViewCell") as! AddressHeadingTableViewCell
            cell.adressTypeLabel.text="LOCATION ADDRESS"
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerEditTableViewCell") as! CustomerEditTableViewCell
            //        if indexPath.row==0{
            //            cell.customerLbl.text="(Customer 1)"
            //        }else{
            //            cell.customerLbl.text="(Customer 2)"
            //        }
            var nameString=""
            var addressString=""
            
            if locationAdresss[indexPath.row].firstName != nil {
                nameString = nameString + locationAdresss[indexPath.row].firstName! + " "
            }
            if locationAdresss[indexPath.row].middleName != nil {
                nameString = nameString + locationAdresss[indexPath.row].middleName! + " "
            }
            if locationAdresss[indexPath.row].lastName != nil {
                nameString = nameString + locationAdresss[indexPath.row].lastName!
            }
            cell.customernameLbl.text=nameString
            
            if locationAdresss[indexPath.row].addressLineOne != nil {
                addressString = addressString + locationAdresss[indexPath.row].addressLineOne! + ", "
            }
            //            if locationAdresss[indexPath.row].addressLineTwo != nil && locationAdresss[indexPath.row].addressLineTwo != "NULL" {
            //                addressString = addressString + locationAdresss[indexPath.row].addressLineTwo! + ", "
            //            }
            if locationAdresss[indexPath.row].city != nil {
                addressString = addressString + locationAdresss[indexPath.row].city! + ", "
                cell.cityNameLbl.text=locationAdresss[indexPath.row].city!
            }
            if locationAdresss[indexPath.row].state != nil {
                addressString = addressString + locationAdresss[indexPath.row].state! + ", "
                cell.stateNameLbl.text=locationAdresss[indexPath.row].state!
            }
            if locationAdresss[indexPath.row].zip != nil {
                addressString = addressString + locationAdresss[indexPath.row].zip!
                cell.zipNameLbl.text=locationAdresss[indexPath.row].zip!
            }
            cell.customerLocation.text=addressString
            if locationAdresss[indexPath.row].emailAddress != nil{
                cell.customerEmailAdressLbl.text=locationAdresss[indexPath.row].emailAddress
                cell.customeremailLblHeight.constant=30
                cell.locationTopConstraint.constant=35
            }else{
                cell.customeremailLblHeight.constant=0
                cell.locationTopConstraint.constant=20
                
            }
            
            
            if (locationAdresss[indexPath.row].gateCode == nil||locationAdresss[indexPath.row].gateCode == "") && (locationAdresss[indexPath.row].crossStreets == nil||locationAdresss[indexPath.row].crossStreets == "")||locationAdresss[indexPath.row].gateCode == "NULL"&&locationAdresss[indexPath.row].crossStreets == "NULL"{
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=true
                cell.gateCodeLbl.isHidden=true
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=0
            }else if (locationAdresss[indexPath.row].gateCode == nil||locationAdresss[indexPath.row].gateCode == ""||locationAdresss[indexPath.row].gateCode == "NULL")&&(locationAdresss[indexPath.row].crossStreets != nil||locationAdresss[indexPath.row].crossStreets != ""||locationAdresss[indexPath.row].crossStreets != "NULL"){
                
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=false
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.isHidden=false
                cell.gateCodeLbl.text="Cross Street: " + (locationAdresss[indexPath.row].crossStreets ?? "")
            }else if (locationAdresss[indexPath.row].gateCode != nil||locationAdresss[indexPath.row].gateCode != ""||locationAdresss[indexPath.row].gateCode != "NULL")&&(locationAdresss[indexPath.row].crossStreets == nil||locationAdresss[indexPath.row].crossStreets == ""||locationAdresss[indexPath.row].crossStreets == "NULL"){
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=false
                cell.gateCodeLbl.isHidden=false
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.text="Gate Code: " + (locationAdresss[indexPath.row].gateCode ?? "")
            }else{
                cell.crossStreetView.isHidden=false
                cell.gateCodeView.isHidden=false
                cell.gateCodeLbl.isHidden=false
                cell.crossStreetLbl.isHidden=false
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.text="Gate Code: " + (locationAdresss[indexPath.row].gateCode ?? "")
                cell.crossStreetLbl.text="Cross Street: " + (locationAdresss[indexPath.row].crossStreets ?? "")
            }
            
            
            //        cell.crossStreetLbl.translatesAutoresizingMaskIntoConstraints=true
            //        cell.crossStreetView.translatesAutoresizingMaskIntoConstraints=true
            NSLayoutConstraint.activate([
                cell.crossStreetLbl.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.crossStreetView.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.gateCodeLbl.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.gateCodeView.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0)
            ])
            //        NSLayoutConstraint.activate([
            //
            //            cell.crossStreetLbl.trailingAnchor.constraint(equalTo: cell.editBtn.leadingAnchor, constant: 0),
            //            cell.crossStreetView.trailingAnchor.constraint(equalTo: cell.editBtn.leadingAnchor, constant: 0)
            //           ])
            if (locationAdresss[indexPath.row].cellPhoneNumber == nil||locationAdresss[indexPath.row].cellPhoneNumber == ""||locationAdresss[indexPath.row].cellPhoneNumber == "NULL")&&(locationAdresss[indexPath.row].homePhoneNumber == nil||locationAdresss[indexPath.row].homePhoneNumber == ""||locationAdresss[indexPath.row].homePhoneNumber == "NULL"){
                cell.customerCellPhoneImageView.isHidden=true
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellphoneLbl.isHidden=true
                cell.customerHomePhoneLbl.isHidden=true
                cell.customerCellphoneLbl.isHidden=true
                cell.dashedView.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=0
            }else if (locationAdresss[indexPath.row].cellPhoneNumber == nil||locationAdresss[indexPath.row].cellPhoneNumber == ""||locationAdresss[indexPath.row].cellPhoneNumber == "NULL")&&(locationAdresss[indexPath.row].homePhoneNumber != nil||locationAdresss[indexPath.row].homePhoneNumber != ""||locationAdresss[indexPath.row].homePhoneNumber != "NULL"){
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=46.5
                cell.customerCellphoneLbl.text=locationAdresss[indexPath.row].homePhoneNumber?.toPhoneNumber()
                cell.customerCellPhoneImageView.image=UIImage(named:"home")
                cell.dashedView.isHidden=false
            }else if (locationAdresss[indexPath.row].cellPhoneNumber != ""||locationAdresss[indexPath.row].cellPhoneNumber != nil||locationAdresss[indexPath.row].cellPhoneNumber != "NULL")&&(locationAdresss[indexPath.row].homePhoneNumber == ""||locationAdresss[indexPath.row].homePhoneNumber == nil||locationAdresss[indexPath.row].homePhoneNumber == "NULL"){
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=46.5
                cell.customerCellphoneLbl.text=locationAdresss[indexPath.row].cellPhoneNumber
                cell.customerCellPhoneImageView.image=UIImage(named:"call")
                cell.dashedView.isHidden=false
            }else if locationAdresss[indexPath.row].cellPhoneNumber != nil||locationAdresss[indexPath.row].cellPhoneNumber != ""||locationAdresss[indexPath.row].cellPhoneNumber != "NULL"&&(locationAdresss[indexPath.row].homePhoneNumber != nil||locationAdresss[indexPath.row].homePhoneNumber != ""||locationAdresss[indexPath.row].homePhoneNumber != "NULL") {
                cell.customerHomePhoneImageView.isHidden=false
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=false
                cell.customercellPhoneLblheightConstraint.constant=46.5
                
                cell.customerCellphoneLbl.text=locationAdresss[indexPath.row].cellPhoneNumber
                cell.customerHomePhoneLbl.text=locationAdresss[indexPath.row].homePhoneNumber
                cell.customerCellPhoneImageView.image=UIImage(named:"call")
                cell.customerHomePhoneImageView.image=UIImage(named:"home")
                cell.dashedView.isHidden=false
            }
            cell.editBtn.isHidden=false
            cell.editBtn.tag=indexPath.section
            cell.editBtn.addTarget(self, action: #selector(editBtnAction(sender: )), for: .touchUpInside)
            
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressHeadingTableViewCell") as! AddressHeadingTableViewCell
            cell.adressTypeLabel.text="BILLING ADDRESS"
            return cell
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerEditTableViewCell") as! CustomerEditTableViewCell
            cell.editBtn.isHidden=false
            var nameString=""
            var addressString=""
            
            if billingAddress[indexPath.row].firstName != nil {
                nameString = nameString + billingAddress[indexPath.row].firstName! + " "
            }
            if billingAddress[indexPath.row].middleName != nil {
                nameString = nameString + billingAddress[indexPath.row].middleName! + " "
            }
            if billingAddress[indexPath.row].lastName != nil {
                nameString = nameString + billingAddress[indexPath.row].lastName!
            }
            cell.customernameLbl.text=nameString
            
            if billingAddress[indexPath.row].addressLineOne != nil {
                addressString = addressString + billingAddress[indexPath.row].addressLineOne! + ", "
            }
            //            if billingAddress[indexPath.row].addressLineTwo != nil && billingAddress[indexPath.row].addressLineTwo != "NULL" {
            //                addressString = addressString + billingAddress[indexPath.row].addressLineTwo! + ", "
            //            }
            if billingAddress[indexPath.row].city != nil {
                addressString = addressString + billingAddress[indexPath.row].city! + ", "
                cell.cityNameLbl.text=billingAddress[indexPath.row].city!
            }
            if billingAddress[indexPath.row].state != nil {
                addressString = addressString + billingAddress[indexPath.row].state! + ", "
                cell.stateNameLbl.text=billingAddress[indexPath.row].state!
            }
            if billingAddress[indexPath.row].zip != nil {
                addressString = addressString + billingAddress[indexPath.row].zip!
                cell.zipNameLbl.text=billingAddress[indexPath.row].zip!
            }
            cell.customerLocation.text=addressString
            if billingAddress[indexPath.row].emailAddress != nil{
                cell.customerEmailAdressLbl.text=billingAddress[indexPath.row].emailAddress
                cell.customeremailLblHeight.constant=30
                cell.locationTopConstraint.constant=35
            }else{
                cell.customeremailLblHeight.constant=0
                cell.locationTopConstraint.constant=20
                
            }
            
            
            
            
            
            if (billingAddress[indexPath.row].gateCode == nil||billingAddress[indexPath.row].gateCode == ""||billingAddress[indexPath.row].gateCode == "NULL") && (billingAddress[indexPath.row].crossStreets == nil||billingAddress[indexPath.row].crossStreets == ""||billingAddress[indexPath.row].crossStreets == "NULL"){
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=true
                cell.gateCodeLbl.isHidden=true
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=0
            }else if (billingAddress[indexPath.row].gateCode == nil||billingAddress[indexPath.row].gateCode == ""||billingAddress[indexPath.row].gateCode == "NULL")&&(billingAddress[indexPath.row].crossStreets != nil||billingAddress[indexPath.row].crossStreets != ""||billingAddress[indexPath.row].crossStreets != "NULL"){
                
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=false
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.isHidden=false
                cell.gateCodeLbl.text="Cross Street: " + (billingAddress[indexPath.row].crossStreets ?? "")
            }else if (billingAddress[indexPath.row].gateCode != nil||billingAddress[indexPath.row].gateCode != ""||billingAddress[indexPath.row].gateCode != "NULL")&&(billingAddress[indexPath.row].crossStreets == nil||billingAddress[indexPath.row].crossStreets == ""||billingAddress[indexPath.row].crossStreets == "NULL"){
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=false
                cell.gateCodeLbl.isHidden=false
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.text="Gate Code: " + (billingAddress[indexPath.row].gateCode ?? "")
            }else{
                cell.crossStreetView.isHidden=false
                cell.gateCodeView.isHidden=false
                cell.gateCodeLbl.isHidden=false
                cell.crossStreetLbl.isHidden=false
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.text="Gate Code: " + (billingAddress[indexPath.row].gateCode ?? "")
                cell.crossStreetLbl.text="Cross Street: " + (billingAddress[indexPath.row].crossStreets ?? "")
            }
            
            
            
            
            //        cell.crossStreetLbl.translatesAutoresizingMaskIntoConstraints=true
            //        cell.crossStreetView.translatesAutoresizingMaskIntoConstraints=true
            NSLayoutConstraint.activate([
                cell.crossStreetLbl.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.crossStreetView.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.gateCodeLbl.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.gateCodeView.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0)
            ])
            //        NSLayoutConstraint.activate([
            //
            //            cell.crossStreetLbl.trailingAnchor.constraint(equalTo: cell.editBtn.leadingAnchor, constant: 0),
            //            cell.crossStreetView.trailingAnchor.constraint(equalTo: cell.editBtn.leadingAnchor, constant: 0)
            //           ])
            //             if billingAddress[indexPath.row].cellPhoneNumber == nil||billingAddress[indexPath.row].cellPhoneNumber == ""&&(billingAddress[indexPath.row].homePhoneNumber != nil||billingAddress[indexPath.row].homePhoneNumber != ""){
            //                cell.customerHomePhoneImageView.isHidden=true
            //                cell.customerCellPhoneImageView.isHidden=false
            //                cell.customerCellphoneLbl.isHidden=false
            //                cell.customerHomePhoneLbl.isHidden=true
            //                cell.customercellPhoneLblheightConstraint.constant=46.5
            //                cell.customerCellphoneLbl.text=billingAddress[indexPath.row].homePhoneNumber?.toPhoneNumber()
            //                cell.customerCellPhoneImageView.image=UIImage(named:"home")
            //                //cell.dashedView.isHidden=false
            //             }else{
            //                 cell.customerHomePhoneImageView.isHidden=true
            //                 cell.customerCellPhoneImageView.isHidden=false
            //                 cell.customerCellphoneLbl.isHidden=false
            //                 cell.customerHomePhoneLbl.isHidden=true
            //                 cell.customercellPhoneLblheightConstraint.constant=46.5
            //                 cell.customerCellphoneLbl.text=billingAddress[indexPath.row].cellPhoneNumber
            //                 cell.customerCellPhoneImageView.image=UIImage(named:"call")
            //                 //cell.dashedView.isHidden=false
            //             }
            
            
            if (billingAddress[indexPath.row].cellPhoneNumber == nil||billingAddress[indexPath.row].cellPhoneNumber == ""||billingAddress[indexPath.row].cellPhoneNumber == "NULL")&&(billingAddress[indexPath.row].homePhoneNumber == nil||billingAddress[indexPath.row].homePhoneNumber == ""||billingAddress[indexPath.row].homePhoneNumber == "NULL"){
                cell.customerCellPhoneImageView.isHidden=true
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellphoneLbl.isHidden=true
                cell.customerHomePhoneLbl.isHidden=true
                cell.customerCellphoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=0
                cell.dashedView.isHidden=true
            }else if billingAddress[indexPath.row].cellPhoneNumber == nil||billingAddress[indexPath.row].cellPhoneNumber == ""||billingAddress[indexPath.row].cellPhoneNumber == "NULL"&&(billingAddress[indexPath.row].homePhoneNumber != nil||billingAddress[indexPath.row].homePhoneNumber != ""||billingAddress[indexPath.row].homePhoneNumber != "NULL"){
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=46.5
                cell.customerCellphoneLbl.text=billingAddress[indexPath.row].homePhoneNumber?.toPhoneNumber()
                cell.customerCellPhoneImageView.image=UIImage(named:"home")
                cell.dashedView.isHidden=false
            }else if (billingAddress[indexPath.row].cellPhoneNumber != ""||billingAddress[indexPath.row].cellPhoneNumber != nil||billingAddress[indexPath.row].cellPhoneNumber != "NULL")&&(billingAddress[indexPath.row].homePhoneNumber == ""||billingAddress[indexPath.row].homePhoneNumber == nil||billingAddress[indexPath.row].homePhoneNumber == "NULL"){
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=46.5
                cell.customerCellphoneLbl.text=billingAddress[indexPath.row].cellPhoneNumber
                cell.customerCellPhoneImageView.image=UIImage(named:"call")
                cell.dashedView.isHidden=false
            }else if billingAddress[indexPath.row].cellPhoneNumber != nil||billingAddress[indexPath.row].cellPhoneNumber != ""||billingAddress[indexPath.row].cellPhoneNumber != "NULL"&&(billingAddress[indexPath.row].homePhoneNumber != nil||billingAddress[indexPath.row].homePhoneNumber != ""||billingAddress[indexPath.row].homePhoneNumber != "NULL") {
                cell.customerHomePhoneImageView.isHidden=false
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=false
                cell.customercellPhoneLblheightConstraint.constant=46.5
                
                cell.customerCellphoneLbl.text=billingAddress[indexPath.row].cellPhoneNumber
                cell.customerHomePhoneLbl.text=billingAddress[indexPath.row].homePhoneNumber
                cell.customerCellPhoneImageView.image=UIImage(named:"call")
                cell.customerHomePhoneImageView.image=UIImage(named:"home")
                cell.dashedView.isHidden=false
            }
            cell.editBtn.isHidden=false
            cell.editBtn.tag=indexPath.section
            cell.editBtn.addTarget(self, action: #selector(editBtnAction(sender: )), for: .touchUpInside)
            
            return cell
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressHeadingTableViewCell") as! AddressHeadingTableViewCell
            cell.adressTypeLabel.text="MAILING ADDRESS"
            return cell
        case 5:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerEditTableViewCell") as! CustomerEditTableViewCell
            cell.editBtn.isHidden=false
            var nameString=""
            var addressString=""
            
            if mailingAdresss[indexPath.row].firstName != nil {
                nameString = nameString + mailingAdresss[indexPath.row].firstName! + " "
            }
            if mailingAdresss[indexPath.row].middleName != nil {
                nameString = nameString + mailingAdresss[indexPath.row].middleName! + " "
            }
            if mailingAdresss[indexPath.row].lastName != nil {
                nameString = nameString + mailingAdresss[indexPath.row].lastName!
            }
            cell.customernameLbl.text=nameString
            
            if mailingAdresss[indexPath.row].addressLineOne != nil {
                addressString = addressString + mailingAdresss[indexPath.row].addressLineOne! + ", "
            }
            //            if mailingAdresss[indexPath.row].addressLineTwo != nil&&mailingAdresss[indexPath.row].addressLineTwo != "NULL" {
            //                addressString = addressString + mailingAdresss[indexPath.row].addressLineTwo! + ", "
            //            }
            if mailingAdresss[indexPath.row].city != nil {
                addressString = addressString + mailingAdresss[indexPath.row].city! + ", "
                cell.cityNameLbl.text=mailingAdresss[indexPath.row].city!
            }
            if mailingAdresss[indexPath.row].state != nil {
                addressString = addressString + mailingAdresss[indexPath.row].state! + ", "
                cell.stateNameLbl.text=mailingAdresss[indexPath.row].state!
            }
            if mailingAdresss[indexPath.row].zip != nil {
                addressString = addressString + mailingAdresss[indexPath.row].zip!
                cell.zipNameLbl.text=mailingAdresss[indexPath.row].zip!
            }
            cell.customerLocation.text=addressString
            if mailingAdresss[indexPath.row].emailAddress != nil{
                cell.customerEmailAdressLbl.text=mailingAdresss[indexPath.row].emailAddress
                cell.customeremailLblHeight.constant=30
                cell.locationTopConstraint.constant=35
            }else{
                cell.customeremailLblHeight.constant=0
                cell.locationTopConstraint.constant=20
                
            }
            
            
            
            
            if (mailingAdresss[indexPath.row].gateCode == nil||mailingAdresss[indexPath.row].gateCode == ""||mailingAdresss[indexPath.row].gateCode == "NULL") && (mailingAdresss[indexPath.row].crossStreets == nil||mailingAdresss[indexPath.row].crossStreets == ""||mailingAdresss[indexPath.row].crossStreets == "NULL"){
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=true
                cell.gateCodeLbl.isHidden=true
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=0
            }else if (mailingAdresss[indexPath.row].gateCode == nil||mailingAdresss[indexPath.row].gateCode == ""||mailingAdresss[indexPath.row].gateCode == "NULL")&&(mailingAdresss[indexPath.row].crossStreets != nil||mailingAdresss[indexPath.row].crossStreets != ""||mailingAdresss[indexPath.row].crossStreets != "NULL"){
                
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=false
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.isHidden=false
                cell.gateCodeLbl.text="Cross Street: " + (mailingAdresss[indexPath.row].crossStreets ?? "")
            }else if (mailingAdresss[indexPath.row].gateCode != nil||mailingAdresss[indexPath.row].gateCode != ""||mailingAdresss[indexPath.row].gateCode != "NULL")&&(mailingAdresss[indexPath.row].crossStreets == nil||mailingAdresss[indexPath.row].crossStreets == ""||mailingAdresss[indexPath.row].crossStreets == "NULL"){
                cell.crossStreetView.isHidden=true
                cell.gateCodeView.isHidden=false
                cell.gateCodeLbl.isHidden=false
                cell.crossStreetLbl.isHidden=true
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.text="Gate Code: " + (mailingAdresss[indexPath.row].gateCode ?? "")
            }else{
                cell.crossStreetView.isHidden=false
                cell.gateCodeView.isHidden=false
                cell.gateCodeLbl.isHidden=false
                cell.crossStreetLbl.isHidden=false
                cell.gatecodeViewHeightConstraint.constant=50
                cell.gateCodeLbl.text="Gate Code: " + (mailingAdresss[indexPath.row].gateCode ?? "")
                cell.crossStreetLbl.text="Cross Street: " + (mailingAdresss[indexPath.row].crossStreets ?? "")
            }
            //        cell.crossStreetLbl.translatesAutoresizingMaskIntoConstraints=true
            //        cell.crossStreetView.translatesAutoresizingMaskIntoConstraints=true
            NSLayoutConstraint.activate([
                cell.crossStreetLbl.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.crossStreetView.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.gateCodeLbl.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0),
                cell.gateCodeView.trailingAnchor.constraint(lessThanOrEqualTo:  cell.editBtn.leadingAnchor, constant: 0)
            ])
            //        NSLayoutConstraint.activate([
            //
            //            cell.crossStreetLbl.trailingAnchor.constraint(equalTo: cell.editBtn.leadingAnchor, constant: 0),
            //            cell.crossStreetView.trailingAnchor.constraint(equalTo: cell.editBtn.leadingAnchor, constant: 0)
            //           ])
            if (mailingAdresss[indexPath.row].cellPhoneNumber == nil||mailingAdresss[indexPath.row].cellPhoneNumber == ""||mailingAdresss[indexPath.row].cellPhoneNumber == "NULL")&&(mailingAdresss[indexPath.row].homePhoneNumber == nil||mailingAdresss[indexPath.row].homePhoneNumber == ""||mailingAdresss[indexPath.row].homePhoneNumber == "NULL"){
                cell.customerCellPhoneImageView.isHidden=true
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellphoneLbl.isHidden=true
                cell.customerHomePhoneLbl.isHidden=true
                cell.customerCellphoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=0
                cell.dashedView.isHidden=true
            }else if mailingAdresss[indexPath.row].cellPhoneNumber == nil||mailingAdresss[indexPath.row].cellPhoneNumber == ""||mailingAdresss[indexPath.row].cellPhoneNumber == "NULL"&&(mailingAdresss[indexPath.row].homePhoneNumber != nil||mailingAdresss[indexPath.row].homePhoneNumber != ""||mailingAdresss[indexPath.row].homePhoneNumber != "NULL"){
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=46.5
                cell.customerCellphoneLbl.text=mailingAdresss[indexPath.row].homePhoneNumber?.toPhoneNumber()
                cell.customerCellPhoneImageView.image=UIImage(named:"home")
                cell.dashedView.isHidden=false
            }else if (mailingAdresss[indexPath.row].cellPhoneNumber != ""||mailingAdresss[indexPath.row].cellPhoneNumber != nil||mailingAdresss[indexPath.row].cellPhoneNumber != "NULL")&&(mailingAdresss[indexPath.row].homePhoneNumber == ""||mailingAdresss[indexPath.row].homePhoneNumber == nil||mailingAdresss[indexPath.row].homePhoneNumber == "NULL"){
                cell.customerHomePhoneImageView.isHidden=true
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=true
                cell.customercellPhoneLblheightConstraint.constant=46.5
                cell.customerCellphoneLbl.text=mailingAdresss[indexPath.row].cellPhoneNumber
                cell.customerCellPhoneImageView.image=UIImage(named:"call")
                cell.dashedView.isHidden=false
            }else if mailingAdresss[indexPath.row].cellPhoneNumber != nil||mailingAdresss[indexPath.row].cellPhoneNumber != ""||mailingAdresss[indexPath.row].cellPhoneNumber != "NULL"&&(mailingAdresss[indexPath.row].homePhoneNumber != nil||mailingAdresss[indexPath.row].homePhoneNumber != ""||mailingAdresss[indexPath.row].homePhoneNumber != "NULL") {
                cell.customerHomePhoneImageView.isHidden=false
                cell.customerCellPhoneImageView.isHidden=false
                cell.customerCellphoneLbl.isHidden=false
                cell.customerHomePhoneLbl.isHidden=false
                cell.customercellPhoneLblheightConstraint.constant=46.5
                
                cell.customerCellphoneLbl.text=mailingAdresss[indexPath.row].cellPhoneNumber
                cell.customerHomePhoneLbl.text=mailingAdresss[indexPath.row].homePhoneNumber
                cell.customerCellPhoneImageView.image=UIImage(named:"call")
                cell.customerHomePhoneImageView.image=UIImage(named:"home")
                cell.dashedView.isHidden=false
            }
            cell.editBtn.isHidden=false
            cell.editBtn.tag=indexPath.section
            cell.editBtn.addTarget(self, action: #selector(editBtnAction(sender: )), for: .touchUpInside)
            
            // cell.editBtn.addTarget(self, action: #selector(editBtnAction(sender: )), for: .touchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerEditTableViewCell") as! CustomerEditTableViewCell
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 65
        case 1:
            return UITableView.automaticDimension
        case 2:
            return 65
        case 3:
            return UITableView.automaticDimension
        case 4:
            return 65
        case 5:
            return UITableView.automaticDimension
        default:
            return 65
        }
        
        
    }
    
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if ((locationAdresss[0].emailAddress?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            self.showAlertOk(message: "Email Address is required for location address. Please update to proceed.")
        }
        else if ((billingAddress[0].emailAddress?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            self.showAlertOk(message: "Email Address is required for billing address. Please update to proceed.")
        }else
        if ((mailingAdresss[0].emailAddress?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            self.showAlertOk(message: "Email Address is required for mailing address. Please update to proceed.")
        }else{
            if nofinanceModel.coapplicantlastName==""{
                let yes = UIAlertAction(title: "Yes", style:.default) { (_) in
                    
                    self.navigation()
                }
                let no = UIAlertAction(title: "No", style:.default) { (_) in
                    UserDefaults.standard.set("", forKey: "secondsignor")
                    nofinanceModel.coapplicantlastName=""
                    nofinanceModel.coapplicantfirstName=""
                    nofinanceModel.coapplicantmiddleName=""
                    self.saveAdressLocation()
                }
                
                self.alert("Would you like to add co-applicant details?", [yes,no])
                
                
                
            }else{
                self.saveAdressLocation()
            }
            
        }
        
    }
    func navigation(){
        let customerDetails = CustomerDetailsViewController.initialization()!
        
       
            customerDetails.customerlist=locationAdresss[0]
        customerDetails.adressType="locationAddress"
        
        self.navigationController?.pushViewController(customerDetails, animated: true)
    }
    
    @objc func editBtnAction(sender:UIButton){
        let customerDetails = CustomerDetailsViewController.initialization()!
        
        //        if sender.tag==0{
        //           // customerDetails.customer=0
        //             customerDetails.customerlist=customerlist[0]
        //        }else{
        //           // customerDetails.customer=1
        //            customerDetails.customerlist=customerlist[1]
        //        }
        if sender.tag==1{
            customerDetails.customerlist=locationAdresss[0]
            customerDetails.adressType="locationAddress"
        }else if sender.tag==3{
            customerDetails.customerlist=billingAddress[0]
            customerDetails.adressType="billingAddress"
        }else if sender.tag==5{
            customerDetails.customerlist=mailingAdresss[0]
            customerDetails.adressType="mailingAddress"
        }
        //customerDetails.addressCreate=create
        self.navigationController?.pushViewController(customerDetails, animated: true)
    }
    
    private func customerDetails(data: [CustomerList]) {
        print("data",data)
        customerlist=data
        if customerlist.count>0{
            // create=false
            billingAddress=customerlist.filter({ $0.addressTypeId == 1 })
            mailingAdresss=customerlist.filter({ $0.addressTypeId == 2 })
            locationAdresss=customerlist.filter({ $0.addressTypeId == 3 })
            if billingAddress.count==0||mailingAdresss.count==0||locationAdresss.count==0{
                apointmentByDesignConsultant()
            }
            customerEditTableView.reloadData()
        }
        
        
        else{
            customerdetailsapicall()
        }
        
    }
    func apointmentByDesignConsultant(){
        customerdetailsapicall()
    }
    
    func customerdetailsapicall(){
        let parameters:[String:String] = [:]
        customerlistViewModel.Design_ConsultantapiForAddress(parameters: parameters) { success, appointmentList, message in
            if success{
                self.salesSchedules(data: appointmentList ?? [])
                
                
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.customerdetailsapicall()
                    }
                    
                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                }else{
                    self.showAlertOk(message: message)
                }
            }
        }
    }
    
    
    private func salesSchedules(data: [CustomerList]) {
        print("data",data)
        appointmentList=data
        if appointmentList.count>0{
            let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
            let appointment = appointmentList.filter({ $0.appointmentId == appointmentId })
            print("self.customerlist",self.customerlist)
            self.customerlist=appointment
            
            print("self.customerlist",self.customerlist)
            //            self.customerlist[0].firstName=appointment[0].firstName
            //            self.customerlist[0].lastName=appointment[0].lastName
            //            self.customerlist[0].addressLineOne=appointment[0].addressLineOne
            //            self.customerlist[0].addressLineTwo=appointment[0].addressLineTwo
            //            self.customerlist[0].emailAddress=appointment[0].emailAddress
            //            self.customerlist[0].state=appointment[0].state
            //            self.customerlist[0].city=appointment[0].city
            //            self.customerlist[0].zip=appointment[0].zip
            //            self.customerlist[0].gateCode=appointment[0].gateCode
            //            self.customerlist[0].crossStreets=appointment[0].crossStreets
            // self.customerlist[0].appointmentAddressId=0
            print("self.customerlist",self.customerlist)
            
            if billingAddress.count==0{
                
                self.billingAddress = self.customerlist
                self.billingAddress[0].appointmentAddressId=0
                self.billingAddress[0].addressTypeId=1
            }
            if mailingAdresss.count==0{
                
                self.mailingAdresss = self.customerlist
                self.mailingAdresss[0].appointmentAddressId=0
                self.mailingAdresss[0].addressTypeId=2
            }
            if locationAdresss.count==0{
                
                self.locationAdresss = self.customerlist
                self.locationAdresss[0].appointmentAddressId=0
                self.locationAdresss[0].addressTypeId=3
            }
            self.customerEditTableView.reloadData()
        }
        
    }
    func  saveAdressLocation(){
        var parameters:[String:Any] = [:]
        
        let appointmentAdressId=locationAdresss[0].appointmentAddressId
        let appointmentId=locationAdresss[0].appointmentId
        let adresstypeId=locationAdresss[0].addressTypeId
        let firstName = optionalString(value: locationAdresss[0].firstName ?? "")
        let lastName = optionalString(value: locationAdresss[0].lastName ?? "")
        let middleName=optionalString(value: locationAdresss[0].middleName ?? "")
        let cellPhoneNumber=optionalString(value: locationAdresss[0].cellPhoneNumber ?? "")
        let homePhoneNumber=optionalString(value: locationAdresss[0].homePhoneNumber ?? "")
        let emailAddress=optionalString(value: locationAdresss[0].emailAddress ?? "")
        let addressLineOne=optionalString(value: locationAdresss[0].addressLineOne ?? "")
        let addressLineTwo=optionalString(value: locationAdresss[0].addressLineTwo ?? "")
        let city=optionalString(value: locationAdresss[0].city ?? "")
        let state=optionalString(value: locationAdresss[0].state ?? "")
        let zip=optionalString(value: locationAdresss[0].zip ?? "")
        let gateCode=optionalString(value: locationAdresss[0].gateCode ?? "")
        let crossStreets=optionalString(value: locationAdresss[0].crossStreets ?? "")
         
        parameters =  ["appointmentAddressId":appointmentAdressId ?? 0,"appointmentId":appointmentId ?? 0,"addressTypeId":adresstypeId ?? 0,"firstname":firstName,"lastName":lastName,"middleName":middleName,"cellPhoneNumber":cellPhoneNumber,"homePhoneNumber":homePhoneNumber ,"emailAddress":emailAddress,"addressLineOne":addressLineOne,"addressLineTwo":addressLineTwo,"city":city ,"state":state,"zip":zip,"gateCode":gateCode,"crossStreets":crossStreets]
    
    print("parametersLocation",parameters)
    customerupdateViewModel.save_Adress(rawdata: parameters,apppointmentAddressId:appointmentAdressId ?? 0) { success, CustomerList, message in
        if success{
            self.customerDetailsLocation(data: CustomerList!)
        }else{
            
        }
    }
}
    private func customerDetailsLocation(data: CustomerList) {
        print("data",data)
        saveAdressBilling()
        
    }
    private func customerDetailsBilling(data: CustomerList) {
        print("data",data)
       saveAdressMailing()
        
    }
    func saveAdressBilling(){
        var parameters:[String:Any] = [:]
        
        
        let appointmentAdressId=billingAddress[0].appointmentAddressId
        let appointmentId=billingAddress[0].appointmentId
        let adresstypeId=billingAddress[0].addressTypeId
        let firstName = optionalString(value: billingAddress[0].firstName ?? "")
        let lastName = optionalString(value: billingAddress[0].lastName ?? "")
        let middleName=optionalString(value: billingAddress[0].middleName ?? "")
        let cellPhoneNumber=optionalString(value: billingAddress[0].cellPhoneNumber ?? "")
        let homePhoneNumber=optionalString(value: billingAddress[0].homePhoneNumber ?? "")
        let emailAddress=optionalString(value: billingAddress[0].emailAddress ?? "")
        let addressLineOne=optionalString(value: billingAddress[0].addressLineOne ?? "")
        let addressLineTwo=optionalString(value: billingAddress[0].addressLineTwo ?? "")
        let city=optionalString(value: billingAddress[0].city ?? "")
        let state=optionalString(value: billingAddress[0].state ?? "")
        let zip=optionalString(value: billingAddress[0].zip ?? "")
        let gateCode=optionalString(value: billingAddress[0].gateCode ?? "")
        let crossStreets=optionalString(value: billingAddress[0].crossStreets ?? "")
        
        
        parameters =  ["appointmentAddressId":appointmentAdressId ?? 0,"appointmentId":appointmentId ?? 0,"addressTypeId":adresstypeId ?? 0,"firstname":firstName,"lastName":lastName,"middleName":middleName,"cellPhoneNumber":cellPhoneNumber,"homePhoneNumber":homePhoneNumber ,"emailAddress":emailAddress,"addressLineOne":addressLineOne,"addressLineTwo":addressLineTwo,"city":city ,"state":state,"zip":zip,"gateCode":gateCode,"crossStreets":crossStreets]
    
        print("parametersBilling",parameters)
    
    customerupdateViewModel.save_Adress(rawdata: parameters,apppointmentAddressId:appointmentAdressId ?? 0) { success, CustomerList, message in
        if success{
            self.customerDetailsBilling(data: CustomerList!)
        }else{
            
        }
    }
}
  
    private func customerDetailsMailing(data: CustomerList) {
        print("data",data)
        let installationVc = InstallationViewController.initialization()!
        self.navigationController?.pushViewController(installationVc, animated: true)
        
    }
    func saveAdressMailing(){
        var parameters:[String:Any] = [:]
    
        let appointmentAdressId=mailingAdresss[0].appointmentAddressId
        let appointmentId=mailingAdresss[0].appointmentId
        let adresstypeId=mailingAdresss[0].addressTypeId
        //let firstName = mailingAdresss[0].firstName
        let firstName = optionalString(value: mailingAdresss[0].firstName ?? "")
        let lastName = optionalString(value: mailingAdresss[0].lastName ?? "")
        let middleName=optionalString(value: mailingAdresss[0].middleName ?? "")
        let cellPhoneNumber=optionalString(value: mailingAdresss[0].cellPhoneNumber ?? "")
        let homePhoneNumber=optionalString(value: mailingAdresss[0].homePhoneNumber ?? "")
        let emailAddress=optionalString(value: mailingAdresss[0].emailAddress ?? "")
        let addressLineOne=optionalString(value: mailingAdresss[0].addressLineOne ?? "")
        let addressLineTwo=optionalString(value: mailingAdresss[0].addressLineTwo ?? "")
        let city=optionalString(value: mailingAdresss[0].city ?? "")
        let state=optionalString(value: mailingAdresss[0].state ?? "")
        let zip=optionalString(value: mailingAdresss[0].zip ?? "")
        let gateCode=optionalString(value: mailingAdresss[0].gateCode ?? "")
        let crossStreets=optionalString(value: mailingAdresss[0].crossStreets ?? "")
        
        
        parameters =  ["appointmentAddressId":appointmentAdressId ?? 0,"appointmentId":appointmentId ?? 0,"addressTypeId":adresstypeId ?? 0,"firstname":firstName,"lastName":lastName,"middleName":middleName,"cellPhoneNumber":cellPhoneNumber,"homePhoneNumber":homePhoneNumber ,"emailAddress":emailAddress,"addressLineOne":addressLineOne,"addressLineTwo":addressLineTwo,"city":city ,"state":state,"zip":zip,"gateCode":gateCode,"crossStreets":crossStreets]
    
    
        print("parametersMailing",parameters)
    
    customerupdateViewModel.save_Adress(rawdata: parameters,apppointmentAddressId:appointmentAdressId ?? 0) { success, CustomerList, message in
        if success{
            self.customerDetailsMailing(data: CustomerList!)
            
        }else{
            
        }
    }
}
    
}
