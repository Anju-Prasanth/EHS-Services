//
//  DepositPaymentMethodViewController.swift
//  Express Home
//
//  Created by Anju on 01.06.2023.
//

import UIKit
import CreditCardValidator
import AuthorizeNetAccept
import IQKeyboardManagerSwift





fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}



//let kClientName = "789fLrNH33"
let kClientName = "88T83tfK7m"
//let kClientKey  = "2f7DP93raND37yvZwF23FkaCqEaK4Jpxnty72DbBnkRe6V3HHb7cV39Mk3u3PDd6"
let kClientKey  = "4xd25e8smd79XhLa6HN24wpXUcFDNp4sJ5mJFPjh74PAqaJrF2eK4n5vbBNbg3wR"

let kAcceptSDKDemoCreditCardLength:Int = 16
let kAcceptSDKDemoCreditCardLengthPlusSpaces:Int = (kAcceptSDKDemoCreditCardLength + 2)
let kAcceptSDKDemoExpirationLength:Int = 4
let kAcceptSDKDemoExpirationMonthLength:Int = 2
let kAcceptSDKDemoExpirationYearLength:Int = 2
let kAcceptSDKDemoExpirationLengthPlusSlash:Int = kAcceptSDKDemoExpirationLength + 1
let kAcceptSDKDemoCVV2Length:Int = 4

let kAcceptSDKDemoCreditCardObscureLength:Int = (kAcceptSDKDemoCreditCardLength - 4)

let kAcceptSDKDemoSpace:String = " "
let kAcceptSDKDemoSlash:String = "/"




var nofinanceModel=DepositNoFinanceSelectedModel()

class DepositPaymentMethodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    
    static func initialization() -> DepositPaymentMethodViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DepositPaymentMethodViewController") as? DepositPaymentMethodViewController
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var paymentdeclinedLabel: UILabel!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var overstockViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailvalidationLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationView: UIView!
    @IBOutlet weak var billingPhoneImageView: UIImageView!
    @IBOutlet weak var balanceAmountLbl: UILabel!
    @IBOutlet weak var gatecodeLblheight: NSLayoutConstraint!
    @IBOutlet weak var crossStreetLblHeight: NSLayoutConstraint!
    @IBOutlet weak var phoneLblHeight: NSLayoutConstraint!
    @IBOutlet weak var phoneImageviewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentDeclinedview: UIView!
    @IBOutlet weak var paymentsuccesssubheadingLbl: UILabel!
    @IBOutlet weak var paymentsucessLbl: UILabel!
    @IBOutlet weak var paymentstatusImageView: UIImageView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var phomneLbl: UILabel!
    @IBOutlet weak var creossStreetValueLbl: UILabel!
    @IBOutlet weak var crossstreetLbl: UILabel!
    @IBOutlet weak var gateCodeLbl: UILabel!
    @IBOutlet weak var gateCodeValueLbl: UILabel!
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var checkLbl: UILabel!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var depositPaymentTableView: UITableView!
    var navView = UIView()
    var navViewBottomLine = UIView()
    var cardSelected=0
    var cardcell=CardDetailTableViewCell()
    var checkcell=CheckDetailTableViewCell()
    var editDict=[String:Any]()
    var editcardAction=false
    var editedIndex=100
    var isFromBalancePaymentVC=Bool()
    var balance_Amount=String()
    var requiredFieldsArray:[RequiredFields]=[]
    var requiredHeadingName=String()
    var cardTypeArray=[String]()
    var cardTypeIdArray=[Int]()
    var isCardValid:Bool!
    var isvalidCardnumber:Bool!
    var isvalidCvv:Bool!
    var isvalidMonthYear:Bool!
    var ACHFieldArray:[RequiredFields]=[]
    
    
    var expiryMonth=String()
    var expiryYear=String()
    fileprivate var cardNumber:String!
    fileprivate var cardExpirationMonth:String!
    fileprivate var cardExpirationYear:String!
    fileprivate var cardVerificationCode:String!
    fileprivate var cardNumberBuffer:String!
    
    var customerlistViewModel=customerListViewModel()
    var customerlist=[CustomerList]()
    var salesViewModel=salesSchedulesViewmodel()
    var appointmentList=[CustomerList]()
    var billingAddress=[CustomerList]()
    var mailingAdresss=[CustomerList]()
    var locationAdresss=[CustomerList]()
    var actualSaleAmount=Double()
    var authorize_token=String()
    var projectSelectIndex=Int()
    var Balance_Amount=String()
    var cardArrayForCreditCard=[FinanceProvider]()
    var errorText=String()
    var loaderView:LoaderView!
    
    @IBOutlet weak var zipValidationHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //processPayment()
        borderView.layer.cornerRadius=8
        depositPaymentTableView.register(UINib(nibName: "CardDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CardDetailTableViewCell")
        depositPaymentTableView.register(UINib(nibName: "CheckDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckDetailTableViewCell")
        
        //        self.setUIControlsTagValues()
        //        self.initializeUIControls()
        print("Balance_Amount",Balance_Amount)
        print("cardTypeArray",cardTypeArray)
        print("actualSaleAmount",actualSaleAmount)
        balanceAmountLbl.text="$ "+Balance_Amount
        self.initializeMembers()
        setupLoaderView()
                
                // Simulate a task and show the loader
                
                
                // Simulate a task completion and hide the loader
               
            }

            private func setupLoaderView() {
                // Define the size and position of the loader
                let loaderSize: CGFloat = 100.0
                let loaderFrame = CGRect(x: (view.frame.width - loaderSize) / 2,
                                         y: (view.frame.height - loaderSize) / 2,
                                         width: loaderSize,
                                         height: loaderSize)
                
                // Create and add the loader view
                loaderView = LoaderView(frame: loaderFrame)
                if let loaderView = loaderView {
                    loaderView.isHidden = true
                    view.addSubview(loaderView)
                }
            }

            private func showLoader() {
                loaderView?.startAnimation()
            }

            private func hideLoader() {
                loaderView?.stopAnimation()
            }
        
   
    override func viewWillAppear(_ animated: Bool){
        
        //        refreshMSALToken()
        emailvalidationLabelHeightConstraint.constant=0
        emailTextField.setLeftPaddingPoints(20)
        emailTextField.setRightPaddingPoints(20)
        
        zipcodeTextField.setLeftPaddingPoints(20)
        zipcodeTextField.setRightPaddingPoints(20)
        overstockViewHeightConstraint.constant=320
        zipValidationHeight.constant=0
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appCameToForeGround(notification:)),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
        if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
        {
            tokenexpirationCheck()
            
        }
        
        
        
        
        
        if editcardAction==true{
            
            nofinanceModel.CardType=editDict["cardType"] as? String ?? ""
            nofinanceModel.AcntHolderName=editDict["accountHolderName"] as? String ?? ""
            nofinanceModel.CardNumber=editDict["creditCardNumber"] as? String ?? ""
            nofinanceModel.Expiration=editDict["expirationMonth"] as? String ?? ""
            nofinanceModel.Year=editDict["expirationYear"] as? String ?? ""
            nofinanceModel.Cvv=editDict["cvv"] as? String ?? ""
            nofinanceModel.Routingnumber=editDict["routingNumber"] as? String ?? ""
            nofinanceModel.CheckNumber=editDict["checkNumber"] as? String ?? ""
            nofinanceModel.amount=editDict["amount"] as? String ?? ""
            cardTypeArray=nofinanceModel.cardType_Array
            cardNumberBuffer=nofinanceModel.CardNumber
            if nofinanceModel.CardType=="ACH"{
                cardSelected=1
                borderView.isHidden=true
                // ACHFieldArray=nofinanceModel.ACHrequiredFieldArray[editedIndex]
            }else{
                cardSelected=0
                borderView.isHidden=true
            }
            depositPaymentTableView.reloadData()
        }else{
            nofinanceModel.CardType=""
            nofinanceModel.AcntHolderName=""
            nofinanceModel.CardNumber=""
            nofinanceModel.Expiration=""
            nofinanceModel.Year=""
            nofinanceModel.Cvv=""
            nofinanceModel.Routingnumber=""
            nofinanceModel.CheckNumber=""
            nofinanceModel.amount=""
        }
        borderView.isHidden=false
        setnavBarView()
    }
    
    func setUIControlsTagValues() {
        cardcell.creditCardTxtFld.tag = 1
        cardcell.ExpiretionDateTxtFld.tag = 2
        cardcell.yearTxtFld.tag = 3
        cardcell.CvvTxtFld.tag = 4
    }
    
    
    func appointmentAddressApiCall(){
        let parameters = [String:Any]()
        customerlistViewModel.AppointmentAddresses_byappointmentid(parameters: parameters) { success, customerList, message in
            if success{
                self.customerDetails(data: customerList ?? [])
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.appointmentAddressApiCall()
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
            appointmentAddressApiCall()
        }else{
            intializeMSAL(isfromLoggedOut: false)
            
        }
    }
    @objc override func refreshTokenCheck(notification: Notification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let token = dict["token"] as? Int{
                UserDefaults.standard.set(token, forKey: "token")
                appointmentAddressApiCall()
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
    
    
    @IBAction func emailValidationViewAcncelAction(_ sender: Any) {
        blurView.isHidden=true
        emailValidationView.isHidden=true
        self.view.endEditing(true)
    }
    
    
    @IBAction func emailValidationViewSubmitAction(_ sender: Any) {
        let zipcode=zipcodeTextField.text ?? ""
        if isValidEmail(testStr:emailTextField.text ?? "") && !(zipcode.trimmingCharacters(in: .whitespaces).isEmpty){
            blurView.isHidden=true
            emailValidationView.isHidden=true
            if isFromBalancePaymentVC{
                if cardSelected==0{
                    self.balancetransactionApi()
                }else{
                    self.BalanceACHtransactionApi()
                }
            }else{
                if cardSelected==0{
                    self.transactionApi()
                }else{
                    self.ACHtransactionApi()
                }
            }
        }else if !isValidEmail(testStr:emailTextField.text ?? "") && (zipcode.trimmingCharacters(in: .whitespaces).isEmpty){
            overstockViewHeightConstraint.constant=362
            emailvalidationLabelHeightConstraint.constant=21
            zipValidationHeight.constant=21
            
        }else if  !isValidEmail(testStr:emailTextField.text ?? ""){
                    overstockViewHeightConstraint.constant=335
                    emailvalidationLabelHeightConstraint.constant=21
            if (zipcode.trimmingCharacters(in: .whitespaces).isEmpty){
                zipValidationHeight.constant=21
            }else{
                zipValidationHeight.constant=0
            }
        }else if (zipcode.trimmingCharacters(in: .whitespaces).isEmpty){
            overstockViewHeightConstraint.constant=335
            zipValidationHeight.constant=21
             if !isValidEmail(testStr:emailTextField.text ?? ""){
               
                emailvalidationLabelHeightConstraint.constant=21
            }else{
                emailvalidationLabelHeightConstraint.constant=0
            }
        
            }else{
                overstockViewHeightConstraint.constant=320
                emailvalidationLabelHeightConstraint.constant=0
                zipValidationHeight.constant=0
            }
//        if !isValidEmail(testStr:emailTextField.text ?? ""){
//            emailvalidationLabelHeightConstraint.constant=21
//            overstockViewHeightConstraint.constant=345
//        }else{
//            emailvalidationLabelHeightConstraint.constant=0
//            overstockViewHeightConstraint.constant=320
//        }
//
//        if (zipcode.trimmingCharacters(in: .whitespaces).isEmpty){
//            zipValidationHeight.constant=21
//            overstockViewHeightConstraint.constant=335
//        }else{
//            zipValidationHeight.constant=0
//            overstockViewHeightConstraint.constant=320
//        }
//
//        if (zipcode.trimmingCharacters(in: .whitespaces).isEmpty){
//            zipValidationHeight.constant=21
//            overstockViewHeightConstraint.constant=335
//        }else{
//            if !isValidEmail(testStr:emailTextField.text ?? ""){
//                emailvalidationLabelHeightConstraint.constant=21
//                overstockViewHeightConstraint.constant=345
//            }else{
//                emailvalidationLabelHeightConstraint.constant=0
//                overstockViewHeightConstraint.constant=320
//            }
//        }
        self.view.endEditing(true)
        
    }
    func showemailvalidationView(){
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50
        blurView.isHidden=false
        popupView.isHidden=true
        paymentDeclinedview.isHidden=true
        emailValidationView.isHidden=false
        emailvalidationLabelHeightConstraint.constant=0
        zipValidationHeight.constant=0
        overstockViewHeightConstraint.constant=320
        zipcodeTextField.text=billingAddress[0].zip
        emailTextField.text=billingAddress[0].emailAddress
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        
        self.view.addSubview(emailValidationView)
    }
    func initializeUIControls() {
        cardcell.creditCardTxtFld.text = ""
        cardcell.ExpiretionDateTxtFld.text = ""
        cardcell.yearTxtFld.text = ""
        cardcell.CvvTxtFld.text = ""
        self.textChangeDelegate(cardcell.creditCardTxtFld)
        self.textChangeDelegate(cardcell.ExpiretionDateTxtFld)
        self.textChangeDelegate(cardcell.yearTxtFld)
        self.textChangeDelegate(cardcell.CvvTxtFld)
        
        cardcell.creditCardTxtFld.delegate = self
        cardcell.ExpiretionDateTxtFld.delegate = self
        cardcell.yearTxtFld.delegate = self
        cardcell.CvvTxtFld.delegate = self
    }
    
    func initializeMembers() {
        self.cardNumber = nil
        self.cardExpirationMonth = nil
        self.cardExpirationYear = nil
        self.cardVerificationCode = nil
        self.cardNumberBuffer = ""
    }
    
    
    
    private func customerDetails(data: [CustomerList]) {
        print("data",data)
        customerlist=data
        if customerlist.count>0{
            // create=false
            billingAddress=customerlist.filter({ $0.addressTypeId == 1 })
            
            if billingAddress.count==0{
                apointmentByDesignConsultant()
            }else{
                billingAddressUpdated()
            }
            
        }
        
        
        else{
            
            customerdetailsapicall()
        }
        
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
    
//    func createCustomerProfile() {
//        let handler = AcceptSDKHandler(environment: AcceptSDKEnvironment.ENV_TEST)
//
//        let request = CreateCustomerProfileRequest()
//        request.merchantAuthentication.name = "YOUR_API_LOGIN_ID"
//        request.merchantAuthentication.transactionKey = "YOUR_TRANSACTION_KEY"
//
//        request.profile = CustomerProfileType()
//        request.profile.merchantCustomerId = "12345"
//        request.profile.description = "Profile for Jane Doe"
//        request.profile.email = "jane.doe@example.com"
//
//        request.paymentProfiles = [CustomerPaymentProfileType()]
//        request.paymentProfiles[0].customerType = "individual"
//        request.paymentProfiles[0].payment = PaymentType()
//        request.paymentProfiles[0].payment.creditCard = CreditCardType()
//        request.paymentProfiles[0].payment.creditCard.cardNumber = "4111111111111111"
//        request.paymentProfiles[0].payment.creditCard.expirationDate = "2025-12"
//
//        handler.createCustomerProfile(request, completion: { response in
//            if let customerProfileId = response.customerProfileId {
//                print("Profile created with ID: \(customerProfileId)")
//                // Save customerProfileId and paymentProfileId for later use
//            }
//        }, failure: { error in
//            print("Failed to create customer profile: \(error.localizedDescription)")
//        })
//    }
    
    func apointmentByDesignConsultant(){
        customerdetailsapicall()
    }
    
    
    private func salesSchedules(data: [CustomerList]) {
        print("data",data)
        appointmentList=data
        if appointmentList.count>0{
            let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
            let appointment = appointmentList.filter({ $0.appointmentId == appointmentId })
            print("self.customerlist",self.customerlist)
            self.customerlist=appointment
            
            if billingAddress.count==0{
                
                self.billingAddress = self.customerlist
                self.billingAddress[0].appointmentAddressId=0
                self.billingAddress[0].addressTypeId=1
            }
            billingAddressUpdated()
        }
        
    }
    func billingAddressUpdated(){
        var nameString=String()
        var addressString=String()
        if billingAddress[0].firstName != nil {
            nameString = nameString + billingAddress[0].firstName! + " "
        }
        if billingAddress[0].middleName != nil {
            nameString = nameString + billingAddress[0].middleName! + " "
        }
        if billingAddress[0].lastName != nil {
            nameString = nameString + billingAddress[0].lastName!
        }
        nameLbl.text=nameString
        
        if billingAddress[0].addressLineOne != nil {
            addressString = addressString + billingAddress[0].addressLineOne! + ", "
        }
        if billingAddress[0].addressLineTwo != nil&&billingAddress[0].addressLineTwo != "NULL"&&billingAddress[0].addressLineTwo != "" {
            addressString = addressString + billingAddress[0].addressLineTwo! + ", "
        }
        if billingAddress[0].city != nil {
            addressString = addressString + billingAddress[0].city! + ", "
            
        }
        if billingAddress[0].state != nil {
            addressString = addressString + billingAddress[0].state! + ", "
            
        }
        if billingAddress[0].zip != nil {
            addressString = addressString + billingAddress[0].zip!
            
        }
        adressLbl.text=addressString
        
        //        |appointmentList[indexPath.row].crossStreets == "NULL"&&appointmentList[indexPath.row].gateCode == "NULL"
        
        
        
        if (billingAddress[0].gateCode == nil||billingAddress[0].gateCode == "") && (billingAddress[0].crossStreets == nil||billingAddress[0].crossStreets == "")||billingAddress[0].crossStreets == "NULL"&&billingAddress[0].gateCode == "NULL"{
            gateCodeLbl.isHidden=true
            gateCodeValueLbl.isHidden=true
            crossstreetLbl.isHidden=true
            creossStreetValueLbl.isHidden=true
            crossStreetLblHeight.constant=0
            gatecodeLblheight.constant=0
            
        }else if (billingAddress[0].gateCode == nil||billingAddress[0].gateCode == "")&&(billingAddress[0].crossStreets != nil||billingAddress[0].crossStreets != "")||billingAddress[0].gateCode == "NULL"&&billingAddress[0].crossStreets != "NULL"{
            
            crossstreetLbl.isHidden=true
            gateCodeLbl.isHidden=false
            gatecodeLblheight.constant=25
            crossStreetLblHeight.constant=0
            creossStreetValueLbl.isHidden=true
            gateCodeValueLbl.isHidden=false
            gateCodeLbl.text="Cross Street: "
            gateCodeValueLbl.text=(billingAddress[0].crossStreets ?? "")
        }else if (billingAddress[0].gateCode != nil||billingAddress[0].gateCode != "")&&(billingAddress[0].crossStreets == nil||billingAddress[0].crossStreets == "")||billingAddress[0].gateCode != "NULL"&&billingAddress[0].crossStreets == "NULL"{
            crossstreetLbl.isHidden=true
            gateCodeLbl.isHidden=false
            gateCodeValueLbl.isHidden=false
            creossStreetValueLbl.isHidden=true
            gatecodeLblheight.constant=25
            crossStreetLblHeight.constant=0
            gateCodeLbl.text="Gate Code: "
            gateCodeValueLbl.text=(billingAddress[0].gateCode ?? "")
        }else{
            gatecodeLblheight.constant=25
            crossStreetLblHeight.constant=25
            gateCodeLbl.isHidden=false
            gateCodeValueLbl.isHidden=false
            crossstreetLbl.isHidden=false
            creossStreetValueLbl.isHidden=false
            gateCodeLbl.text="Gate Code: "
            crossstreetLbl.text="Cross Street: "
            gateCodeValueLbl.text=(billingAddress[0].gateCode ?? "")
            creossStreetValueLbl.text=(billingAddress[0].crossStreets ?? "")
        }
        
        if billingAddress[0].cellPhoneNumber == nil || billingAddress[0].cellPhoneNumber == ""||billingAddress[0].cellPhoneNumber == "NULL"{
            phoneImageviewHeight.constant=0
            phoneLblHeight.constant=0
        }else{
            phoneImageviewHeight.constant=25
            phoneLblHeight.constant=25
            billingPhoneImageView.isHidden=false
        }
        
    }
    
    
    func cardValidation(){
        
//                let cardtype = CreditCardDetector.detectCreditCardType(cardNumber: nofinanceModel.CardNumber)
//        print("cardtype",cardtype)
//        var type=cardcell.dropdownBtn.currentTitle
//        var number=String()
//        if cardNumberBuffer==""{
//            number = nofinanceModel.CardNumber ?? ""
//        }else{
//            number = cardNumberBuffer
//        }
//
//        var selectedType:CreditCardType!
//        switch type{
//        case "Visa":
//            selectedType = .visa
//        case "MasterCard":
//            selectedType = .maestro
//        case "Discover":
//            selectedType = .discover
//        case "Amex":
//            selectedType = .amex
//        default:
//            selectedType = .unknown
//        }
//
        
        
//        if CreditCardValidator(number).isValid(for: selectedType) {
            submitbtnAction()
            // getToken()
//        } else {
//            self.showAlertOk(message: "Please enter a valid Card Number for the Card Type selected")
//        }
    }
    
    
    @IBAction func editBtnAction(_ sender: Any) {
        let billingEdit = BillingEditViewController.initialization()!
        billingEdit.customerlist=billingAddress[0]
        
        self.navigationController?.pushViewController(billingEdit, animated: true)
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
        if cardSelected==0{
            setNavigationBarbacklogoNameForFinance(name: "Credit Card Details",superview: navView)
        }else{
            setNavigationBarbacklogoNameForFinance(name: "ACH Details",superview: navView)
        }
        depositPaymentTableView.reloadData()
    }
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return requiredFieldsArray.count
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cardSelected==0{
            return 1
        }else{
            
            return ACHFieldArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cardSelected==0{
            cardcell = tableView.dequeueReusableCell(withIdentifier: "CardDetailTableViewCell") as! CardDetailTableViewCell
            
            
            //
            cardcell.creditCardTxtFld.tag = 1
            cardcell.ExpiretionDateTxtFld.tag = 2
            cardcell.yearTxtFld.tag = 3
            cardcell.CvvTxtFld.tag = 4
            
            cardcell.creditCardTxtFld.text = ""
            cardcell.ExpiretionDateTxtFld.text = ""
            cardcell.yearTxtFld.text = ""
            cardcell.CvvTxtFld.text = ""
            self.textChangeDelegate(cardcell.creditCardTxtFld)
            self.textChangeDelegate(cardcell.ExpiretionDateTxtFld)
            self.textChangeDelegate(cardcell.yearTxtFld)
            self.textChangeDelegate(cardcell.CvvTxtFld)
            
            
            
            cardcell.AcntHolderTxtFld.delegate=self
            cardcell.creditCardTxtFld.delegate=self
            cardcell.ExpiretionDateTxtFld.delegate=self
            cardcell.yearTxtFld.delegate=self
            cardcell.CvvTxtFld.delegate=self
            cardcell.amntTexyFld.delegate=self
            cardcell.AcntHolderTxtFld.text=nofinanceModel.AcntHolderName
            
            if editcardAction==true{
                let text = nofinanceModel.CardNumber
                let newString = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: text)
                cardcell.creditCardTxtFld.text=newString
            }else{
                
                cardcell.creditCardTxtFld.text=nofinanceModel.CardNumber
            }
            //nofinanceModel.CardNumber
            cardcell.AcntHolderTxtFld.text=nofinanceModel.AcntHolderName
            cardcell.ExpiretionDateTxtFld.text=nofinanceModel.Expiration
            cardcell.yearTxtFld.text=nofinanceModel.Year
            cardcell.CvvTxtFld.text=nofinanceModel.Cvv
            cardcell.creditCardTxtFld.text=nofinanceModel.CardNumber
            //cardcell.dropDown.dataSource=cardTypeArray
            //cardcell.dropDown.anchorView=cardcell.dropdownBtn
            // cardcell.dropDown.textFont=UIFont(name: "PublicSans-Regular", size: 24)
            //cardcell.dropdownBtn.addTarget(self, action: #selector(dropdownAction), for: .touchUpInside)
            cardcell.dropdownBtn.setTitle(nofinanceModel.CardType, for: .normal)
            
//            cardcell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                print("Selected item: \(item) at index: \(index)")
//                cardcell.dropdownBtn.setTitle(item, for: .normal)
//                cardcell.dropdownBtn.titleLabel?.font=UIFont(name: "PublicSans-Regular", size: 24)
//                nofinanceModel.CardType=item
//                nofinanceModel.cardTypeIdSelected=String(cardTypeIdArray[index])
//
//            }
//
            cardcell.amntTexyFld.text=nofinanceModel.amount
            cardLbl.textColor=UIColor.white
            cardView.backgroundColor=UIColor().colorFromHexString("#304CCE")
            cardImageView.image=UIImage(named: "Cardunselected")
            checkLbl.textColor=UIColor().colorFromHexString("#304CCE")
            checkView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
            checkImageView.image=UIImage(named: "Cardselected")
            
            
            return cardcell
        }else{
            checkcell = tableView.dequeueReusableCell(withIdentifier: "CheckDetailTableViewCell") as! CheckDetailTableViewCell
            checkLbl.textColor=UIColor.white
            checkView.backgroundColor=UIColor().colorFromHexString("#304CCE")
            checkImageView.image=UIImage(named: "Cardunselected")
            cardLbl.textColor=UIColor().colorFromHexString("#304CCE")
            cardView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
            cardImageView.image=UIImage(named: "Cardselected")
            checkcell.cardnumberTxtFld.delegate=self
            //            checkcell.AcntnumberTxtFld.delegate=self
            //            checkcell.routeNumberTxtFld.delegate=self
            //            checkcell.amntTxtFld.delegate=self
            //            checkcell.cardnumberTxtFld.text=nofinanceModel.CheckNumber
            //            checkcell.AcntnumberTxtFld.text=nofinanceModel.CardNumber
            //            checkcell.routeNumberTxtFld.text=nofinanceModel.Routingnumber
            //            checkcell.amntTxtFld.text=nofinanceModel.amount
            checkcell.cardnumberTxtFld.tag=ACHFieldArray[indexPath.row].id ?? 0
            checkcell.headingLbl.text=(ACHFieldArray[indexPath.row].name ?? "")+"*"
            if indexPath.row != 0{
                checkcell.enterAcHDetailsLbl.isHidden=true
                checkcell.enterACHDetailLblHeight.constant=0
                checkcell.headingtopLblTopconstraint.constant=0
            }else{
                checkcell.enterAcHDetailsLbl.isHidden=false
                checkcell.enterACHDetailLblHeight.constant=26
                checkcell.headingtopLblTopconstraint.constant=40
            }
            if ACHFieldArray[indexPath.row].name=="Account Number"{
                if editcardAction==true{
                    checkcell.cardnumberTxtFld.text=nofinanceModel.CardNumber
                }else{
                    checkcell.cardnumberTxtFld.placeholder=ACHFieldArray[indexPath.row].name
                    checkcell.cardnumberTxtFld.text=nofinanceModel.CardNumber
                }
                checkcell.cardnumberTxtFld.tag=1
                
            }else if  ACHFieldArray[indexPath.row].name=="Routing Number"{
                if editcardAction==true{
                    checkcell.cardnumberTxtFld.text=nofinanceModel.Routingnumber
                }else{
                    checkcell.cardnumberTxtFld.placeholder=ACHFieldArray[indexPath.row].name
                    checkcell.cardnumberTxtFld.text=""
                }
                checkcell.cardnumberTxtFld.tag=2
            }else if  ACHFieldArray[indexPath.row].name=="Amount"{
                if editcardAction==true{
                    checkcell.cardnumberTxtFld.text=nofinanceModel.amount
                }else{
                    checkcell.cardnumberTxtFld.placeholder=ACHFieldArray[indexPath.row].name
                    checkcell.cardnumberTxtFld.text=""
                }
                checkcell.cardnumberTxtFld.tag=3
            }else {
                checkcell.cardnumberTxtFld.placeholder=ACHFieldArray[indexPath.row].name
                
            }
            return checkcell
        }
        
        //        cardcell = tableView.dequeueReusableCell(withIdentifier: "CardDetailTableViewCell") as! CardDetailTableViewCell
        //
        //       // num1 < num2 ? DO SOMETHING IF TRUE : DO SOMETHING IF FALSE
        //        if indexPath.row==0{
        //            cardcell.requiredfieldnameLblTopConstraint.constant=30
        //            cardcell.requiredfieldHeadingHeightConstriant.constant=26
        //            cardcell.Outerview.cornerRadius=8
        //            cardcell.Outerview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //        }else{
        //            cardcell.requiredfieldnameLblTopConstraint.constant=0
        //            cardcell.requiredfieldHeadingHeightConstriant.constant=0
        //            cardcell.Outerview.cornerRadius=0
        //
        ////            cardcell.Outerview.borderColor = .clear
        ////            cardcell.Outerview.borderWidth=0
        //            cardcell.Outerview.removeBottomBorderColor()
        //        }
        //        if indexPath.row==requiredFieldsArray.count-1{
        //            cardcell.Outerview.cornerRadius=8
        //            cardcell.Outerview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        //        }
        //
        ////        cardcell.Outerview.isHidden=true
        //        cardcell.requiredFieldheadingLabel.text="ENTER "+requiredHeadingName.uppercased()+" DETAILS"
        //        cardcell.requiredFieldnameLbl.text=requiredFieldsArray[indexPath.row].name
        //        return cardcell
        
    }
    @objc func dropdownAction(){
        cardcell.dropDown.dataSource=cardTypeArray
        cardcell.dropDown.show()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cardSelected==0{
            return 710
        }else{
            if indexPath.row != 0{
                return 140
            }else{
                return 210
            }
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if indexPath.row==0{
    //            return 200
    //        }else if indexPath.row==requiredFieldsArray.count-1{
    //            return 160
    //        }else{
    //            return 150
    //        }
    //    }
    //
    func CardValidationOnsubmitAction(){
        let validator = AcceptSDKCardFieldsValidator()
        var textfieldArray=[cardcell.creditCardTxtFld,cardcell.ExpiretionDateTxtFld,cardcell.yearTxtFld,cardcell.CvvTxtFld]
        
        for i in 0...textfieldArray.count-1{
            
            switch i{
            case 0:
                
                self.cardNumber = self.cardNumberBuffer
                
                let luhnResult = validator.validateCardWithLuhnAlgorithm(self.cardNumberBuffer)
                
                if ((luhnResult == false) || (textfieldArray[i]?.text?.count < AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardNumberCharacterCountMin))
                {
                    cardcell.creditCardTxtFld.textColor = UIColor.red
                }
                else
                {
                    cardcell.creditCardTxtFld.textColor = .blue //[UIColor greenColor]
                }
                
                if (self.validInputs())
                {
                    print("valid")
                   // isvalidCardnumber=true
                    let cardtype = CreditCardDetector.detectCreditCardType(cardNumber: self.cardNumberBuffer)
                    nofinanceModel.CardType = cardtype.rawValue
                    depositPaymentTableView.reloadData()
                    //                    cardcell.creditCardTxtFld.textColor = .blue
                }
                else
                {
                    //isvalidCardnumber=false
                    // self.showAlertOk(message: "Please enter a valid card number")
                    print("Invalid")
                    //                    cardcell.creditCardTxtFld.textColor = UIColor.red
                }
                
                // break
            case 1:
                self.validateMonth(textfieldArray[i]!)
                if let expYear = cardcell.yearTxtFld.text {
                    self.validateYear(expYear)
                }
                
                // break
            case 2:
                
                self.validateYear(textfieldArray[i]?.text! ?? "")
                
                // break
            case 3:
                
                self.cardVerificationCode = textfieldArray[i]?.text
                
                if (validator.validateSecurityCodeWithString(cardcell.CvvTxtFld.text!))
                {
                    cardcell.CvvTxtFld.textColor = .blue
                }
                else
                {
                    cardcell.CvvTxtFld.textColor = UIColor.red
                }
                
                if (self.validInputs())
                {
                    print("valid")
                    isvalidCvv=true
                }
                else
                {
                    // self.showAlertOk(message: "Please enter a valid Cvv")
                    print("Invalid")
                    isvalidCvv=false
                }
                
                //   break
                
            default:
                break
            }
        }
    }
    
    
    
    
    @IBAction func submitAction(_ sender: Any) {
//        if cardSelected==0{
//
//        }
        if cardSelected==0{
            CardValidationOnsubmitAction()
            nofinanceModel.AcntHolderName=cardcell.AcntHolderTxtFld.text ?? ""
            if cardNumberBuffer==""{
                
            }else{
                nofinanceModel.CardNumber=cardNumberBuffer ?? ""
            }
            nofinanceModel.Expiration=cardcell.ExpiretionDateTxtFld.text ?? ""
            nofinanceModel.Year=cardcell.yearTxtFld.text ?? ""
            nofinanceModel.Cvv=cardcell.CvvTxtFld.text ?? ""
            nofinanceModel.amount=cardcell.amntTexyFld.text ?? ""
            if nofinanceModel.AcntHolderName.trimmingCharacters(in: .whitespaces).isEmpty{
                self.showAlertOk(message: "Account holder name is required. Please enter to proceed")
            }else if nofinanceModel.CardNumber.trimmingCharacters(in: .whitespaces).isEmpty{
                self.showAlertOk(message: "Card Number is required. Please enter to proceed")
                //                }else if nofinanceModel.CardNumber.trimmingCharacters(in: .whitespaces).count < 22{
                //                    self.showAlertOk(message: "Please enter valid Card Number")
                //                } else if !CreditCardDetector.isValidCreditCardNumber(nofinanceModel.CardNumber) {
                //                    self.showAlertOk(message: "Please enter valid Card Number")
            }else if nofinanceModel.Expiration.trimmingCharacters(in: .whitespaces).isEmpty{
                self.showAlertOk(message: "Expiration Month is required. Please enter to proceed.")
            } else if nofinanceModel.Year.trimmingCharacters(in: .whitespaces).isEmpty{
                self.showAlertOk(message: "Expiration Year is required. Please enter to proceed.")
            }else if nofinanceModel.Cvv.trimmingCharacters(in: .whitespaces).isEmpty{
                self.showAlertOk(message: "CVV is required. Please enter to proceed.")
            }else if nofinanceModel.amount.trimmingCharacters(in: .whitespaces).isEmpty{
                self.showAlertOk(message: "Amount is required. Please enter to proceed. amount")
            } else if (nofinanceModel.Expiration as NSString).integerValue>12 {
                    self.showAlertOk(message: "Please enter a valid expiration month to proceed")
                
            }else if !isvalidCardnumber{
                self.showAlertOk(message: "Please enter a valid card number to proceed")
            }
//            else if nofinanceModel.CardType.trimmingCharacters(in: .whitespaces).isEmpty{
//                self.showAlertOk(message: "Card Type is required. Please enter to proceed.")
//            }else if !nofinanceModel.CardType.trimmingCharacters(in: .whitespaces).isEmpty{
//                cardValidation()
                
                
                
            else{
                
                cardValidation()
                //                    getToken()
            }
        }else{
//                        if nofinanceModel.CheckNumber.trimmingCharacters(in: .whitespaces).isEmpty{
//                            self.showAlertOk(message: "ACH Number is required. Please enter to proceed.")
//                        }else
            if nofinanceModel.CardNumber.trimmingCharacters(in: .whitespaces).isEmpty{
                                self.showAlertOk(message: "Account Number is required. Please enter to proceed.")
//                            }
//                            else if nofinanceModel.CardNumber.trimmingCharacters(in: .whitespaces).count < 16{
//                                self.showAlertOk(message: "Please enter valid Account Number")
                            }else if nofinanceModel.Routingnumber.trimmingCharacters(in: .whitespaces).isEmpty{
                                self.showAlertOk(message: "Routing Number is required. Please enter to proceed.")
//                            }
//            else if nofinanceModel.Routingnumber.count <= 8
//                            {
//                                self.showAlertOk(message: "Routing number should be 9 digits.")
                                
                            } else if nofinanceModel.amount.trimmingCharacters(in: .whitespaces).isEmpty{
                                self.showAlertOk(message: "Amount is required. Please enter to proceed.")
                            }else{
                               
                                submitbtnAction()
                            }
                        }
//            }
        
        
        
        
    }
    
    func transactionApi(){
        var parameters = [String:Any]()
        var billingadress=[String:String]()
        var emailAddress=emailTextField.text ?? ""
        var zipCode=zipcodeTextField.text ?? ""
        billingadress=["firstName":optionalString(value:  billingAddress[0].firstName ?? ""),
                       "lastName": optionalString(value:  billingAddress[0].lastName ?? ""),
                       "address": optionalString(value:  billingAddress[0].addressLineOne ?? ""),
                       "city": optionalString(value:  billingAddress[0].city ?? ""),
                       "zip": optionalString(value:  zipCode)]
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        parameters=["appointmentId":appointmentId,"transactionAmount":Double(cardcell.amntTexyFld.text ?? "") ?? 0,"transactionToken":self.authorize_token,"billingAddress":billingadress,"emailAddress":optionalString(value:  emailAddress)]
        print("parameters",parameters)
        customerlistViewModel.transactionApi(parameters: parameters) { success, transaction, message in
            if success{
                if transaction?.isSuccessful ?? true{
                    //self.transactionDetails(data: transaction ?? else{
                    balanceNoFinanceSelectedModel.transactionID=transaction?.transactionId ?? ""
                    self.popupActionSuccess()
                }else{
                    if transaction?.errorText != nil{
                        
                        self.errorText = transaction?.errorText ?? ""
                    }else{
                        self.errorText = "The payment transaction is declined"
                    }
                    self.popupActionFailed()
                }
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.transactionApi()
                    }
                    
                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                }else{
                    //self.popupActionFailed()
                    self.showAlertOk(message: message)
                }
                
            }
        }
    }
    func balancetransactionApi(){
        var parameters = [String:Any]()
        var billingadress=[String:String]()
        var emailAddress=String()
        var zipCode=zipcodeTextField.text ?? ""
        billingadress=["firstName":optionalString(value:  billingAddress[0].firstName ?? ""),
                       "lastName": optionalString(value:  billingAddress[0].lastName ?? ""),
                       "address": optionalString(value:  billingAddress[0].addressLineOne ?? ""),
                       "city": optionalString(value:  billingAddress[0].city ?? ""),
                       "zip": optionalString(value:  zipCode)]
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
      
            emailAddress=emailTextField.text ?? ""
        
        parameters=["appointmentId":appointmentId,"transactionAmount":Double(cardcell.amntTexyFld.text ?? "") ?? 0,"transactionToken":self.authorize_token,"billingAddress":billingadress,"emailAddress":emailAddress]
        print("parameters",parameters)
        customerlistViewModel.balncetransactionApi(parameters: parameters) { success, transaction, message in
            if success{
                if transaction?.isSuccessful ?? true{
                    //self.transactionDetails(data: transaction ?? else{
                    balanceNoFinanceSelectedModel.profileID=transaction?.profileId ?? ""
                    balanceNoFinanceSelectedModel.transactionID=transaction?.transactionId ?? ""
                    self.popupActionSuccess()
                }else{
                    if transaction?.errorText != nil{
                        
                        self.errorText = transaction?.errorText ?? ""
                    }else{
                        self.errorText = "The payment transaction is declined"
                    }
                    self.popupActionFailed()
                }
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.balancetransactionApi()
                    }
                    
                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                }else{
                    //self.popupActionFailed()
                    self.showAlertOk(message: message)
                }
                
            }
        }
    }
    private func transactionDetails(data: Transaction) {
        print("data",data)
        
        
    }
    
    
    
    func ACHtransactionApi(){
        var parameters = [String:Any]()
        var billingadress=[String:String]()
        var emailAddress=emailTextField.text ?? ""
        var zipCode=zipcodeTextField.text ?? ""
        
        billingadress=["firstName":optionalString(value:  billingAddress[0].firstName ?? ""),
                       "lastName": optionalString(value:  billingAddress[0].lastName ?? ""),
                       "address": optionalString(value:  billingAddress[0].addressLineOne ?? ""),
                       "city": optionalString(value:  billingAddress[0].city ?? ""),
                       "zip": optionalString(value:  zipCode)]
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        parameters=["appointmentId":appointmentId,"transactionAmount":Double(nofinanceModel.amount) ?? 0,"accountNumber":nofinanceModel.CardNumber,"routingNumber":nofinanceModel.Routingnumber,"nameOnAccount":nofinanceModel.AcntHolderName,"billingAddress":billingadress,"emailAddress":optionalString(value:  emailAddress)]
        print("parameters",parameters)
        customerlistViewModel.ACHtransactionApi(parameters: parameters) { success, transaction, message in
            if success{
                if transaction?.isSuccessful ?? true{
                    //self.transactionDetails(data: transaction ?? else{
                    balanceNoFinanceSelectedModel.transactionID=transaction?.transactionId ?? ""
                    self.popupActionSuccess()
                }else{
                    if transaction?.errorText != nil{
                        
                        self.errorText = transaction?.errorText ?? ""
                    }else{
                        self.errorText = "The payment transaction is declined"
                    }
                    self.popupActionFailed()
                }
                //self.transactionDetails(data: transaction ?? <#default value#>)
               
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.ACHtransactionApi()
                    }
                    
                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                }else{
                   // self.popupActionFailed()
                    self.showAlertOk(message: message)
                }
                
            }
        }
    }
    
    func BalanceACHtransactionApi(){
        var parameters = [String:Any]()
        var billingadress=[String:String]()
        var emailAddress=String()
        var zipCode=zipcodeTextField.text ?? ""
        billingadress=["firstName":optionalString(value:  billingAddress[0].firstName ?? ""),
                       "lastName": optionalString(value:  billingAddress[0].lastName ?? ""),
                       "address": optionalString(value:  billingAddress[0].addressLineOne ?? ""),
                       "city": optionalString(value:  billingAddress[0].city ?? ""),
                       "zip": optionalString(value:  zipCode)]
//
            emailAddress=emailTextField.text ?? ""
//
        let appointmentId=UserDefaults.standard.value(forKey: "appointmentID") as! Int
        parameters=["appointmentId":appointmentId,"transactionAmount":Double(nofinanceModel.amount) ?? 0,"accountNumber":nofinanceModel.CardNumber,"routingNumber":nofinanceModel.Routingnumber,"nameOnAccount":nofinanceModel.AcntHolderName,"billingAddress":billingadress,"emailAddress":emailAddress]
        print("parameters",parameters)
        customerlistViewModel.BalanceACHtransactionApi(parameters: parameters) { success, transaction, message in
            if success{
                if transaction?.isSuccessful ?? true{
                    //self.transactionDetails(data: transaction ?? else{
                    balanceNoFinanceSelectedModel.profileID=transaction?.profileId ?? ""
                    balanceNoFinanceSelectedModel.transactionID=transaction?.transactionId ?? ""
                    self.popupActionSuccess()
                }else{
                    if transaction?.errorText != nil{
                        
                        self.errorText = transaction?.errorText ?? ""
                    }else{
                        self.errorText = "The payment transaction is declined"
                    }
                    self.popupActionFailed()
                }
                //self.transactionDetails(data: transaction ?? <#default value#>)
               
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                        
                        self.BalanceACHtransactionApi()
                    }
                    
                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                }else{
                    //self.popupActionFailed()
                    
                    self.showAlertOk(message: message)
                }
                
            }
        }
        
    }
    
    func submitbtnAction(){
        print("actualSaleAmount",actualSaleAmount)
        
        var depositAmount=0.0
        var text=""
        if cardSelected==0{
            text=cardcell.amntTexyFld.text ?? ""
        }else{
            //text=checkcell.amntTxtFld.text ?? ""
            text=nofinanceModel.amount
        }
        
        if isFromBalancePaymentVC==false{
            
            if nofinanceModel.DepositFinanceProviderArray.count==0{
                depositAmount=0.00
            }else{
                // depositAmount=0.00
                for i  in 0...nofinanceModel.DepositFinanceProviderArray.count-1{
                    let amount1=nofinanceModel.DepositFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                    let amount2=Double(amount1) ?? 0.0
                    depositAmount+=amount2
                    
                }
            }
            
            
            
            if nofinanceModel.cardCheckDetailArray.count==0{
                let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
                if depositAmount<=actualSaleAmount{
                    if cardSelected==0{
                        self.showLoader()
                        getToken()
                    }else{
//                        if isFromBalancePaymentVC==true{
                       
                           showemailvalidationView()
                           
                            
                           // BalanceACHtransactionApi()
//                        }else{
//                            ACHtransactionApi()
//                        }
                       // cardUpdation()
                    }
                }else{
                    self.showAlertOk(message: "The deposit amount should not be higher than overstock price")
                }
                
            }else{
                
                for i  in 0...nofinanceModel.cardCheckDetailArray.count-1{
                    //
                    
                    if i==editedIndex{
                        
                        
                        
                    }else{
                        let amount1=nofinanceModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                    }
                    
                }
                let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
                
                
                
                //                    if i==editedIndex{
                //                        if nofinanceModel.cardCheckDetailArray[i]["amount"]==""{
                //                            let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                //                            let amount2=Double(amount1) ?? 0.0
                //                            depositAmount+=amount2
                //                            //                            if depositAmount<=8000.00{
                //                            //                                cardUpdation()
                //                            //                            }else{
                //                            //                                self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
                //                            //                            }
                //                        }else{
                ////                            let amount1=nofinanceModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                ////                            let amount2=Double(amount1) ?? 0.0
                ////                            depositAmount+=amount2
                //                            let amount1text=text.replacingOccurrences(of: ",", with: "") ?? ""
                //                            let amount2text=Double(amount1text) ?? 0.0
                //                            depositAmount+=amount2text
                //                            //                            if depositAmount<=8000.00{
                //                            //                                cardUpdation()
                //                            //                            }else{
                //                            //                                self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
                //                            //                            }
                //                        }
                //                    }else{
                //                        let amount1=nofinanceModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                //                        let amount2=Double(amount1) ?? 0.0
                //                        depositAmount+=amount2
                //                        let amount1text=text.replacingOccurrences(of: ",", with: "") ?? ""
                //                        let amount2text=Double(amount1text) ?? 0.0
                //                        depositAmount+=amount2text
                //                        //                        if depositAmount<=8000.00{
                //                        //                            cardUpdation()
                //                        //                        }else{
                //                        //                            self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
                //                        //                        }
                //                    }
                //                }
                print("actualSaleAmount",actualSaleAmount)
                if depositAmount<=actualSaleAmount{
                    if cardSelected==0{
                        self.showLoader()
                        getToken()
                    }else{
//                        if isFromBalancePaymentVC==true{
                            showemailvalidationView()
                           
//                            //BalanceACHtransactionApi()
//                        }else{
//                            ACHtransactionApi()
//                        }
                    }
                }else{
                    self.showAlertOk(message: "The deposit amount should not be higher than overstock price")
                }
            }
            
            
            //            if cardSelected==0{
            //                let amount1=cardcell.amntTexyFld.text?.replacingOccurrences(of: ",", with: "") ?? ""
            //                let amount2=Double(amount1) ?? 0.0
            //                if depositAmount+amount2>8000.00{
            //                    self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
            ////                    navigation()
            //
            //                }else{
            //                    cardUpdation()
            //
            //                }
            //            }else{
            //
            //                let amount1=checkcell.amntTxtFld.text?.replacingOccurrences(of: ",", with: "") ?? ""
            //                let amount2=Double(amount1) ?? 0.0
            //                if depositAmount+amount2>8000.00{
            //                    self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
            ////                    navigation()
            //                }else{
            //                    cardUpdation()
            //
            //                }
            //            }
            
            
        }else{
            
            if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
                depositAmount=0.00
            }else{
                //
                for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
                    let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                    let amount2=Double(amount1) ?? 0.0
                    depositAmount+=amount2
                    
                }
            }
            
            
            if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
                let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
                let balance_Amount=balance_Amount.replacingOccurrences(of: ",", with: "")
                if depositAmount<=(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                    if cardSelected==0{
                        self.showLoader()
                        getToken()
                    }else{
//                        if isFromBalancePaymentVC==true{
                            showemailvalidationView()
                           
//                                //BalanceACHtransactionApi()
//                        }else{
//                            ACHtransactionApi()
//                        }
                    }
                }else{
                    self.showAlertOk(message: "The  amount should not be higher than  balance amount")
                }
                
            }else{
                
                for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                    //
                    if i==editedIndex{
                        
                        
                        
                    }else{
                        let amount1=balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                    }
                    
                }
                let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
                //                    if i==editedIndex{
                //                        if balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]==""{
                //                            let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                //                            let amount2=Double(amount1) ?? 0.0
                //                            depositAmount+=amount2
                //                            //  let balance_Amount=balance_Amount.replacingOccurrences(of: ",", with: "")
                //                            //                            if depositAmount<(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                //                            //
                //                            //                               cardUpdation()
                //                            //                            }else{
                //                            //                                self.showAlertOk(message: "The  amount should not be higher than  balance amount")
                //                            //                            }
                //                        }else{
                //                            let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                //                            let amount2=Double(amount1) ?? 0.0
                //                            depositAmount+=amount2
                //                            //let balance_Amount=balance_Amount.replacingOccurrences(of: ",", with: "")
                //                            //                            if depositAmount<(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                //                            //
                //                            //                               cardUpdation()
                //                            //                            }else{
                //                            //                                self.showAlertOk(message: "The  amount should not be higher than  balance amount")
                //                            //                            }
                //                        }
                //                    }else{
                //                        //                        if balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]==""{
                //                        //
                //                        //                        }else{
                //                        let amount1=balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                //                        let amount2=Double(amount1) ?? 0.0
                //                        depositAmount+=amount2
                ////                                                    let amount1text=text.replacingOccurrences(of: ",", with: "") ?? ""
                ////                                                    let amount2text=Double(amount1text) ?? 0.0
                ////                                                    depositAmount+=amount2text
                //                    }
                //                    //                        let balance_Amount=balance_Amount.replacingOccurrences(of: ",", with: "")
                //                    //                        if depositAmount<(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                //                    //
                //                    //                           cardUpdation()
                //                    //                        }else{
                //                    //                            self.showAlertOk(message: "The  amount should not be higher than  balance amount")
                //                    //                        }
                //                    //}
                //                }
                let balance_Amount=balance_Amount.replacingOccurrences(of: ",", with: "")
                if depositAmount<=(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                    if cardSelected==0{
                        self.showLoader()
                        getToken()
                    }else{
//                        if isFromBalancePaymentVC==true{
                            showemailvalidationView()
                            
                           // BalanceACHtransactionApi()
//                        }else{
//                            ACHtransactionApi()
//                        }
                    }
                    //cardUpdation()
                }else{
                    self.showAlertOk(message: "The amount should not be higher than  balance amount")
                }
            }
            
            //            if cardSelected==0{
            //                let amount1=cardcell.amntTexyFld.text?.replacingOccurrences(of: ",", with: "") ?? ""
            //                let amount2=Double(amount1) ?? 0.0
            //                if depositAmount+amount2>8000.00{
            //                    self.showAlertOk(message: "The amount should not be greater than balance amount.")
            ////                    navigation()
            //                }else{
            //                    cardUpdation()
            //
            //                }
            //            }else{
            //
            //                let amount1=checkcell.amntTxtFld.text?.replacingOccurrences(of: ",", with: "") ?? ""
            //                let amount2=Double(amount1) ?? 0.0
            //                if depositAmount+amount2>8000.00{
            //                    self.showAlertOk(message: "The amount should not be greater than balance amount.")
            ////                    navigation()
            //                }else{
            //                    cardUpdation()
            //
            //                }
            //            }
            
            
        }
        
        //        let cardtype = CreditCardDetector.detectCreditCardType(cardNumber: nofinanceModel.CardNumber)
        
    }
    
    
    func cardUpdation(){
        print(nofinanceModel.cardCheckArrayDict)
        print(nofinanceModel.cardCheckDetailArray)
        if cardSelected==0{
            nofinanceModel.cardType_Array=cardTypeArray
            let insensitiveResults=cardArrayForCreditCard.filter({ $0.financeServiceProviderName?.lowercased() == nofinanceModel.CardType.lowercased()})
//            let insensitiveResults = filterStrings(in: cardTypeArray, with: nofinanceModel.CardType, caseSensitive: false)
            print(insensitiveResults)
            if insensitiveResults.count>0{
                nofinanceModel.cardTypeIdSelected=String(insensitiveResults[0].financeServiceProviderId ?? 0)
            }
            nofinanceModel.cardCheckArrayDict.updateValue(cardcell.dropdownBtn.currentTitle ?? "", forKey: "cardType")
            nofinanceModel.cardCheckArrayDict.updateValue(nofinanceModel.cardTypeIdSelected, forKey: "cardTypeIdSelected")
            nofinanceModel.cardCheckArrayDict.updateValue(cardcell.AcntHolderTxtFld.text ?? "", forKey: "accountHolderName")
            
            if cardNumberBuffer==""{
                nofinanceModel.cardCheckArrayDict.updateValue(nofinanceModel.CardNumber ?? "", forKey: "creditCardNumber")
            }else{
                nofinanceModel.cardCheckArrayDict.updateValue(cardNumberBuffer ?? "", forKey: "creditCardNumber")
                let substring=subString(from: (cardNumberBuffer as? NSString ?? ""), length: 4)
                    nofinanceModel.cardCheckArrayDict.updateValue(substring, forKey: "last4")
            }
            
            nofinanceModel.cardCheckArrayDict.updateValue(cardcell.ExpiretionDateTxtFld.text ?? "", forKey: "expirationMonth")
            nofinanceModel.cardCheckArrayDict.updateValue(cardcell.yearTxtFld.text ?? "", forKey: "expirationYear")
            nofinanceModel.cardCheckArrayDict.updateValue(cardcell.ExpiretionDateTxtFld.text ?? "", forKey: "expirationDate")
            nofinanceModel.cardCheckArrayDict.updateValue(cardcell.CvvTxtFld.text ?? "", forKey: "cvv")
            nofinanceModel.cardCheckArrayDict.updateValue(self.authorize_token, forKey: "cardtoken")
            nofinanceModel.cardCheckArrayDict.updateValue(balanceNoFinanceSelectedModel.profileID,forKey: "profileID")
            nofinanceModel.cardCheckArrayDict.updateValue(balanceNoFinanceSelectedModel.transactionID,forKey: "transactionID")
            
            
            //            let amount1=String((cardcell.amntTexyFld.text as? NSString)?.integerValue ?? 0)
            //            let amount1=cardcell.amntTexyFld.text!.replacingOccurrences(of: ".", with: "")
            //            let amount2=amount1.replacingOccurrences(of: ",", with: "")
            if cardcell.amntTexyFld.text!.contains("."){
                nofinanceModel.cardCheckArrayDict.updateValue(cardcell.amntTexyFld.text!, forKey: "amount")
            }else{
                
                let amount1=cardcell.amntTexyFld.text!.replacingOccurrences(of: ".", with: "")
                let amount2=amount1.replacingOccurrences(of: ",", with: "")
                let amount3=String((amount2 as? NSString)?.integerValue ?? 0)
                nofinanceModel.cardCheckArrayDict.updateValue(amount3.numberFormatter(amount: amount3), forKey: "amount")
            }
            
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "checkNumber")
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "routingNumber")
            print("nofinanceModel.cardCheckArrayDict", nofinanceModel.cardCheckArrayDict)
        }else{
            nofinanceModel.cardCheckArrayDict.updateValue("ACH", forKey: "cardType")
            
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "cardTypeIdSelected")
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey:"accountHolderName")
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "expirationMonth")
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "expirationYear")
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "cvv")
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "checkNumber")
            nofinanceModel.cardCheckArrayDict.updateValue(nofinanceModel.CardNumber, forKey: "creditCardNumber")
            
            let substring=subString(from: (nofinanceModel.CardNumber as? NSString ?? ""), length: 4)
                nofinanceModel.cardCheckArrayDict.updateValue(substring, forKey: "last4")
            
            nofinanceModel.cardCheckArrayDict.updateValue("", forKey: "cardtoken")
            nofinanceModel.cardCheckArrayDict.updateValue(balanceNoFinanceSelectedModel.profileID,forKey: "profileID")
            nofinanceModel.cardCheckArrayDict.updateValue(balanceNoFinanceSelectedModel.transactionID,forKey: "transactionID")
            
            if nofinanceModel.amount.contains("."){
                let amount1=nofinanceModel.amount.replacingOccurrences(of: ",", with: "")
                nofinanceModel.cardCheckArrayDict.updateValue(amount1.numberFormatter1(amount: amount1), forKey: "amount")
            }else{
                let amount1=nofinanceModel.amount.replacingOccurrences(of: ".", with: "")
                let amount2=amount1.replacingOccurrences(of: ",", with: "")
                let amount3=String((amount2 as? NSString)?.integerValue ?? 0)
                nofinanceModel.cardCheckArrayDict.updateValue(amount3.numberFormatter(amount: amount3), forKey: "amount")
            }
            // nofinanceModel.cardCheckArrayDict.updateValue(checkcell.amntTxtFld.text?.numberFormatter(amount: checkcell.amntTxtFld.text ?? "") ?? "", forKey: "amount")
            nofinanceModel.cardCheckArrayDict.updateValue(nofinanceModel.Routingnumber, forKey: "routingNumber")
        }
        
        if editcardAction==true{
            if isFromBalancePaymentVC==true{
                balanceNoFinanceSelectedModel.cardCheckDetailArray.remove(at: editedIndex)
                balanceNoFinanceSelectedModel.cardCheckDetailArray.append(nofinanceModel.cardCheckArrayDict)
            }else{
                
                nofinanceModel.cardCheckDetailArray.remove(at: editedIndex)
                nofinanceModel.cardCheckDetailArray.append(nofinanceModel.cardCheckArrayDict)
                
            }
            
        }else{
            if isFromBalancePaymentVC==true{
            balanceNoFinanceSelectedModel.cardCheckDetailArray.append(nofinanceModel.cardCheckArrayDict)
            }else{
                
                nofinanceModel.cardCheckDetailArray.append(nofinanceModel.cardCheckArrayDict)
                
            }
        }
        
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
        
      projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=nofinanceModel.cardCheckDetailArray
        
        
        navigation()
        
    }
    
