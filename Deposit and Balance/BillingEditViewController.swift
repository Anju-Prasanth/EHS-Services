//
//  BillingEditViewController.swift
//  Express Home
//
//  Created by Anju on 02.06.2023.
//

import UIKit

class BillingEditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    static func initialization() -> BillingEditViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "BillingEditViewController") as? BillingEditViewController
    }
    
    
    @IBOutlet weak var customerDetailsTableView: UITableView!
    var addCustomerDetails=0
    var customer=Int()
    var customerlistViewModel=customerListViewModel()
    var customerlist:CustomerList!
    var customerOneDetailmodel:CustomerOneDetailModel!
    var customerOneCell=CustomerDetails1TableViewCell()
    var customerupdateViewModel=customerUpdateViewModel()
    var customerUpdateList=[CustomerUpdate]()
    var navView = UIView()
    var navViewBottomLine = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
       
          //  setNavigationBarbacklogoName(name: )
        
        customerDetailsTableView.register(UINib(nibName: "CustomerDetails1TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerDetails1TableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool){
//        refreshMSALToken()
        setnavBarView()
        modelUpdated()
    }
    
    func  setnavBarView(){
        navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  120))
        navView.layer.masksToBounds = false
        navView.backgroundColor = UIColor().colorFromHexString("#F2F3F5")
        self.view.addSubview(navView)
        
        navViewBottomLine = UIView(frame: CGRect(x: 0, y: 120, width: self.view.frame.width, height:  1))
        navViewBottomLine.layer.masksToBounds = false
        navViewBottomLine.backgroundColor = UIColor().colorFromHexString("#CBCCD5").withAlphaComponent(1.0)
        self.view.addSubview(navViewBottomLine)
      // addbeforeupdated
        setNavigationBarbacklogoNameForFinance(name: " Edit Billing Address",superview: navView)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
      
    }
    func modelUpdated(){
        customerOneDetailmodel=CustomerOneDetailModel()
        customerOneDetailmodel.appointmentAddressId=customerlist.appointmentAddressId
        customerOneDetailmodel.addressTypeId=customerlist.addressTypeId
        
        
        
         if customerlist.firstName  != "NULL"&&customerlist.firstName  != nil{
             customerOneDetailmodel.firstName=customerlist.firstName ?? ""
         }
         if customerlist.middleName   != "NULL"&&customerlist.middleName  != nil{
             customerOneDetailmodel.middleName=customerlist.middleName ?? ""
         }
         if customerlist.lastName   != "NULL"&&customerlist.lastName  != nil{
             customerOneDetailmodel.lastName=customerlist.lastName ?? ""
         }
         if customerlist.emailAddress   != "NULL"&&customerlist.emailAddress  != nil{
             customerOneDetailmodel.email=customerlist.emailAddress ?? ""
         }
         if customerlist.addressLineOne   != "NULL"&&customerlist.addressLineOne  != nil{
             customerOneDetailmodel.street=customerlist.addressLineOne ?? ""
         }
         if customerlist.addressLineTwo   != "NULL"&&customerlist.addressLineTwo  != nil{
             customerOneDetailmodel.addressLineTwo=customerlist.addressLineTwo ?? ""
         }
        
         if customerlist.state   != "NULL"&&customerlist.state  != nil{
             customerOneDetailmodel.state=customerlist.state ?? ""
         }
         if customerlist.zip   != "NULL"&&customerlist.zip  != nil{
             customerOneDetailmodel.zip=customerlist.zip ?? ""
         }
         
         if customerlist.city   != "NULL"&&customerlist.city  != nil{
             customerOneDetailmodel.city=customerlist.city ?? ""
         }
         if customerlist.gateCode   != "NULL"&&customerlist.gateCode  != nil{
             customerOneDetailmodel.gateCode=customerlist.gateCode ?? ""
         }
         if customerlist.crossStreets   != "NULL"&&customerlist.crossStreets  != nil{
             customerOneDetailmodel.streetCode=customerlist.crossStreets ?? ""
         }
         
         if customerlist.cellPhoneNumber?.toPhoneNumber()  != "NULL"&&customerlist.cellPhoneNumber?.toPhoneNumber() != nil{
             customerOneDetailmodel.cellPhone=customerlist.cellPhoneNumber?.toPhoneNumber() ?? ""
         }
         if customerlist.homePhoneNumber?.toPhoneNumber()  != "NULL"&&customerlist.homePhoneNumber?.toPhoneNumber() != nil{
             customerOneDetailmodel.homePhone=customerlist.homePhoneNumber?.toPhoneNumber() ?? ""
         }
//        customerOneDetailmodel.firstName=customerlist.firstName ?? ""
//        customerOneDetailmodel.middleName=customerlist.middleName ?? ""
//        customerOneDetailmodel.lastName=customerlist.lastName ?? ""
//        customerOneDetailmodel.email=customerlist.emailAddress ?? ""
//        customerOneDetailmodel.street=customerlist.addressLineOne ?? ""
//        customerOneDetailmodel.addressLineTwo=customerlist.addressLineTwo ?? ""
//        customerOneDetailmodel.state=customerlist.state ?? ""
//        customerOneDetailmodel.zip=customerlist.zip ?? ""
//        customerOneDetailmodel.city=customerlist.city ?? ""
//        customerOneDetailmodel.gateCode=customerlist.gateCode ?? ""
//        customerOneDetailmodel.streetCode=customerlist.crossStreets ?? ""
//        customerOneDetailmodel.cellPhone=customerlist.cellPhoneNumber?.toPhoneNumber() ?? ""
//        customerOneDetailmodel.homePhone=customerlist.homePhoneNumber?.toPhoneNumber() ?? ""
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        //        if customer==0{
         customerOneCell = tableView.dequeueReusableCell(withIdentifier: "CustomerDetails1TableViewCell") as!  CustomerDetails1TableViewCell
        
        
        customerOneCell.firstNameTxtfld.delegate=self
        customerOneCell.lastNameTxtfld.delegate=self
        customerOneCell.mddlenameTxtfld.delegate=self
        customerOneCell.emailTxtfld.delegate=self
        customerOneCell.streetTxtfld.delegate=self
        customerOneCell.citytxtFld.delegate=self
        customerOneCell.stateTxtfld.delegate=self
        customerOneCell.zipTxtfld.delegate=self
        customerOneCell.gatecodeTxtFld.delegate=self
        customerOneCell.crossstreetTxtFld.delegate=self
        
        customerOneCell.firstNameTxtfld.text=customerOneDetailmodel.firstName
        customerOneCell.mddlenameTxtfld.text=customerOneDetailmodel.middleName
        customerOneCell.lastNameTxtfld.text=customerOneDetailmodel.lastName
        customerOneCell.emailTxtfld.text=customerOneDetailmodel.email
        customerOneCell.streetTxtfld.text=customerOneDetailmodel.street
        customerOneCell.contactNumberTxtfld.text=customerOneDetailmodel.cellPhone
        customerOneCell.homephoneTxtFld.text=customerOneDetailmodel.homePhone
        customerOneCell.stateTxtfld.text=customerOneDetailmodel.state
        customerOneCell.citytxtFld.text=customerOneDetailmodel.city
        customerOneCell.zipTxtfld.text=customerOneDetailmodel.zip
        customerOneCell.gatecodeTxtFld.text=customerOneDetailmodel.gateCode
        customerOneCell.crossstreetTxtFld.text=customerOneDetailmodel.streetCode
        customerOneCell.updateBtn.addTarget(self, action: #selector(updateAction), for: .touchUpInside)
        
        return customerOneCell
        //        }else{
        //           let  cell = tableView.dequeueReusableCell(withIdentifier: "CustomerDetail2TableViewCell") as! CustomerDetail2TableViewCell
        //
        //            return cell
        //        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    
    @objc func updateAction(){
        if customerOneDetailmodel.firstName.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "First Name is required. Please enter to proceed.")
        }
        else if customerOneDetailmodel.lastName.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "Last Name is required. Please enter to proceed.")
        }else if customerOneDetailmodel.email.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "Email is required. Please enter to proceed.")
        }else if !isValidEmail(testStr:customerOneDetailmodel.email){
            
            self.showAlertOk(message: "Please enter valid Email")
        } else if customerOneDetailmodel.street.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "Street is required. Please enter to proceed.")
        } else if customerOneDetailmodel.zip.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "Zip is required. Please enter to proceed.")
        }else if customerOneDetailmodel.city.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "City is required. Please enter to proceed.")
        }else if customerOneDetailmodel.state.trimmingCharacters(in: .whitespaces).isEmpty{
            self.showAlertOk(message: "State is required. Please enter to proceed.")
            
        }else{
            
            updateAdress()
        }
        
       
    }
    func updateAdress(){
        var parameters:[String:Any] = [:]
        
        let appointmentAdressId=customerlist.appointmentAddressId
        let appointmentId=customerlist.appointmentId
        let adresstypeId=customerlist.addressTypeId
        let firstName = customerOneDetailmodel?.firstName
        let lastName = customerOneDetailmodel?.lastName
        let middleName=customerOneDetailmodel?.middleName
        let cellPhoneNumber=customerOneDetailmodel?.cellPhone
        let homePhoneNumber=customerOneDetailmodel?.homePhone
        let emailAddress=customerOneDetailmodel?.email
        let addressLineOne=customerOneDetailmodel?.street
        let addressLineTwo=customerOneDetailmodel?.addressLineTwo
        let city=customerOneDetailmodel?.city
        let state=customerOneDetailmodel?.state
        let zip=customerOneDetailmodel?.zip
        let gateCode=customerOneDetailmodel?.gateCode
        let crossStreets=customerOneDetailmodel.streetCode
        
        if appointmentAdressId==0{
            parameters =  ["appointmentId":appointmentId,"addressTypeId":adresstypeId,"firstname":firstName,"lastName":lastName,"middleName":middleName,"cellPhoneNumber":cellPhoneNumber,"homePhoneNumber":homePhoneNumber,"emailAddress":emailAddress,"addressLineOne":addressLineOne,"addressLineTwo":addressLineTwo,"city":city,"state":state,"zip":zip,"gateCode":gateCode,"crossStreets":crossStreets]
        }else{
            parameters =  ["appointmentAddressId":appointmentAdressId,"appointmentId":appointmentId,"addressTypeId":adresstypeId,"firstname":firstName,"lastName":lastName,"middleName":middleName,"cellPhoneNumber":cellPhoneNumber,"homePhoneNumber":homePhoneNumber,"emailAddress":emailAddress,"addressLineOne":addressLineOne,"addressLineTwo":addressLineTwo,"city":city,"state":state,"zip":zip,"gateCode":gateCode,"crossStreets":crossStreets]
        }
        print("parameters",parameters)
        customerupdateViewModel.customer_updateAdress(rawdata: parameters,apppointmentAddressId:appointmentAdressId ?? 0) { success, CustomerList, message in
            if success{
                self.customerDetails(data: CustomerList!)
            }else{
                
            }
        }
    }
    private func customerDetails(data: CustomerList) {
        print("data",data)
        customerlist=data
        modelUpdated()
        let DepositPayemnt = DepositPaymentMethodViewController.initialization()!
        self.navigationController?.popViewController(animated: true)
        customerDetailsTableView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == customerOneCell.contactNumberTxtfld{
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = self.format(with: "(XXX) XXX-XXXX", phone: newString)
            customerOneDetailmodel.cellPhone=textField.text ?? ""
            return false
        }
        if textField == customerOneCell.homephoneTxtFld{
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = self.format(with: "(XXX) XXX-XXXX", phone: newString)
            customerOneDetailmodel.homePhone=textField.text ?? ""
            return false
        }
        if textField==customerOneCell.firstNameTxtfld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                customerOneDetailmodel.firstName=text
            }
            if textField==customerOneCell.lastNameTxtfld{
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                customerOneDetailmodel.lastName=text
            }
            if textField==customerOneCell.mddlenameTxtfld{
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                customerOneDetailmodel.middleName=text
            }
            if textField==customerOneCell.emailTxtfld{
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                customerOneDetailmodel.email=text
            }
        
            if textField==customerOneCell.streetTxtfld{
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                customerOneDetailmodel.street=text
            }
            if textField==customerOneCell.citytxtFld{
                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                customerOneDetailmodel.city=text
            }
        if textField==customerOneCell.stateTxtfld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            customerOneDetailmodel.state=text
        }
        if textField==customerOneCell.zipTxtfld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            customerOneDetailmodel.zip=text
        }
        if textField==customerOneCell.gatecodeTxtFld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            customerOneDetailmodel.gateCode=text
        }
        if textField==customerOneCell.crossstreetTxtFld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            customerOneDetailmodel.streetCode=text
        }
            
//        customerOneDetailmodel.firstName=customerOneCell.firstNameTxtfld.text ?? ""
//        customerOneDetailmodel.lastName=customerOneCell.lastNameTxtfld.text ?? ""
//        customerOneDetailmodel.middleName=customerOneCell.mddlenameTxtfld.text ?? ""
//        customerOneDetailmodel.email=customerOneCell.emailTxtfld.text ?? ""
//        customerOneDetailmodel.street=customerOneCell.streetTxtfld.text ?? ""
//        customerOneDetailmodel.city=customerOneCell.citytxtFld.text ?? ""
//        customerOneDetailmodel.state=customerOneCell.stateTxtfld.text ?? ""
//        customerOneDetailmodel.zip=customerOneCell.zipTxtfld.text ?? ""
//        customerOneDetailmodel.gateCode=customerOneCell.gatecodeTxtFld.text ?? ""
//        customerOneDetailmodel.streetCode=customerOneCell.crossstreetTxtFld.text ?? ""
        return true
    }
    
    
   
    
}


