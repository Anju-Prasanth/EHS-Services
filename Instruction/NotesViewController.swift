//
//  NotesViewController.swift
//  EHS_Sales
//
//  Created by Bincy C A on 12/04/23.
//

import UIKit
protocol ReadMoreDismissprotocol
{
    func backToPresentingClassSalesSchedules()
    func backToPresentingClassAddtax(taxRate:Double)
}



class NotesViewController: UIViewController,CustomAlertDismissProtocol,UITextViewDelegate {
    func backToPresentingClassFromoverstockPopupForMax() {
        
    }
    
    func backToPresentingClassFromOffersPopup(DollarAmount: String) {
        
    }
    
    func backToPresentingClassFromoverstockPopup(status: Int, customprice: String) {
        
    }
    
    func backToPresentingClass(status:Int,isInternalNote:Bool)
    {

        if status == 0
        {
            let createdDate = Date().toString()
            if UserDefaults.standard.value(forKey: "contractNoteDict") == nil
            {
                let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
                let parameters : [String:Any] = ["appointmentId": appointmentId, "noteTypeId": 1 , "note": self.contractNote , "createdDateUtc" : createdDate]
                notesViewModel.noteCreateapi(parameters: parameters) { success, notesList, message in
                    if success
                    {
                        if self.isInternalNoteChange
                        {
                            self.internalApiCall()
                        }
                        else
                        {
                            var notesDictArray: [[String:Any]] = []
                            notesDictArray = [
                                ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                            ]
                            UserDefaults.standard.set(notesDictArray, forKey: "contractNoteDict")
                            //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                            self.dismiss(animated: true)
                        }
                    }
                    else
                    {
            
                        
                        
                        
                        self.showAlertOk(message: message)
                    }
                }
            }
                else
                {
                    var appointmentNoteId:Int = Int()
                    var appointmentId:Int = Int()
                    var noteTypeId:Int = Int()
                    
                    for item in loadedContractNote
                    {
                        appointmentId = item["appointmentId"] as! Int
                        appointmentNoteId = item["appointmentNoteId"] as! Int
                        noteTypeId = item["noteTypeId"] as! Int
                    }
                    let parameters : [String:Any] = ["appointmentNoteId":appointmentNoteId,"appointmentId": appointmentId, "noteTypeId": noteTypeId , "note": self.contractNote , "createdDateUtc" : createdDate]
                    notesViewModel.noteUpdateapi(parameters: parameters) { success, notesList, message in
                        if success
                        {
                            if self.isInternalNoteChange
                            {
                                self.internalApiCall()
                            }
                            else
                            {
                                var notesDictArray: [[String:Any]] = []
                                notesDictArray = [
                                    ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                                ]
                                UserDefaults.standard.set(notesDictArray, forKey: "contractNoteDict")
                                //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                                self.dismiss(animated: true)
                            }
                        }
                        else
                            
                        {
                            self.showAlertOk(message: message)
                        }
                }
            }
            
            //self.dismiss(animated: true)
        }
        else
        {
            let createdDate = Date().toString()
            if isInternalNote
            {
                self.internalNote = ""
                var appointmentNoteId:Int = Int()
                var appointmentId:Int = Int()
                var noteTypeId:Int = Int()
                
                for item in loadedInternalNote
                {
                    appointmentId = item["appointmentId"] as! Int
                    appointmentNoteId = item["appointmentNoteId"] as! Int
                    noteTypeId = item["noteTypeId"] as! Int
                }
                let parameters : [String:Any] = ["appointmentNoteId":appointmentNoteId,"appointmentId": appointmentId, "noteTypeId": noteTypeId , "note": internalNote , "createdDateUtc" : createdDate]
                notesViewModel.noteUpdateapi(parameters: parameters) { success, notesList, message in
                    if success
                    {
                        var notesDictArray: [[String:Any]] = []
                        notesDictArray = [
                            ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                        ]
                        UserDefaults.standard.set(notesDictArray, forKey: "internalNoteDict")
                        //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                       
                    }
                    else
                        
                    {
                        self.showAlertOk(message: message)
                    }
                }
                
            }
            
            else
            {
                self.contractNote = ""
                
                var appointmentNoteId:Int = Int()
                var appointmentId:Int = Int()
                var noteTypeId:Int = Int()
                
                for item in loadedContractNote
                {
                    appointmentId = item["appointmentId"] as! Int
                    appointmentNoteId = item["appointmentNoteId"] as! Int
                    noteTypeId = item["noteTypeId"] as! Int
                }
                var parameters = [String:Any]()
               
                    parameters  = ["appointmentNoteId":appointmentNoteId,"appointmentId": appointmentId, "noteTypeId": noteTypeId , "note": self.contractNote , "createdDateUtc" : createdDate]
               
                notesViewModel.noteUpdateapi(parameters: parameters) { success, notesList, message in
                    if success
                    {
                        if self.isInternalNoteChange
                        {
                          //  self.internalApiCall()
                        }
                        else
                        {
                            var notesDictArray: [[String:Any]] = []
                            notesDictArray = [
                                ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                            ]
                            UserDefaults.standard.set(notesDictArray, forKey: "contractNoteDict")
                            //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                           
                        }
                    }
                    else
                        
                    {
                        self.showAlertOk(message: message)
                    }
            }
        }
                
            }
            notesTextview.textColor = UIColor.lightGray
            notesTextview.text = "Type Here..."
            
            
           
    }
    