//    func cardUpdationv(){
//
//        for i in 0...requiredFieldsArray.count-1{
//            let index = IndexPath(row: i, section: 0)
//            let cell: CardDetailTableViewCell = depositPaymentTableView.cellForRow(at: index) as! CardDetailTableViewCell
//
//            //            let dict=[requiredFieldsArray[i].name ?? "":cell.AcntHolderTxtFld.text ?? ""]
//            nofinanceModel.cardCheckArrayDict.updateValue(cell.AcntHolderTxtFld.text ?? "", forKey:requiredFieldsArray[i].name ?? "" )
//
//
//
//        }
//
//        print("nofinanceModel.cardCheckArrayDict",nofinanceModel.cardCheckArrayDict)
//        print("nofinanceModel.cardCheckDetailArray",nofinanceModel.cardCheckDetailArray)
//        nofinanceModel.cardCheckDetailArray.append(nofinanceModel.cardCheckArrayDict)
//
//
//    }
    func navigation(){
        self.navigationController?.popViewController(animated: true)
        //        if isFromBalancePaymentVC==true{
        //
        //            let balancePayment = BalancePaymentOptionViewController.initialization()!
        //
        ////            balancePayment.isFromBalanceVC=isFromBalancePaymentVC
        //            self.navigationController?.pushViewController(balancePayment, animated: true)
        //        }else{
        //            let financeOptions = FinanceOptionsViewController.initialization()!
        //            financeOptions.submitted=true
        //
        //            self.navigationController?.pushViewController(financeOptions, animated: true)
        //        }
    }
    //        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //            if textField == cardcell.creditCardTxtFld{
    //                guard let text = textField.text else { return false }
    //                let newString = (text as NSString).replacingCharacters(in: range, with: string)
    //                textField.text = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: newString)
    //                nofinanceModel.CardNumber=textField.text ?? ""
    //                return false
    //            }
    //            if textField == cardcell.ExpiretionDateTxtFld{
    //                guard let text = textField.text else { return false }
    //                let newString = (text as NSString).replacingCharacters(in: range, with: string)
    //                textField.text = self.format(with: "XX/XX", phone: newString)
    //                nofinanceModel.Expiration=textField.text ?? ""
    //
    //                let inputString = textField.text ?? ""
    //                let splits = inputString.components(separatedBy: "/")
    //                expiryYear=splits[1]
    //                expiryMonth=splits[0]
    //                return false
    //            }
    //            if textField == cardcell.CvvTxtFld{
    //                guard let text = textField.text else { return false }
    //                let newString = (text as NSString).replacingCharacters(in: range, with: string)
    //                textField.text = self.format(with: "XXX", phone: newString)
    //                nofinanceModel.Cvv=textField.text ?? ""
    //                return false
    //            }
    //
    //            if textField==cardcell.AcntHolderTxtFld{
    //                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    //                nofinanceModel.AcntHolderName=text
    //            }
    //            if textField==cardcell.amntTexyFld{
    //                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    ////                let value=(text as NSString).intValue
    ////               print("value",value)
    //
    //                nofinanceModel.amount=text
    //            }
    //            if textField == cardcell.amntTexyFld {
    //                let allowedCharacters = CharacterSet(charactersIn:"+.0123456789")//Here change this characters based on your requirement
    //                let characterSet = CharacterSet(charactersIn: string)
    //                return allowedCharacters.isSuperset(of: characterSet)
    //            }
    //
    //
    ////            if textField==cardcell.creditCardTxtFld{
    ////                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    ////                nofinanceModel.CardNumber=text
    ////            }
    ////            if textField==cardcell.ExpiretionDateTxtFld{
    ////                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    ////                nofinanceModel.Expiration=text
    ////            }
    ////            if textField==cardcell.CvvTxtFld{
    ////                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    ////                nofinanceModel.Cvv=text
    ////            }
    //
    //
    //            if textField == checkcell.AcntnumberTxtFld{
    //                guard let text = textField.text else { return false }
    //                let newString = (text as NSString).replacingCharacters(in: range, with: string)
    //                textField.text = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: newString)
    //                nofinanceModel.CardNumber=textField.text ?? ""
    //                return false
    //            }
    //            if textField==checkcell.cardnumberTxtFld{
    //                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    //                nofinanceModel.CheckNumber=text
    //            }
    //            if textField==checkcell.routeNumberTxtFld{
    //                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    //                nofinanceModel.Routingnumber=text
    //            }
    //            if textField==checkcell.amntTxtFld{
    //                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    ////                let value=(text as NSString).integerValue
    ////                let roundedValue=(String(format: "%.2f", value))
    //                nofinanceModel.amount=text
    //
    //            }
    //            if textField == checkcell.amntTxtFld {
    //                let allowedCharacters = CharacterSet(charactersIn:"+.0123456789")//Here change this characters based on your requirement
    //                let characterSet = CharacterSet(charactersIn: string)
    //                return allowedCharacters.isSuperset(of: characterSet)
    //            }
    //
    //            return true
    //        }
    
    @IBAction func checkBtnAction(_ sender: Any) {
        checkLbl.textColor=UIColor.white
        checkView.backgroundColor=UIColor().colorFromHexString("#304CCE")
        checkImageView.image=UIImage(named: "Cardunselected")
        cardLbl.textColor=UIColor().colorFromHexString("#304CCE")
        cardView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
        cardImageView.image=UIImage(named: "Cardselected")
        cardSelected=1
        depositPaymentTableView.reloadData()
    }
    
    @IBAction func creditcardBtnAction(_ sender: Any) {
        cardLbl.textColor=UIColor.white
        cardView.backgroundColor=UIColor().colorFromHexString("#304CCE")
        cardImageView.image=UIImage(named: "Cardunselected")
        checkLbl.textColor=UIColor().colorFromHexString("#304CCE")
        checkView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
        checkImageView.image=UIImage(named: "Cardselected")
        cardSelected=0
        depositPaymentTableView.reloadData()
    }
    
    @IBAction func editbtnAction(_ sender: Any) {
        
        
    }
    func validInputs() -> Bool {
        var inputsAreOKToProceed = false
        
        let validator = AcceptSDKCardFieldsValidator()
        
        if (validator.validateSecurityCodeWithString(cardcell.CvvTxtFld.text!) && validator.validateExpirationDate(cardcell.ExpiretionDateTxtFld.text!, inYear: cardcell.yearTxtFld.text!) && validator.validateCardWithLuhnAlgorithm(self.cardNumberBuffer)) {
            inputsAreOKToProceed = true
        }
        
        return inputsAreOKToProceed
    }
    
    func textChangeDelegate(_ textField: UITextField) {
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: nil, using: { note in
            if textField==self.cardcell.creditCardTxtFld{
                print("card...")
            }
            if (self.validInputs()) {
                // self.updateTokenButton(true)
                
            } else {
                //  self.updateTokenButton(false)
            }
        })
    }
    func formatCardNumber(_ textField:UITextField) {
        var value = String()
        
        if textField == cardcell.creditCardTxtFld {
            let length = self.cardNumberBuffer.count
            
            for (i, _) in self.cardNumberBuffer.enumerated() {
                
                // Reveal only the last character.
                if (length <= kAcceptSDKDemoCreditCardObscureLength) {
                    if (i == (length - 1)) {
                        let charIndex = self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: i)
                        let tempStr = String(self.cardNumberBuffer.suffix(from: charIndex))
                        //let singleCharacter = String(tempStr.characters.first)
                        
                        value = value + tempStr
                    } else {
                        value = value + "●"
                        
                    }
                } else {
                    if (i < kAcceptSDKDemoCreditCardObscureLength) {
                        value = value + "●"
                    } else {
                        let charIndex = self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: i)
                        let tempStr = String(self.cardNumberBuffer.suffix(from: charIndex))
                        //let singleCharacter = String(tempStr.characters.first)
                        //let singleCharacter = String(tempStr.characters.suffix(1))
                        
                        value = value + tempStr
                        break
                    }
                }
                
                //After 4 characters add a space
                if (((i + 1) % 4 == 0) && (value.count < kAcceptSDKDemoCreditCardLengthPlusSpaces)) {
                    value = value + kAcceptSDKDemoSpace
                }
            }
        }
        
        textField.text = value
        // nofinanceModel.CardNumber=value
    }
    func filterStrings(in array: [String], with searchTerm: String, caseSensitive: Bool = false) -> [String] {
        if caseSensitive {
            return array.filter { $0.contains(searchTerm) }
        } else {
            return array.filter { $0.lowercased().contains(searchTerm.lowercased()) }
        }
    }
    func isMaxLength(_ textField:UITextField) -> Bool {
        var result = false
        
        if (textField.tag == cardcell.creditCardTxtFld.tag && textField.text?.count > kAcceptSDKDemoCreditCardLengthPlusSpaces)
        {
            result = true
        }
        
        if (textField == cardcell.ExpiretionDateTxtFld && textField.text?.count == kAcceptSDKDemoExpirationMonthLength)
        {
            result = true
        }
        if (textField == cardcell.yearTxtFld && textField.text?.count == kAcceptSDKDemoExpirationYearLength)
        {
            result = true
        }
        if (textField == cardcell.CvvTxtFld && textField.text?.count > kAcceptSDKDemoCVV2Length)
        {
            result = true
        }
        
        return result
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {        print(textField.text ?? "")
        print("beginediting")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var cardNumbertemp=String()
        print("string",string)
        
        
        if textField == cardcell.creditCardTxtFld{
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
//            textField.text = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: newString)
            nofinanceModel.CardNumber=newString
//            return false
        }
        if textField == cardcell.ExpiretionDateTxtFld{
                    guard let text = textField.text else { return false }
                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
                    textField.text = self.format(with: "XX", phone: newString)
            nofinanceModel.Expiration=textField.text ?? ""

//            let inputString = textField.text ?? ""
//            let splits = inputString.components(separatedBy: "/")
//            expiryYear=splits[1]
//            expiryMonth=splits[0]
                    return false
        }
        if textField == cardcell.yearTxtFld{
                    guard let text = textField.text else { return false }
                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
                    textField.text = self.format(with: "XX", phone: newString)
            nofinanceModel.Year=textField.text ?? ""

//            let inputString = textField.text ?? ""
//            let splits = inputString.components(separatedBy: "/")
//            expiryYear=splits[1]
//            expiryMonth=splits[0]
                    return false
        }
        if textField == cardcell.CvvTxtFld{
            guard let text = textField.text else { return false }
                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
                    textField.text = self.format(with: "XXXX", phone: newString)
            nofinanceModel.Cvv=textField.text ?? ""
                    return false
        }
//
        if textField==cardcell.AcntHolderTxtFld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            nofinanceModel.AcntHolderName=text
        }
        if textField==cardcell.amntTexyFld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//                let value=(text as NSString).intValue
//               print("value",value)

            nofinanceModel.amount=text
        }
        
        
        
        
        let result = true
        if cardSelected==0{
            switch (textField.tag)
            {
            case 1:
                if textField==cardcell.creditCardTxtFld{
                    cardcell.creditCardTxtFld.textColor=UIColor.blue
                    //                if textField.text?.isEmpty==true{
                    //                    self.cardNumberBuffer=""
                    //                }else{
                    //                    self.cardNumberBuffer=textField.text
                    //                }
                    print(textField.text ?? "")
                    if containsOnlyLetters(input: string){
                        if string.isEmpty==true{
                            //                        if let itemToRemove = textField.text?.dropLast(){
                            //                           // let text = textField.text?.replacingOccurrences(of: itemToRemove, with: "")
                            //                           // textField.text = text
                            //
                            //                            self.cardNumberBuffer=String(itemToRemove)
                            //                        }
                            // self.cardNumberBuffer=textField.text
                            guard let currentText = textField.text else { return true }
                            
                            // Calculate the new text after the replacement
                            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                            
                            // Use the updatedText which is the entire string
                            print("Entire string:", updatedText)
                            self.cardNumberBuffer=updatedText
                           
                            return true
                        }else{
                            return false
                        }
                        //nofinanceModel.CardNumber=self.cardNumberBuffer
                    }else{
                        
                        //                    if (string.count > 0)
                        //                    {
                        ////                        if (self.isMaxLength(textField)) {
                        ////                            return false
                        ////                        }
                        //
                        //                        self.cardNumberBuffer = String(format: "%@%@", self.cardNumberBuffer, string)
                        //                    }
                        //                    else
                        //                    {
                        //                        if (self.cardNumberBuffer.count > 1)
                        //                        {
                        //                            let length = self.cardNumberBuffer.count - 1
                        //
                        //                            //self.cardNumberBuffer = self.cardNumberBuffer[self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: 0)...self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: length-1)]
                        //
                        //                            self.cardNumberBuffer = String(self.cardNumberBuffer[self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: 0)...self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: length - 1)])
                        //                        }
                        //                        else
                        //                        {
                        //                            self.cardNumberBuffer = ""
                        //                        }
                        //                    }
                        
                    }
                    guard let currentText = textField.text else { return true }
                    
                    // Calculate the new text after the replacement
                    let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                    
                    // Use the updatedText which is the entire string
                    print("Entire string:", updatedText)
                    self.cardNumberBuffer=updatedText
                    //textField.text = self.cardNumberBuffer
                    //self.formatCardNumber(textField)
                   // nofinanceModel.CardNumber=self.cardNumberBuffer
                    return true
                }
                
                
                
            case 2:
                
                if (string.count > 0) {
                    if (self.isMaxLength(textField)) {
                        return false
                    }
                }
                
                break
            case 3:
                
                if (string.count > 0) {
                    if (self.isMaxLength(textField)) {
                        return false
                    }
                }
                
                break
            case 4:
                
                if (string.count > 0) {
                    if (self.isMaxLength(textField)) {
                        return false
                    }
                }
                
                break
                
            default:
                break
            }
        }
        
