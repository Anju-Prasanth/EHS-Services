//
//  AppointmentResultViewController.swift
//  Express Home
//
//  Created by Bincy C A on 06/06/23.
//

import UIKit
import DropDown

class AppointmentResultViewController: UIViewController,UITextViewDelegate {
    
    static func initialization() -> AppointmentResultViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentResultViewController") as? AppointmentResultViewController
    }
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
        dimmedView.backgroundColor = UIColor().colorFromHexString("#232538").withAlphaComponent(0.45) //.black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds

            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()

    @IBOutlet weak var dropdownDetailsview: UIView!
    @IBOutlet weak var dropdownResultview: UIView!
    @IBOutlet weak var notesTxtView: UITextView!
    @IBOutlet weak var secondaryTxtFld: UITextField!
    @IBOutlet weak var selectResultTxtFld: UITextField!
    @IBOutlet weak var dispositionResultsBtn: UIButton!
    
    @IBOutlet weak var notesLbl: UILabel!
    @IBOutlet weak var dispositiondetailsLbl: UILabel!
    @IBOutlet weak var dispositionDetailsBtn: UIButton!
    var dispositionViewModel=DispositionViewModel()
    var dispositionTypes=[DispositionModelClass]()
    var dropDown = DropDown()
    var dispositionArray = [String]()
    var dispositionResultId=Int()
    var dispositionDeatilId=Int()
    var dispositionNotes=Int()
    //["Sold","Demoed, Not Sold","Follow-Up","Not Demoed","No Show","Not Run","Cancelled"]
    var dispositionDetails = [String]()
    //["P&M","Price","Shopping"]
    var navView = UIView()
    var navViewBottomLine = UIView()
    var projectSelectIndex=Int()
    var isFromContract=false
    var projectID=Int()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setupView()
//        let parameters1:[String:Any] = [:]
//        dispositionViewModel.documentupload(parameters: parameters1) { success, dispositionTypes, message in
//            if success{
//
//                print("dispositionTypes",dispositionTypes)
//            }else{
//                self.showAlertOk(message: message)
//            }
//        }
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
        selectResultTxtFld.setLeftPaddingPoints(20)
        selectResultTxtFld.setRightPaddingPoints(20)
        secondaryTxtFld.setLeftPaddingPoints(20)
        secondaryTxtFld.setRightPaddingPoints(20)
        notesTxtView.leftSpace()
        dropDown.width = dispositionResultsBtn.frame.size.width+250
        notesTxtView.text = "Enter here"
        notesTxtView.textColor = UIColor().colorFromHexString("#797B83")
        notesTxtView.delegate = self
        
        NotificationCenter.default.addObserver(self,
                            selector: #selector(appCameToForeGround(notification:)),
                            name: UIApplication.didBecomeActiveNotification,
                            object: nil)
        
        UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
        if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
        {
            tokenexpirationCheck()
            
        }
//        if isFromContract{
//            selectResultTxtFld.text = "Sold"
            selectResultTxtFld.isUserInteractionEnabled=true
            dispositionResultsBtn.isUserInteractionEnabled=true
            