    static func initialization() -> NotesViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController
    }
    
    // creating blurred background
    
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
    
    @IBOutlet weak var readmoretextHeightConstarint: NSLayoutConstraint!
    @IBOutlet weak var readmoreTxTview: UITextView!
    @IBOutlet weak var bgViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contractNoteBtn: UIButton!
    @IBOutlet weak var internalNoteHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contractNoteHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var internalNoteView: UIView!
    @IBOutlet weak var contractNoteView: UIView!
    @IBOutlet weak var notesTextview: UITextView!
    @IBOutlet weak var inetrnalNoteBtn: UIButton!
    
    var isInternalNoteBtn:Bool = Bool()
    var contractNote = ""
    var internalNote = ""
    let notesViewModel = NoteViewModel()
    var loadedInternalNote:[[String:Any]] = []
    var loadedContractNote:[[String:Any]] = []
    var isInternalNoteChange:Bool = Bool()
    var isContractNoteChange:Bool = Bool()
    
    @IBOutlet weak var readmoreLbl: UILabel!
    @IBOutlet weak var readmoreView: UIView!
    
    @IBOutlet weak var offersWarningView: UIView!
    
    @IBOutlet weak var readmoreViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contractNotesView: UIView!
    
    @IBOutlet weak var addTaxView: UIView!
    var isfromSalesschedules=false
    var isFromOffers=false
    var isFromPriceDetails=false
    var delegate:ReadMoreDismissprotocol?
    var readmoreText=String()
    var screenHeight=UIScreen.main.bounds.height
    var taxrate=Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        NotificationCenter.default.addObserver(self,
                            selector: #selector(appCameToForeGround(notification:)),
                            name: UIApplication.didBecomeActiveNotification,
                            object: nil)
        
        UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
        if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
        {
            tokenexpirationCheck()
            
        }
    
       
        
        if isfromSalesschedules==true{
            contractNotesView.isHidden=true
            readmoreView.isHidden=false
            offersWarningView.isHidden=true
            addTaxView.isHidden=true
            
            readmoreTxTview.text=readmoreText
           // let contentSize = self.readmoreTxTview.sizeThatFits(self.readmoreTxTview.bounds.size)
            let contentSize = self.readmoreTxTview.sizeThatFits(CGSize(width: readmoreTxTview.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            readmoretextHeightConstarint.constant=contentSize.height+100
            readmoreViewHeight.constant=contentSize.height+200
            if contentSize.height>=screenHeight-200{
                readmoreViewHeight.constant=UIScreen.main.bounds.height-100
                readmoretextHeightConstarint.constant=readmoreViewHeight.constant-150
                readmoreTxTview.adjustUITextViewHeight(scrollEnabled:true)
            }else{
                readmoreViewHeight.constant=contentSize.height+200
                readmoretextHeightConstarint.constant=readmoreViewHeight.constant
                readmoreTxTview.adjustUITextViewHeight(scrollEnabled:false)
            }
            //            if contentSize.height<360{
            //                readmoreViewHeight.constant=contentSize.height+120
            //                readmoreTxTview.adjustUITextViewHeight(scrollEnabled:false)
            //            }
            //            if contentSize.height>360{
            //                readmoreViewHeight.constant=contentSize.height
            //                readmoreTxTview.adjustUITextViewHeight(scrollEnabled:false)
            //            }
            print("contentSize",contentSize.height)
            print("contentSize",contentSize.width)
        }else if isFromOffers==true{
            contractNotesView.isHidden=true
            readmoreView.isHidden=true
            offersWarningView.isHidden=false
            addTaxView.isHidden=true
        }else if isFromPriceDetails==true{
            contractNotesView.isHidden=true
            readmoreView.isHidden=true
            offersWarningView.isHidden=true
            addTaxView.isHidden=false
        }else{
            contractNotesView.isHidden=false
            readmoreView.isHidden=true
            offersWarningView.isHidden=true
            addTaxView.isHidden=true
            contractNoteBtn.setTitleColor(UIColor().colorFromHexString("#CE5656"), for: .normal)
            contractNoteView.backgroundColor = UIColor().colorFromHexString("#CE5656")
            contractNoteHeightConstraint.constant = 2
            notesTextview.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 5)
            contractNote = "Type Here..."
            internalNote = "Type Here..."
            notesTextview.textColor = UIColor.lightGray
            notesTextview.text = contractNote
            notesTextview.delegate = self
            
            let group = DispatchGroup()
            group.enter()
            
            let parameters:[String:Any] = [:]
            notesViewModel.getAppointmentNotesapi(parameters: parameters) { success, notesList, message in
                if success
                {
                    self.setupView()
                    let contractnote = notesList?.filter({$0.noteTypeId == 1}).last
                    let internalNote = notesList?.filter({$0.noteTypeId == 2}).last
                    if contractnote != nil
                    {
                        var notesDictArray: [[String:Any]] = []
                        notesDictArray = [
                            ["appointmentNoteId": (contractnote?.appointmentNoteId)! as Int,"appointmentId":(contractnote?.appointmentId!)! as Int,"note": (contractnote?.note!)! as String,"noteTypeId": (contractnote?.noteTypeId!)! as Int ]
                        ]
                        UserDefaults.standard.set(notesDictArray, forKey: "contractNoteDict")
                    }
                    else
                    {
                       
                        UserDefaults.standard.removeObject(forKey: "contractNoteDict")
                    }
                    if internalNote != nil
                    {
                        var notesDictArray: [[String:Any]] = []
                        notesDictArray = [
                            ["appointmentNoteId": (internalNote?.appointmentNoteId)! as Int,"appointmentId":(internalNote?.appointmentId!)! as Int,"note": (internalNote?.note!)! as String,"noteTypeId": (internalNote?.noteTypeId!)! as Int ]
                        ]
                        UserDefaults.standard.set(notesDictArray, forKey: "internalNoteDict")
                    }
                    else
                    {
                        UserDefaults.standard.removeObject(forKey: "internalNoteDict")
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main)
            {
                
                if UserDefaults.standard.value(forKey: "internalNoteDict") != nil
                {
                    self.notesTextview.textColor = UIColor().colorFromHexString("#34353C")
                    self.loadedInternalNote = UserDefaults.standard.value(forKey: "internalNoteDict") as! [[String : Any]]
                    for item in self.loadedInternalNote
                    {
                        self.internalNote = item["note"] as! String
                    }
                }
                if self.internalNote==""{
                    self.notesTextview.text = "Type Here..."
                    self.internalNote="Type Here..."
                    self.notesTextview.textColor = UIColor.lightGray
                }else{
                    self.notesTextview.text = self.internalNote
                }
                   
                
                if UserDefaults.standard.value(forKey: "contractNoteDict") != nil
                {
                    self.notesTextview.textColor = UIColor().colorFromHexString("#34353C")
                    self.loadedContractNote = UserDefaults.standard.value(forKey: "contractNoteDict") as! [[String : Any]]
                    for item in self.loadedContractNote
                    {
                        self.contractNote = item["note"] as! String
                    }
                    if self.contractNote==""{
                        self.notesTextview.text = "Type Here..."
                        self.contractNote="Type Here..."
                        self.notesTextview.textColor = UIColor.lightGray
                    }else{
                        self.notesTextview.text = self.contractNote
                    }
                }
                else
                {
                    self.notesTextview.text = self.contractNote
                    self.notesTextview.textColor = UIColor.lightGray
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool){
//        refreshMSALToken()
    }
//    override func viewWillAppear(_ animated: Bool)
//    {
//        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10
//    }
    func setupView()
    {
            // 6. add blur view and send it to back
            view.addSubview(blurredView)
            view.sendSubviewToBack(blurredView)
        }
    
    override func viewDidLayoutSubviews()
    {
        if isfromSalesschedules==false&&isFromOffers==false&&isFromPriceDetails==false{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 0, options: .curveLinear, animations:{
                    self.bgViewTopConstraint.constant = 60
                    self.bgViewBottomConstraint.constant = 60
                    self.view.layoutIfNeeded()
                })
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
           
        }else{
           intializeMSAL(isfromLoggedOut: false)
            
        }
    }
    @objc override func refreshTokenCheck(notification: Notification) {
       
        if let dict = notification.userInfo as NSDictionary? {
            if let token = dict["token"] as? Int{
                UserDefaults.standard.set(token, forKey: "token")
               
            }
        }
      
    }
    
    @objc override func appCameToForeGround(notification: Notification) {
       
            
            if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
            {
                tokenexpirationCheck()
            }
        
    
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView.text == "Type Here..."
        {
            textView.text = ""
            textView.textColor = UIColor().colorFromHexString("#34353C")
        }
    }
    
//    func textViewDidChange(_ textView: UITextView)
//    {
//        if textView.text == "Type Here..."
//        {
//            textView.text = ""
//        }
//
//    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if isInternalNoteBtn == true
        {
           if textView.text != "" && textView.text != "Type Here..."
            {
                self.internalNote = textView.text
               for internalItem in self.loadedInternalNote
               {
                   if internalItem["note"] as? String == textView.text
                   {
                       self.isInternalNoteChange = false
                   }
                   else
                   {
                       self.isInternalNoteChange = true
                   }
               }
               self.isInternalNoteChange = true
            }
            else
            {
                textView.text = "Type Here..."
                self.internalNote = textView.text
                textView.textColor = UIColor.lightGray
            }
        }
        else
        {
            if textView.text != "" && textView.text != "Type Here..."
             {
                 self.contractNote = textView.text
                for contractItem in self.loadedContractNote
                {
                    if contractItem["note"] as? String == textView.text
                    {
                        self.isContractNoteChange = false
                    }
                    else
                    {
                        self.isContractNoteChange = true
                    }
                }
                self.isContractNoteChange = true
             }
            else
            {
                textView.text = "Type Here..."
                self.contractNote = textView.text
                textView.textColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func contractNoteBtnAction(_ sender: UIButton)
    {
        // setting up view
        notesTextview.resignFirstResponder()
        notesTextview.text = contractNote
        if notesTextview.text == "Type Here..."
        {
            notesTextview.textColor = UIColor.lightGray
        }
        else
        {
            notesTextview.textColor = UIColor().colorFromHexString("#34353C")
        }
        isInternalNoteBtn = false
        contractNoteBtn.setTitleColor(UIColor().colorFromHexString("#CE5656"), for: .normal)
        contractNoteView.backgroundColor = UIColor().colorFromHexString("#CE5656")
        contractNoteHeightConstraint.constant = 2
        
        inetrnalNoteBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
        internalNoteView.backgroundColor = UIColor().colorFromHexString("CBCCD5")
        internalNoteHeightConstraint.constant = 1
    }
    
    @IBAction func internalNoteBtnAction(_ sender: UIButton)
    {
        // setting up view
        notesTextview.resignFirstResponder()
        notesTextview.text = internalNote
        if notesTextview.text == "Type Here..."
        {
            notesTextview.textColor = UIColor.lightGray
        }
        else
        {
            notesTextview.textColor = UIColor().colorFromHexString("#34353C")
        }
        isInternalNoteBtn = true
        inetrnalNoteBtn.setTitleColor(UIColor().colorFromHexString("#304CCE"), for: .normal)
        internalNoteView.backgroundColor = UIColor().colorFromHexString("#304CCE")
        internalNoteHeightConstraint.constant = 2
        
        contractNoteBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
        contractNoteView.backgroundColor = UIColor().colorFromHexString("CBCCD5")
        contractNoteHeightConstraint.constant = 1
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton)
    {
        if isContractNoteChange == true
        {
            let yes = UIAlertAction(title: "Proceed", style:.default) { (_) in
                
                self.dismiss(animated: true)
            }
            let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            self.alert("Edits made in the section will be lost if you close the window without submitting. Are you sure you want to proceed?", [yes,no])
        }
        else if isInternalNoteChange == true
        {
            let yes = UIAlertAction(title: "Proceed", style:.default) { (_) in
                
                self.dismiss(animated: true)
            }
            let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            self.alert("Edits made in the section will be lost if you close the window without submitting. Are you sure you want to proceed?", [yes,no])
        }
        else
        {
            self.dismiss(animated: true)
        }
        
    }
    
    
    func textfieldEditingEnds(){
        if isInternalNoteBtn == true
        {
           if notesTextview.text != "" && notesTextview.text != "Type Here..."
            {
                self.internalNote = notesTextview.text
               for internalItem in self.loadedInternalNote
               {
                   if internalItem["note"] as? String == notesTextview.text
                   {
                       self.isInternalNoteChange = false
                   }
                   else
                   {
                       self.isInternalNoteChange = true
                   }
               }
               self.isInternalNoteChange = true
            }
            else
            {
                notesTextview.text = "Type Here..."
                self.internalNote = notesTextview.text
                notesTextview.textColor = UIColor.lightGray
            }
        }
        else
        {
            if notesTextview.text != "" && notesTextview.text != "Type Here..."
             {
                 self.contractNote = notesTextview.text
                for contractItem in self.loadedContractNote
                {
                    if contractItem["note"] as? String == notesTextview.text
                    {
                        self.isContractNoteChange = false
                    }
                    else
                    {
                        self.isContractNoteChange = true
                    }
                }
                self.isContractNoteChange = true
             }
            else
            {
                notesTextview.text = "Type Here..."
                self.contractNote = notesTextview.text
                notesTextview.textColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton)
    {
        textfieldEditingEnds()
        
        if isContractNoteChange != true
        {
            
            let internalNoteValue = notesTextview.text
            if internalNoteValue == "Type Here..."
            {
                //self.showAlertOk(message: "Internal note cannot be empty.")
               internalNote=""
                internalApiCall()
               // self.dismiss(animated: true)
            }
            else
            {
                internalApiCall()

            }
            
            
        }
        else
        {
            let contractNoteValue = notesTextview.text
            if contractNoteValue == "Type Here..."
            {
                //self.showAlertOk(message: "Contract note cannot be empty.")
                self.dismiss(animated: true)
                
            }
            else
            {
                let notesVC = PopUpViewController.initialization()!
                notesVC.delegate = self
                notesVC.isreminder = true
                notesVC.isCourtesy = false
               // isCourtesy = false
                notesVC.isLogout = false
                self.present(notesVC, animated: true)
            }
        }
    }
    
    func internalApiCall()
    {
        let createdDate = Date().toString()
//        if UserDefaults.standard.value(forKey: "internalNoteDict") == nil
//        {
//            let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
//            let parameters : [String:Any] = ["appointmentId": appointmentId, "noteTypeId": 1, "note": internalNote , "createdDateUtc" : createdDate]
//            notesViewModel.noteCreateapi(parameters: parameters) { success, notesList, message in
//                if success
//                {
//                    var notesDictArray: [[String:Any]] = []
//                    notesDictArray = [
//                        ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
//                    ]
//                    UserDefaults.standard.set(notesDictArray, forKey: "internalNoteDict")
//                    //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
//                    self.dismiss(animated: true)
//                }
//                else
//                {
//                    self.showAlertOk(message: message)
//                }
//            }
//        }
            
            if isInternalNoteBtn==false{
                if UserDefaults.standard.value(forKey: "contractNoteDict") == nil
                {
                    let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
                    let parameters : [String:Any] = ["appointmentId": appointmentId, "noteTypeId": 2, "note": internalNote , "createdDateUtc" : createdDate]
                    notesViewModel.noteCreateapi(parameters: parameters) { success, notesList, message in
                        if success
                        {
                            var notesDictArray: [[String:Any]] = []
                            notesDictArray = [
                                ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                            ]
                            UserDefaults.standard.set(notesDictArray, forKey: "internalNoteDict")
                            //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                            self.dismiss(animated: true)
                        }
                        else
                        {
                            self.showAlertOk(message: message)
                        }
                    }
                    }else{
                        
                        
                        var appointmentNoteId:Int = Int()
                        var appointmentId:Int = Int()
                        var noteTypeId:Int = Int()
                        
                        for item in loadedContractNote
                        {
                            appointmentId = item["appointmentId"] as! Int
                            appointmentNoteId = item["appointmentNoteId"] as! Int
                            noteTypeId = item["noteTypeId"] as! Int
                        }
                        
                        let parameters : [String:Any] = ["appointmentNoteId":appointmentNoteId,"appointmentId": appointmentId, "noteTypeId": noteTypeId , "note": internalNote , "createdDateUtc" : createdDate]
                        notesViewModel.noteUpdateapi(parameters: parameters) { success, notesList, message in
                            if success
                            {
                                var notesDictArray: [[String:Any]] = []
                                notesDictArray = [
                                    ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                                ]
                                UserDefaults.standard.set(notesDictArray, forKey: "contractNoteDict")
                                //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                                self.dismiss(animated: true)
                            }
                            else
                            
                            {
                                self.showAlertOk(message: message)
                            }
                        }
                    }
            
        }
        else
        {
            
            if UserDefaults.standard.value(forKey: "internalNoteDict") == nil
            {
                let appointmentId = UserDefaults.standard.value(forKey: "appointmentID") as! Int
                let parameters : [String:Any] = ["appointmentId": appointmentId, "noteTypeId": 2, "note": internalNote , "createdDateUtc" : createdDate]
                notesViewModel.noteCreateapi(parameters: parameters) { success, notesList, message in
                    if success
                    {
                        var notesDictArray: [[String:Any]] = []
                        notesDictArray = [
                            ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                        ]
                        UserDefaults.standard.set(notesDictArray, forKey: "internalNoteDict")
                        //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                        self.dismiss(animated: true)
                    }
                    else
                    {
                        self.showAlertOk(message: message)
                    }
                }
            }else{
                var appointmentNoteId:Int = Int()
                var appointmentId:Int = Int()
                var noteTypeId:Int = Int()
                
                for item in loadedInternalNote
                {
                    appointmentId = item["appointmentId"] as! Int
                    appointmentNoteId = item["appointmentNoteId"] as! Int
                    noteTypeId = item["noteTypeId"] as! Int
                }
                
                let parameters : [String:Any] = ["appointmentNoteId":appointmentNoteId,"appointmentId": appointmentId, "noteTypeId": noteTypeId , "note": internalNote , "createdDateUtc" : createdDate]
                notesViewModel.noteUpdateapi(parameters: parameters) { success, notesList, message in
                    if success
                    {
                        var notesDictArray: [[String:Any]] = []
                        notesDictArray = [
                            ["appointmentNoteId": (notesList?.appointmentNoteId)! as Int,"appointmentId":(notesList?.appointmentId!)! as Int,"note": (notesList?.note!)! as String,"noteTypeId": (notesList?.noteTypeId!)! as Int ]
                        ]
                        UserDefaults.standard.set(notesDictArray, forKey: "internalNoteDict")
                        //print(UserDefaults.standard.value(forKey: "internalNoteDict"))
                        self.dismiss(animated: true)
                    }
                    else
                    
                    {
                        self.showAlertOk(message: message)
                    }
                }
                
            }
        }
    }
    @IBAction func clearBtnAction(_ sender: UIButton)
    {
        let notesVC = PopUpViewController.initialization()!
        notesVC.delegate = self
        notesVC.isreminder = false
        notesVC.isCourtesy = false
        //isCourtesy = false
        notesVC.isLogout = false
        notesVC.isInternalNote = isInternalNoteBtn
        self.present(notesVC, animated: true)
    }
    
    @IBAction func readmoreBtnCloseAction(_ sender: Any) {

        self.delegate?.backToPresentingClassSalesSchedules()
        self.dismiss(animated: true)
    }
    
    @IBAction func offersWarningOkbtnAction(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.backToPresentingClassSalesSchedules()
        
    }
    
    @IBAction func addtaxAddBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.backToPresentingClassAddtax(taxRate: taxrate)
        
    }
    @IBAction func addTaxNoBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
        self.delegate?.backToPresentingClassAddtax(taxRate: 0)
       
    }
    
}
extension UITextView {
    func adjustUITextViewHeight(scrollEnabled:Bool) {
        let enabledscroll=scrollEnabled
//        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = enabledscroll
    }
}