//                if textField == cardcell.creditCardTxtFld{
        //            guard let text = textField.text else { return false }
        //            let newString = (text as NSString).replacingCharacters(in: range, with: string)
        //            textField.text = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: newString)
//                    nofinanceModel.CardNumber=textField.text ?? ""
        //            return false
//                }
//                if textField == cardcell.ExpiretionDateTxtFld{
//                    guard let text = textField.text else { return false }
//                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
//                    textField.text = self.format(with: "XX", phone: newString)
//                    nofinanceModel.Expiration=textField.text ?? ""
        
        //            let inputString = textField.text ?? ""
        //            let splits = inputString.components(separatedBy: "/")
        //            expiryYear=splits[1]
        //            expiryMonth=splits[0]
//                    return false
//                }
//                if textField == cardcell.yearTxtFld{
//                    guard let text = textField.text else { return false }
//                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
//                    textField.text = self.format(with: "XX", phone: newString)
//                    nofinanceModel.Year=textField.text ?? ""
        
        //            let inputString = textField.text ?? ""
        //            let splits = inputString.components(separatedBy: "/")
        //            expiryYear=splits[1]
        //            expiryMonth=splits[0]
//                    return false
//                }
//                if textField == cardcell.CvvTxtFld{
                    guard let text = textField.text else { return false }