//        }else{
//            selectResultTxtFld.text="Select"
//            selectResultTxtFld.isUserInteractionEnabled=true
//            dispositionResultsBtn.isUserInteractionEnabled=true
//        }
        
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
            dispositiondetailsApicall()
        }else{
           intializeMSAL(isfromLoggedOut: false)
            
        }
    }
    @objc override func refreshTokenCheck(notification: Notification) {
       
        if let dict = notification.userInfo as NSDictionary? {
            if let token = dict["token"] as? Int{
                UserDefaults.standard.set(token, forKey: "token")
                dispositiondetailsApicall()
            }
        }
      
    }
    
    @objc override func appCameToForeGround(notification: Notification) {
        if dispositionTypes.count==0{
            
            if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
            {
                tokenexpirationCheck()
            }
        }
    
    }
    
    
    
    func dispositiondetailsApicall(){
        let parameters:[String:String] = [:]
        dispositionViewModel.disposition_types(parameters: parameters) { success, dispositionTypes, message in
            if success{
                self.dispositionValues(data: dispositionTypes ?? [])
                
            }else{
                
                if message==AppAlertMsg.netWorkAlertMessage{
                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                       
                        self.dispositiondetailsApicall()
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
    
    override func viewWillAppear(_ animated: Bool){
//        refreshMSALToken()
       // setnavBarView()
    }
    
    private func dispositionValues(data: [DispositionModelClass]) {
        print("data",data)
        dispositionDetails.removeAll()
        if data.count ?? 0>0{
//            if self.isFromContract{
//                dispositionTypes=data.filter({ $0.isSoldType == true })
//                //let dispositionresultId=dispositionForSold[0].resultDetails?.filter({ $0.detailName == "Sold" })
//
//               // self.dispositionDetails.removeAll()
//                dispositionArray.removeAll()
////                if dispositionForSold[0].resultDetails?.count ?? 0>0{
////                    self.dispositionResultId=dispositionForSold[0].id ?? 0
////                    for i in 0...(dispositionForSold[0].resultDetails?.count ?? 0)-1{
////                        self.dispositionDetails.append(dispositionForSold[0].resultDetails?[i].detailName ?? "")
////
////                    }
////                }
//                for i in 0...dispositionTypes.count-1{
//                    dispositionArray.append(dispositionTypes[i].resultName ?? "")
//                }
//                if dispositionTypes[0].resultDetails?.count ?? 0>0{
//                    dispositionResultId=dispositionTypes[0].id ?? 0
//                    for i in 0...(dispositionTypes[0].resultDetails?.count ?? 0)-1{
//                        dispositionDetails.append(dispositionTypes[0].resultDetails?[i].detailName ?? "")
//
//                    }
//                }
//                selectResultTxtFld.text = dispositionArray[0]
//            }else{
                
               // dispositionTypes=data.filter({ $0.isSoldType == false })
            dispositionTypes=data
                dispositionArray.removeAll()
                
                for i in 0...dispositionTypes.count-1{
                    dispositionArray.append(dispositionTypes[i].resultName ?? "")
                }
//            }
        }else{
            self.showAlertOk(message: "Disposition details not found")
        }
    }
    
    func setupView()
    {
            // 6. add blur view and send it to back
            view.addSubview(blurredView)
            view.sendSubviewToBack(blurredView)
        }
    func  setnavBarView(){
        navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  120))
        navView.layer.masksToBounds = false
        navView.backgroundColor = .clear
        navView.isHidden=false
        self.blurredView.addSubview(navView)
        
        
        navViewBottomLine = UIView(frame: CGRect(x: 0, y: 120, width: self.view.frame.width, height:  1))
        navViewBottomLine.layer.masksToBounds = false
        navViewBottomLine.backgroundColor = UIColor().colorFromHexString("#CBCCD5").withAlphaComponent(1.0)
//        self.view.addSubview(navViewBottomLine)
       
        setNavigationBarbacklogoNameForFinance(name: "Balance Payment Option",superview: navView)
    }
   
    @IBAction func dispositionDetailsBtnAction(_ sender: UIButton)
    {
        if dispositionDetails.count>0{
            dropDown.dataSource = dispositionDetails
            dropDown.anchorView=dropdownDetailsview
            dropDown.show()
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                for i in 0...dispositionTypes.count-1{
                    if dispositionTypes[i].id==dispositionResultId{
                        dispositionDeatilId=dispositionTypes[i].resultDetails?[index].id ?? 0
                    }
                }
                secondaryTxtFld.text = item
                
            }
        }else{
            self.showAlertOk(message: "Dispostion details not found")
        }
    }
    @IBAction func dispositionResultBtnAction(_ sender: UIButton)
    {
        dropDown.dataSource = dispositionArray
        dropDown.anchorView=dropdownResultview
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            dispositionDetails.removeAll()
            if dispositionTypes[index].resultDetails?.count ?? 0>0{
                dispositionResultId=dispositionTypes[index].id ?? 0
                for i in 0...(dispositionTypes[index].resultDetails?.count ?? 0)-1{
                    dispositionDetails.append(dispositionTypes[index].resultDetails?[i].detailName ?? "")
                   
                }
            }
            selectResultTxtFld.text = item
            secondaryTxtFld.text = "Select"
        }
    }
    @IBAction func cancelBtnAction(_ sender: UIButton)
    {
        self.dismiss(animated: true)
    }
    @IBAction func submitBtnAction(_ sender: UIButton)
    {
        if self.selectResultTxtFld.text == "Select"
        {
            self.alertWithTitle("Warning","You must enter a disposition value and detail before proceeding", nil)
        }
        else if self.secondaryTxtFld.text == "Select"
        {
            self.alertWithTitle("Warning","You must enter a disposition value and detail before proceeding", nil)
        }
//        else if self.notesTxtView.text == "Enter here" || self.notesTxtView.text == ""
//        {
//            self.alert("Notes cannot be empty", nil)
//        }
        else
        {
            let appointment_Id=UserDefaults.standard.value(forKey: "appointmentID") as? Int
            if self.notesTxtView.text=="Enter here"{
                self.notesTxtView.text=""
            }
            if projects.count>0{
                if let project_id=projects[projectSelectIndex].pricingDetails?.projectID{
                    projectID=project_id
                }else{
                    projectID=0
                }
            }else{
                projectID=0
            }
            let parameters:[String:Any] = ["dispositionResultId":dispositionResultId,"dispositionResultDetailId":dispositionDeatilId,"dispositionNotes":self.notesTxtView.text ?? "","appointmentId":appointment_Id ?? 0,"projectId":projectID]
            print("parameters",parameters)
            dispositionViewModel.save_disposition(parameters: parameters) { success, dispositionsave, message in
                if success{
                    self.dispositionSave(data: dispositionsave ?? [])
                    let alert = UIAlertController(title: "Express Home", message: message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                        self.dismiss(animated: true)
                       
                        if let presentingNavController = self.presentingViewController as? UINavigationController {
                                    // Instantiate the destination view controller
                                    let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerListViewController") as! CustomerListViewController

                                    // Push the destination view controller onto the navigation stack
                                    presentingNavController.pushViewController(destinationVC, animated: true)
                                } else {
                                    // If not already embedded in a navigation controller, embed it and then push
                                    let presentingNavController = UINavigationController(rootViewController: self)
                                    presentingNavController.modalPresentationStyle = .fullScreen

                                    // Instantiate the destination view controller
                                    let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerListViewController") as! CustomerListViewController

                                    // Push the destination view controller onto the navigation stack
                                    presentingNavController.pushViewController(destinationVC, animated: true)

                                    // Dismiss the current presented view controller
                                    self.dismiss(animated: true, completion: nil)

                                    // Present the navigation controller modally
                                    self.presentingViewController?.present(presentingNavController, animated: true, completion: nil)
                                }
                            
                        }))
                       
                        self.present(alert, animated: true, completion: nil)
//                    if dispositionTypes?.count==0{
//
//                    }
                }else{
                    self.showAlertOk(message: message)
                }
            }
        }
    }
        
    private func dispositionSave(data: [DispositionSave]) {
        print("data",data)
        
    }
//    func textViewDidBeginEditing(_ textView: UITextView)
//    {
//        if textView.text == "Enter here"
//        {
//            textView.text = ""
//        }
//
//    }
//
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor().colorFromHexString("#797B83"){
            textView.text = nil
            textView.textColor =  UIColor().colorFromHexString("#34353C")
        }
    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text == ""
//        {
//            textView.text = "Enter here"
//        }
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter here"
            textView.textColor = UIColor().colorFromHexString("#797B83")
        }
    }

}