//                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
//                    textField.text = self.format(with: "XXX", phone: newString)
//                    nofinanceModel.Cvv=textField.text ?? ""
//                    return false
//                }
        //
//                if textField==cardcell.AcntHolderTxtFld{
//                    let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//                    nofinanceModel.AcntHolderName=text
//                }
//                if textField==cardcell.amntTexyFld{
//                    let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        //                let value=(text as NSString).intValue
        //               print("value",value)
        
//                    nofinanceModel.amount=text
//                }
        //        if textField == cardcell.amntTexyFld {
        //            let allowedCharacters = CharacterSet(charactersIn:"+.0123456789")//Here change this characters based on your requirement
        //            let characterSet = CharacterSet(charactersIn: string)
        //            return allowedCharacters.isSuperset(of: characterSet)
        //        }
        //
        //
        ////            if textField==cardcell.creditCardTxtFld{
        ////                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        ////                nofinanceModel.CardNumber=text
        ////            }
        ////            if textField==cardcell.ExpiretionDateTxtFld{
        ////                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        ////                nofinanceModel.Expiration=text
        ////            }
        ////            if textField==cardcell.CvvTxtFld{
        ////                let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        ////                nofinanceModel.Cvv=text
        ////            }
        //
        //
        
        //* AcH textfield check when fields where static
        
        //        if textField == checkcell.AcntnumberTxtFld{
        //            guard let text = textField.text else { return false }
        //            let newString = (text as NSString).replacingCharacters(in: range, with: string)
        //            textField.text = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: newString)
        //            nofinanceModel.CardNumber=textField.text ?? ""
        //            return false
        //        }
        //        if textField==checkcell.cardnumberTxtFld{
        //            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        //            nofinanceModel.CheckNumber=text
        //        }
        //        if textField==checkcell.routeNumberTxtFld{
        //            guard let text = textField.text else
        //            {return false}
        //            let newString = (text as NSString).replacingCharacters(in: range, with: string)
        //            textField.text = self.format(with: "XXXXXXXXX", phone: newString)
        //            //            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        //            nofinanceModel.Routingnumber=textField.text ?? ""
        //            return false
        //        }
        //        if textField==checkcell.amntTxtFld{
        //            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        //            //                let value=(text as NSString).integerValue
        //            //                let roundedValue=(String(format: "%.2f", value))
        //            nofinanceModel.amount=text
        //
        //        }
        
//        guard let text = textField.text else { return false }
//        let newString = (text as NSString).replacingCharacters(in: range, with: string)
//        for i in 0...ACHFieldArray.count-1{
//            if textField.tag==ACHFieldArray[i].id{
//                ACHFieldArray[i].valueEntered=newString
//            }
//        }
        if cardSelected==1{
            if textField.tag==1{
                guard let text = textField.text else { return false }
                            let newString = (text as NSString).replacingCharacters(in: range, with: string)
                //            textField.text = self.format(with: "XXXX  XXXX  XXXX  XXXX", phone: newString)
                nofinanceModel.CardNumber=newString
                return true
            }
            //
            if textField.tag==2{
                guard let text = textField.text else
                {return false}
                            let newString = (text as NSString).replacingCharacters(in: range, with: string)
                //            textField.text = self.format(with: "XXXXXXXXX", phone: newString)
                //            //            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                nofinanceModel.Routingnumber=newString
                return true
            }
            if textField.tag==3{
                guard let text = textField.text else
                {return false}
                let newString = (text as NSString).replacingCharacters(in: range, with: string)
                //                let value=(text as NSString).integerValue
                //                let roundedValue=(String(format: "%.2f", value))
                nofinanceModel.amount=newString
                return true
            }
        }
//
        
        if textField == checkcell.amntTxtFld||textField == checkcell.cardnumberTxtFld||textField == checkcell.routeNumberTxtFld||textField == checkcell.AcntnumberTxtFld||textField == cardcell.amntTexyFld||textField == cardcell.CvvTxtFld||textField == cardcell.ExpiretionDateTxtFld||textField == cardcell.yearTxtFld{
            let allowedCharacters = CharacterSet(charactersIn:"+.0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        //
        //
        
        //        guard let text = textField.text else { return false }
        //        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        //        for i in 0...ACHFieldArray.count-1{
        //            if textField.tag==ACHFieldArray[i].id{
        //                ACHFieldArray[i].valueEntered=newString
        //            }
        //
        //        }
        
        
        
        
        
        
        //
        
        return result
    }
    
    
    //    func updateTokenButton(_ isEnable: Bool) {
    //        self.submi.isEnabled = isEnable
    //        if isEnable {
    //            self.getTokenButton.backgroundColor = UIColor.init(red: 48.0/255.0, green: 85.0/255.0, blue: 112.0/255.0, alpha: 1.0)
    //        } else {
    //            self.getTokenButton.backgroundColor = UIColor.init(red: 48.0/255.0, green: 85.0/255.0, blue: 112.0/255.0, alpha: 0.2)
    //        }
    //    }
    //
    
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if cardSelected==0{
            let validator = AcceptSDKCardFieldsValidator()
            
            switch (textField.tag)
            {
                
            case 1:
                
                self.cardNumber = self.cardNumberBuffer
                let luhnResult = validator.validateCardWithLuhnAlgorithm(self.cardNumberBuffer)
                
                if ((luhnResult == false) || (textField.text?.count < AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardNumberCharacterCountMin))
                {
                     cardcell.creditCardTxtFld.textColor = UIColor.red
                    isvalidCardnumber=false
                    nofinanceModel.CardType=""
                    DispatchQueue.main.async {
                        self.depositPaymentTableView.reloadData()
                    }
                    self.showAlertOk(message: "Please enter a valid card number")
                }
                else
                {
                    let cardtype = CreditCardDetector.detectCreditCardType(cardNumber: self.cardNumberBuffer)
                    nofinanceModel.CardType = cardtype.rawValue
                    cardcell.creditCardTxtFld.textColor = .blue
                    nofinanceModel.CardNumber=self.cardNumberBuffer
                    isvalidCardnumber=true
                    DispatchQueue.main.async {
                        self.depositPaymentTableView.reloadData()
                    }
                     
                }
                
                if (self.validInputs())
                {
                    print("valid")
                    
                    //                    cardcell.creditCardTxtFld.textColor = .blue
                }
                else
                {
                    // self.showAlertOk(message: "Please enter a valid card number")
                    
                    print("Invalidcard number")
                    //                    cardcell.creditCardTxtFld.textColor = UIColor.red
                }
                
                break
            case 2:
                self.validateMonth(textField)
                if let expYear = cardcell.yearTxtFld.text {
                    self.validateYear(expYear)
                }
                
                break
            case 3:
                
                self.validateYear(textField.text!)
                
                break
            case 4:
                
                self.cardVerificationCode = textField.text
                
                if (validator.validateSecurityCodeWithString(cardcell.CvvTxtFld.text!))
                {
                    cardcell.CvvTxtFld.textColor = .blue
                }
                else
                {
                    cardcell.CvvTxtFld.textColor = UIColor.red
                }
                
                if (self.validInputs())
                {
                    print("valid")
                }
                else
                {
                    // self.showAlertOk(message: "Please enter a valid Cvv")
                    print("Invalid")
                }
                
                break
                
            default:
                break
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if (textField == cardcell.creditCardTxtFld)
        {
            self.cardNumberBuffer = String()
        }
        
        return true
    }
    
    func validateYear(_ textFieldText: String) {
        
        self.cardExpirationYear = textFieldText
        let validator = AcceptSDKCardFieldsValidator()
        
        let newYear = Int(textFieldText)
        if ((newYear >= validator.cardExpirationYearMin())  && (newYear <= AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardExpirationYearMax))
        {
            cardcell.ExpiretionDateTxtFld.textColor = .blue //[UIColor greenColor]
        }
        else
        {
            cardcell.ExpiretionDateTxtFld.textColor = UIColor.red
        }
        
        if (cardcell.ExpiretionDateTxtFld.text?.count == 0)
        {
            return
        }
        if (cardcell.yearTxtFld.text?.count == 0)
        {
            return
        }
        if (validator.validateExpirationDate(cardcell.ExpiretionDateTxtFld.text!, inYear: cardcell.yearTxtFld.text!))
        {
            cardcell.ExpiretionDateTxtFld.textColor = .blue
            cardcell.yearTxtFld.textColor = .blue
        }
        else
        {
            cardcell.ExpiretionDateTxtFld.textColor = UIColor.red
            cardcell.yearTxtFld.textColor = UIColor.red
        }
        
        if (self.validInputs())
        {
            //self.updateTokenButton(true)
            isvalidMonthYear=true
        }
        else
        {
            // self.showAlertOk(message: "Please enter a valid expiry year")
            // self.updateTokenButton(false)
            isvalidMonthYear=false
        }
    }
    
    func validateMonth(_ textField: UITextField) {
        
        self.cardExpirationMonth = textField.text
        
        if (cardcell.ExpiretionDateTxtFld.text?.count == 1)
        {
            if ((textField.text == "0") == false) {
                cardcell.ExpiretionDateTxtFld.text = "0" + cardcell.ExpiretionDateTxtFld.text!
            }
        }
        
        let newMonth = Int(textField.text!)
        
        if ((newMonth >= AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardExpirationMonthMin)  && (newMonth <= AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardExpirationMonthMax))
        {
            cardcell.ExpiretionDateTxtFld.textColor = .blue //[UIColor greenColor]
            
        }
        else
        {
            cardcell.ExpiretionDateTxtFld.textColor = UIColor.red
        }
        
        if (self.validInputs())
        {
            //self.updateTokenButton(true)
            isvalidMonthYear=true
            
        }
        else
        {
            // self.showAlertOk(message: "Please enter a valid expiry month")
            //self.updateTokenButton(false)
            isvalidMonthYear=false
        }
    }
    
    
    func getToken() {
        
        
        let handler = AcceptSDKHandler(environment: AcceptSDKEnvironment.ENV_TEST)
        
        let request = AcceptSDKRequest()
        request.merchantAuthentication.name = kClientName
        request.merchantAuthentication.clientKey = kClientKey
       
        request.securePaymentContainerRequest.webCheckOutDataType.token.cardNumber = self.cardNumberBuffer
        request.securePaymentContainerRequest.webCheckOutDataType.token.expirationMonth = self.cardExpirationMonth
        request.securePaymentContainerRequest.webCheckOutDataType.token.expirationYear = self.cardExpirationYear
        request.securePaymentContainerRequest.webCheckOutDataType.token.cardCode = self.cardVerificationCode
        
        handler!.getTokenWithRequest(request, successHandler: { (inResponse:AcceptSDKTokenResponse) -> () in
            DispatchQueue.main.async(execute: {
                
                
                // self.activityIndicatorAcceptSDKDemo.stopAnimating()
            
                print("Token--->%@", inResponse.getOpaqueData().getDataValue())
                var output = String(format: "Response: %@\nData Value: %@ \nDescription: %@", inResponse.getMessages().getResultCode(), inResponse.getOpaqueData().getDataValue(), inResponse.getOpaqueData().getDataDescriptor())
                output = output + String(format: "\nMessage Code: %@\nMessage Text: %@", inResponse.getMessages().getMessages()[0].getCode(), inResponse.getMessages().getMessages()[0].getText())
                //                self.textViewShowResults.text = output
                //                self.textViewShowResults.textColor = UIColor.green
                self.authorize_token=inResponse.getOpaqueData().getDataValue()
                // self.popupActionSuccess()
                // self.submitbtnAction()
//                if self.isFromBalancePaymentVC==true{
                if self.cardSelected==0{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.hideLoader()
                    }
                }
                    self.showemailvalidationView()
                    //self.balancetransactionApi()
//                }else{
//                    self.transactionApi()
//                }
//                self.cardUpdation()
                // self.processPayment()
            })
        }) { (inError:AcceptSDKErrorResponse) -> () in
            //self.activityIndicatorAcceptSDKDemo.stopAnimating()
            // self.updateTokenButton(true)
            
            let output = String(format: "Response:  %@\nError code: %@\nError text:   %@", inError.getMessages().getResultCode(), inError.getMessages().getMessages()[0].getCode(), inError.getMessages().getMessages()[0].getText())
            if self.cardSelected==0{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.hideLoader()
                }
            }
            //            self.textViewShowResults.text = output
            //            self.textViewShowResults.textColor = UIColor.red
            self.showAlertOk(message: inError.getMessages().getMessages()[0].getText())
            //            self.popupActionFailed()
            print(output)
        }
    }
    func popupActionSuccess(){
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        
        
        blurView.isHidden=false
        popupView.isHidden=false
        paymentDeclinedview.isHidden=true
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        
        self.view.addSubview(popupView)
        
    }
    func popupActionFailed(){
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        
        paymentdeclinedLabel.text=self.errorText
        blurView.isHidden=false
        paymentDeclinedview.isHidden=false
        popupView.isHidden=true
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        
        self.view.addSubview(paymentDeclinedview)
        
    }
    
    @IBAction func skipbtnAction(_ sender: Any) {
        blurView.isHidden=true
        paymentDeclinedview.isHidden=true
        
    }
    
    @IBAction func tryAgainAction(_ sender: Any) {
        blurView.isHidden=true
        paymentDeclinedview.isHidden=true
        //getToken()
        if cardSelected==0{
            if isFromBalancePaymentVC==true{
                self.balancetransactionApi()
            }else{
                self.transactionApi()
            }
        }else{
            if isFromBalancePaymentVC==true{
                BalanceACHtransactionApi()
            }else{
                ACHtransactionApi()
            }
            }
    }
    
    @IBAction func continueaction(_ sender: Any) {
        cardUpdation()
        // self.submitbtnAction()
    }
    
    
    func processPayment() {
        
        
        let parameters =
        [
            "createTransactionRequest": [
                "merchantAuthentication": [
                    "name": "5KP3u95bQpv",
                    "transactionKey": "346HZ32z3fP4hTG2"
                ],
                "refId": "123456",
                "transactionRequest": [
                    "transactionType": "authCaptureTransaction",
                    "amount": "5",
                    "payment": [
                        "creditCard": [
                            "cardNumber": "5424000000000015",
                            "expirationDate": "2025-12",
                            "cardCode": "999"
                        ]
                    ],
                    "lineItems": [
                        "lineItem": [
                            "itemId": "1",
                            "name": "vase",
                            "description": "Cannes logo",
                            "quantity": "18",
                            "unitPrice": "45.00"
                        ]
                    ],
                    "tax": [
                        "amount": "4.26",
                        "name": "level2 tax name",
                        "description": "level2 tax"
                    ],
                    "duty": [
                        "amount": "8.55",
                        "name": "duty name",
                        "description": "duty description"
                    ],
                    "shipping": [
                        "amount": "4.26",
                        "name": "level2 tax name",
                        "description": "level2 tax"
                    ],
                    "poNumber": "456654",
                    "customer": [
                        "id": "99999456654"
                    ],
                    "billTo": [
                        "firstName": "Ellen",
                        "lastName": "Johnson",
                        "company": "Souveniropolis",
                        "address": "14 Main Street",
                        "city": "Pecan Springs",
                        "state": "TX",
                        "zip": "44628",
                        "country": "US"
                    ],
                    "shipTo": [
                        "firstName": "China",
                        "lastName": "Bayles",
                        "company": "Thyme for Tea",
                        "address": "12 Main Street",
                        "city": "Pecan Springs",
                        "state": "TX",
                        "zip": "44628",
                        "country": "US"
                    ],
                    "customerIP": "192.168.1.1",
                    "transactionSettings": [
                        "setting": [
                            "settingName": "testRequest",
                            "settingValue": "false"
                        ]
                    ],
                    "userFields": [
                        "userField": [
                            [
                                "name": "MerchantDefinedFieldName1",
                                "value": "MerchantDefinedFieldValue1"
                            ],
                            [
                                "name": "favorite_color",
                                "value": "blue"
                            ]
                        ]
                    ],
                    "processingOptions": [
                        "isSubsequentAuth": "true"
                    ],
                    "subsequentAuthInformation": [
                        "originalNetworkTransId": "123456789NNNH",
                        "originalAuthAmount": "45.00",
                        "reason": "resubmission"
                    ],
                    "authorizationIndicatorType": [
                        "authorizationIndicator": "final"
                    ]
                ]
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        let url = URL(string: "https://apitest.authorize.net/xml/v1/request.api")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
        }
        
        task.resume()
    }
}


////    func charge(){
////        let paymentToken = "YOUR_GENERATED_PAYMENT_TOKEN"
//    let authorizeNetAccept=AuthorizeNetAccept.shared.charge
//        authorizeNetAccept.chargeWithToken(paymentToken, amount: 100.00) { (response, error) in
//            if let error = error {
//                // Handle the error
//            } else if let response = response {
//                // Process the payment response
//            }
//        }
//    }
//}
//class AuthorizeNetAccept {
//    static let shared = AuthorizeNetAccept()
//    private init() { /* Private initializer */ }
//
//    // Other class implementation...
//}
