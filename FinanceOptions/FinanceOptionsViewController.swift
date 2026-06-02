//
//  FinanceOptionsViewController.swift
//  EHS_Sales
//
//  Created by Anju on 12.04.2023.
//

import UIKit
import DropDown

class FinanceOptionsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CollectionViewCellDelegate,financeNoFinanceCellDelegate,UITextFieldDelegate{
    
    
    static func initialization() -> FinanceOptionsViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "FinanceOptionsViewController") as? FinanceOptionsViewController
    }
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var sumitBtnfinanceEntryView: UIButton!
    @IBOutlet weak var financeTypeLbl: UILabel!
    @IBOutlet weak var financeProviderEntryviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var dropDownAnchorView: UIView!
    @IBOutlet weak var financeProviderDetailstableView: UITableView!
    @IBOutlet weak var financeProviderNameLbl: UILabel!
    @IBOutlet weak var finaceProviderEntryView: UIView!
    @IBOutlet weak var financeserviceProviderListTableView: UITableView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var financeOptionTableView: UITableView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    var financeSelected=0
    var navView = UIView()
    var navViewBottomLine = UIView()
    var financeDetailcell=FinanceDetailsTableViewCell()
    var selectedIndexFinanceProvidersArray=[Int]()
    //var financeProviderNameArray=[String]()
    var financeProviderNameArray=[FinanceProvider]()
    // var financeProvidersSelectedArray=[String]()
    var financeProvidersSelectedArray=[FinanceProvider]()
    var amountEnteredArray=[String]()
    var editTappedIndex=100
    var financeDetailEntryCell=FinanceDetailsEntryTableViewCell()
    var finaceEntryExpirationCell=FinanceEntryExpirationTableViewCell()
    var financeServiceProviderCell=FinanceServiceProviderTableViewCell()
    var financeProviderViewModel=FinanceProviderViewModel()
    var finance_Selected=String()
    var submitted=false
    var financeType_Selected=String()
    var finance_Amount=String()
    var depositAmount=0.00
    var noFinanceArray=[FinanceProvider]()
    var noFinanceACHRequiredFieldsArray=[RequiredFields]()
    var FinanceArray=[FinanceProvider]()
    var requiredFieldsArray=[RequiredFields]()
    var financePlanArray=[String]()
    var financePlanIdArray=[Int]()
    var actual_SaleAmount=Double()
    var projectSelectIndex=Int()
    var balanceAmount=String()
   
       
        
    var drivingStateArray=["Alabama",
                           "Alaska",
                           "Arizona",
                           "Arkansas",
                           "California",
                           "Colorado",
                           "Connecticut",
                           "Delaware",
                           "Florida",
                           "Georgia",
                           "Hawaii",
                           "Idaho",
                           "Illinois",
                           "Indiana",
                           "Iowa",
                           "Kansas",
                           "Kentucky",
                           "Louisiana",
                           "Maine",
                           "Maryland",
                           "Massachusetts",
                           "Michigan",
                           "Minnesota",
                           "Mississippi",
                           "Missouri",
                           "Montana",
                           "Nebraska",
                           "Nevada",
                           "New Hampshire",
                           "New Jersey",
                           "New Mexico",
                           "New York",
                           "North Carolina",
                           "North Dakota",
                           "Ohio",
                           "Oklahoma",
                           "Oregon",
                           "Pennsylvania",
                           "Rhode Island",
                           "South Carolina",
                           "South Dakota",
                           "Tennessee",
                           "Texas",
                           "Utah",
                           "Vermont",
                           "Virginia",
                           "Washington",
                           "West Virginia",
                           "Wisconsin",
                            "Wyoming"]
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.isHidden=true
        let sale_Amount=String(actual_SaleAmount as! Double)
        let actualSaleAmount=sale_Amount.numberFormatter(amount: sale_Amount)
        let formattedActualSaleAmount=actualSaleAmount.replacingOccurrences(of: ",", with: "")
        actual_SaleAmount=(formattedActualSaleAmount as? NSString)?.doubleValue ?? 0
        
        financeOptionTableView.register(UINib(nibName: "SelectPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectPaymentTableViewCell")
        financeOptionTableView.register(UINib(nibName: "FinanceNoFinanceTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceNoFinanceTableViewCell")
        financeOptionTableView.register(UINib(nibName: "FinanceDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceDetailsTableViewCell")
        financeOptionTableView.register(UINib(nibName: "FinanceAmountTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceAmountTableViewCell")
        financeserviceProviderListTableView.register(UINib(nibName: "FinanceServiceProviderTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceServiceProviderTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceDetailsEntryTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceDetailsEntryTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceEntryDrivingLicenseTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceEntryDrivingLicenseTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceEntryExpirationTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceEntryExpirationTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceDetailEntryHeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceDetailEntryHeadingTableViewCell")
        
        //financeProviderNameArray=["GreenSky","Synchrony"]
        selectedIndexFinanceProvidersArray=[1,0]
        
        NotificationCenter.default.addObserver(self,
                            selector: #selector(appCameToForeGround(notification:)),
                            name: UIApplication.didBecomeActiveNotification,
                            object: nil)
        
        UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
        if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
        {
            tokenexpirationCheck()
            
        }
      
        
        setnavBarView()
        setNavigationBarbacklogoNameForFinance(name: "Deposit",superview: navView)
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
            financeProvidersApiCall()
        }else{
           intializeMSAL(isfromLoggedOut: false)
            
        }
    }
    @objc override func refreshTokenCheck(notification: Notification) {
       
        if let dict = notification.userInfo as NSDictionary? {
            if let token = dict["token"] as? Int{
                UserDefaults.standard.set(token, forKey: "token")
                financeProvidersApiCall()
            }
        }
      
    }
    
    @objc override func appCameToForeGround(notification: Notification) {
        if financeProviderNameArray.count==0{
            
            if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
            {
                tokenexpirationCheck()
            }
        }
    
    }
    
        override func performSegueToReturnBack(){
           // let priceDetails = PriceDetailsViewController.initialization()!
            
            
                projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=nofinanceModel.cardCheckDetailArray
            
           
                projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
            
    
            self.navigationController?.popViewController(animated: true)
        }
    
    func financeProvidersApiCall(){
        let parameters=[String:Any]()
        financeProviderViewModel.finance_provider(parameters: parameters) { success, finnceProviders, message in
            if success{
                self.financeProviders(data: finnceProviders ?? [])
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                                       
                                        self.financeProvidersApiCall()
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
    func financeProviders(data: [FinanceProvider]) {
        print("data",data)
        financeProviderNameArray=data
        let noFinanceACHArray=data.filter({ $0.financeServiceProviderName == "ACH" })
        noFinanceACHRequiredFieldsArray=noFinanceACHArray[0].requiredFields ?? []
        projects[projectSelectIndex].ACHFieldArray=noFinanceACHRequiredFieldsArray
        projects[projectSelectIndex].ACHfinanceServiceProviderId=noFinanceACHArray[0].financeServiceProviderId ?? 0
        noFinanceArray=data.filter({ $0.financePaymentTypeId == 2 || $0.financePaymentTypeId == 3})
        financeProviderNameArray=data.filter({ $0.financePaymentTypeId == 1 })
        financeProviderNameArray[0].isSelected=1
        
        financeOptionTableView.reloadData()
        financeserviceProviderListTableView.reloadData()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool){
//        refreshMSALToken()
        
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
        if projects[projectSelectIndex].nofinanceModelcardCheckDetailArray.count==0{
            nofinanceModel.cardCheckDetailArray=[]
        }else{
            nofinanceModel.cardCheckDetailArray=projects[projectSelectIndex].nofinanceModelcardCheckDetailArray
        }
        if projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray.count==0{
            nofinanceModel.DepositFinanceProviderArray=[]
        }else{
            nofinanceModel.DepositFinanceProviderArray=projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray
        }
        
//
//        if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
//            nextBtn.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
//            nextBtn.isUserInteractionEnabled=false
//        }else{
//            nextBtn.backgroundColor=UIColor().colorFromHexString("#304CCE")
//            nextBtn.isUserInteractionEnabled=true
//        }
        
        
       
        
        
         financeOptionTableView.reloadData()
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
    }
    
    func NofinanceSelected(requiredFields: [RequiredFields],headingName:String,finance_selected:Int,financePaymentTypeId:Int) {
        
        
        
        blurView.isHidden=true
        nofinanceModel.financeSelected=0
        let Depositpayment = DepositPaymentMethodViewController.initialization()!
        Depositpayment.actualSaleAmount=actual_SaleAmount
        Depositpayment.requiredFieldsArray=requiredFields
        Depositpayment.requiredHeadingName=headingName
        if financePaymentTypeId==2{
            Depositpayment.cardSelected=0
        }else{
            Depositpayment.cardSelected=1
        }
        self.navigationController?.pushViewController(Depositpayment, animated: true)
        
    }
    func financeSelected( finance_selected: Int) {
        nofinanceModel.financeSelected=1
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        popupView.isHidden=false
        blurView.isHidden=false
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        self.view.addSubview(popupView)
        self.financeOptionTableView.reloadData()
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if tableView==financeOptionTableView{
//            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
//                return 3
//            }else{
//                return 4
//            }
//        }else if tableView==financeserviceProviderListTableView{
//            return 1
//        }else{
//            return 1
//        }
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
           if tableView==financeOptionTableView{
               if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
                   return 1
               }else{
                   return 1
               }
           }else if tableView==financeserviceProviderListTableView{
               return 1
           }else{
              
                   return 3
               }
           }
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
//            nextBtn.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
//            nextBtn.isUserInteractionEnabled=false
//        }else{
            nextBtn.backgroundColor=UIColor().colorFromHexString("#304CCE")
            nextBtn.isUserInteractionEnabled=true
            
//        }
        //Before updated new finance api integration
        
                        if tableView==financeOptionTableView{
                            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
                                return 2
                            }else{
                                return 3
                            }
                        }else if tableView==financeserviceProviderListTableView{
                            return financeProviderNameArray.count
                        }else{
                            
                            switch section{
                            case 0:
                                return 1
                            case 1:
                                return requiredFieldsArray.count
                            case 2:
                                if financePlanArray.count>0{
                                return 1
                                }else{
                                    return 0
                                }
                                
                            default:
                                return 1
                            }
                            
//                            if financeType_Selected=="Wells Fargo"{
//                                return 2
//                            }else if financeType_Selected=="GreenSky"{
//                                return 3
//                            }else{
//                                return 4
//                            }
                        }
        //Before updated new finance api integration
        
        //
//        if tableView==financeOptionTableView{
//            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
//                switch section{
//                case 0:
//                    return 1
//                case 1:
//                    return 1
//                case 2:
//                    return 1
//                default:
//                    return 1
//                }
//            }else{
//                switch section{
//                case 0:
//                    return 1
//                case 1:
//                    return 1
//                case 2:
//                    return 1
//                case 3:
//                    return 1
//                default:
//                    return 1
//                }
//            }
//        }else if tableView==financeserviceProviderListTableView{
//            return financeProviderNameArray.count
//        }else{
//            //            switch section{
//            //            case 0:
//            return 1
//
////            case 1:
////                return
////                1
//////                nofinanceModel.DepositFinanceProviderArray[editTappedIndex].requiredFields?.count ?? 0
////            default:
////                return 1
//
//        }
        
    }
    
    
    //Before updated new finance api integration
    
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView==financeOptionTableView{
            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    cell.selectpaymentOptionLbl.text="SELECT A DEPOSIT PAYMENT OPTION"
                    cell.checkBtn.addTarget(self, action: #selector(checkBtnActiom(sender: )), for: .touchUpInside)
                    cell.creditCardBtn.addTarget(self, action: #selector(creditCardBtnAction(sender: )), for: .touchUpInside)
                    cell.financeBtn.addTarget(self, action: #selector(financeBtnAction(sender: )), for: .touchUpInside)
                    if projects[projectSelectIndex].discountDollars != "0.00"&&projects[projectSelectIndex].discountDollars != ""&&projects[projectSelectIndex].discountDollars != "0"{
                        cell.newoverstockpriceLbl.text="New Overstock Price"
                    }else{
                        cell.newoverstockpriceLbl.text="Overstock Price"
                    }
                    cell.financeOptionLbl.text="Inclusive of all taxes"
                    cell.creditCardView.cornerRadius=8
                    cell.checkView.cornerRadius=8
                    cell.financeView.cornerRadius=8
                    //            if financeSelected==0{
                    cell.creditCardView.borderWidth=2
                    cell.financeView.borderWidth=2
                    cell.creditCardView.borderColor=UIColor().colorFromHexString("#304CCE")
                    cell.checkView.borderColor=UIColor().colorFromHexString("#304CCE")
                    cell.financeView.borderColor=UIColor().colorFromHexString("#304CCE")
                    // cell.noFinanceImageView.image=UIImage(named: "selected")
                    // cell.financeImageView.image=UIImage(named: "unSelected")
                    cell.creditCardView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    cell.checkView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    cell.financeView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    cell.checkView.borderWidth=2
                    let saleAmount=actual_SaleAmount as! Double
                    let saleAmountstring=String(actual_SaleAmount)
                    cell.priceLbl.text="$ "+saleAmountstring.numberFormatter(amount: saleAmountstring)
                    
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceAmountTableViewCell") as! FinanceAmountTableViewCell
                    let saleAmount=actual_SaleAmount as! Double
                    let saleAmountstring=String(actual_SaleAmount)
                    balanceAmount=saleAmountstring.numberFormatter(amount: saleAmountstring)
                    cell.balanceAmountLbl.text="$ "+saleAmountstring.numberFormatter(amount: saleAmountstring)
                    cell.remainingAmountLbl.text="Remaining Amount:"
                    cell.depositAmountLbl.text=""
                    cell.remainingamountLblwidthConstraint.constant=268
                    return cell
                    
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    return cell
                }
            }else{
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    cell.selectpaymentOptionLbl.text="SELECT A DEPOSIT PAYMENT OPTION"
                    cell.checkBtn.addTarget(self, action: #selector(checkBtnActiom(sender: )), for: .touchUpInside)
                    cell.creditCardBtn.addTarget(self, action: #selector(creditCardBtnAction(sender: )), for: .touchUpInside)
                    cell.financeBtn.addTarget(self, action: #selector(financeBtnAction(sender: )), for: .touchUpInside)
                    // cell.financeOptionLbl.text=finance_Selected
                    cell.financeOptionLbl.text="Inclusive of all taxes"
                    
                    
                    cell.creditCardView.cornerRadius=8
                    cell.checkView.cornerRadius=8
                    cell.financeView.cornerRadius=8
                    //            if financeSelected==0{
                    cell.creditCardView.borderWidth=2
                    cell.financeView.borderWidth=2
                    cell.creditCardView.borderColor=UIColor().colorFromHexString("#304CCE")
                    cell.checkView.borderColor=UIColor().colorFromHexString("#304CCE")
                    cell.financeView.borderColor=UIColor().colorFromHexString("#304CCE")
                    // cell.noFinanceImageView.image=UIImage(named: "selected")
                    // cell.financeImageView.image=UIImage(named: "unSelected")
                    cell.creditCardView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    cell.checkView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    cell.financeView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    cell.checkView.borderWidth=2
                    let saleAmount=actual_SaleAmount as! Double
                    let saleAmountstring=String(actual_SaleAmount)
                    cell.priceLbl.text="$ "+saleAmountstring.numberFormatter(amount: saleAmountstring)
                    return cell
                case 1:
                    financeDetailcell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsTableViewCell") as! FinanceDetailsTableViewCell
                    //            if financeSelected==1{
                    //                financeDetailcell.financenofinanceheightConstraint.constant=40
                    //                financeDetailcell.finance_nofinanceLbl.text="FINANCE DETAILS"
                    //            }else{
                    financeDetailcell.financenofinanceheightConstraint.constant=0
                    
                    //            }
                    financeDetailcell.collectionviewCellUnhideBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
                    financeDetailcell.isFromBalanceVc=false
                    financeDetailcell.finance_selected=nofinanceModel.financeSelected
                    financeDetailcell.fianceproviderForCollectionViewArray=nofinanceModel.DepositFinanceProviderArray
                    financeDetailcell.nofinanceCardDetailArray=nofinanceModel.cardCheckDetailArray
                    print("financeDetailcell.nofinanceCardDetailArray", financeDetailcell.nofinanceCardDetailArray)
                    
                    
                    //            if nofinanceModel.DepositFinanceProviderArray.count==0{
                    financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
                    financeDetailcell.addBtnViewIncollectionView.isHidden=true
                    financeDetailcell.financeTypeCollectionView.isHidden=false
                    financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
                    financeDetailcell.addInsidecolletionViewBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
                    
                    financeDetailcell.cellDelegate=self
                    financeDetailcell.amountEnteredLblArray=amountEnteredArray
                    financeDetailcell.editActionTappedIndex=editTappedIndex
                    // financeDetailcell.addBtninsideCollectionViewWidthConstarint.constant=CGFloat(financeProvidersSelectedArray.count*400)+10
                    financeDetailcell.financeTypeCollectionView.reloadData()
                    return financeDetailcell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceAmountTableViewCell") as! FinanceAmountTableViewCell
                    depositAmount=0.00
                    if nofinanceModel.cardCheckDetailArray.count==0{
                        
                    }else{
                        
                        for i  in 0...nofinanceModel.cardCheckDetailArray.count-1{
                            //
                            let amount1=(nofinanceModel.cardCheckDetailArray[i]["amount"] as? String)?.replacingOccurrences(of: ",", with: "") ?? ""
                            let amount2=Double(amount1) ?? 0.0
                            depositAmount+=amount2
                        }
                    }
                    if nofinanceModel.DepositFinanceProviderArray.count==0{
                    }else{
                        // depositAmount=0.00
                        for i  in 0...nofinanceModel.DepositFinanceProviderArray.count-1{
                            let amount1=nofinanceModel.DepositFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                            let amount2=Double(amount1) ?? 0.0
                            depositAmount+=amount2
                            
                        }
                    }
                    if nofinanceModel.DepositFinanceProviderArray.count==0&&nofinanceModel.cardCheckDetailArray.count==0{
                        cell.depositAmountLbl.text=""
                    } else{
                        cell.depositAmountLbl.text=(String(depositAmount)).numberFormatter(amount: String(depositAmount))
                    }
                    balanceAmount=String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount))
                    cell.balanceAmountLbl.text="$ "+(String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount)))
                    cell.remainingamountLblwidthConstraint.constant=250
                    cell.remainingAmountLbl.text="Financed Amount:"
                    return cell
                    
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    
                    return cell
                }
            }
        }else if tableView==financeserviceProviderListTableView{
            financeServiceProviderCell = tableView.dequeueReusableCell(withIdentifier: "FinanceServiceProviderTableViewCell") as! FinanceServiceProviderTableViewCell
            financeServiceProviderCell.outerView.borderWidth=2
            financeServiceProviderCell.outerView.cornerRadius=8
            // if selectedIndexFinanceProvidersArray[indexPath.row]==1{
            if financeProviderNameArray[indexPath.row].isSelected==1{
                financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#304CCE")
                financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "selected")
            }else{
                financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#CBCCD5")
                financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
                financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "unSelected")
            }
            financeServiceProviderCell.financeProviderSelctionBtn.tag=indexPath.row
            financeServiceProviderCell.financeProviderSelctionBtn.addTarget(self, action: #selector(finaceProviderSelectionAction(sender: )), for: .touchUpInside)
            financeServiceProviderCell.financeProviderLbl.text=financeProviderNameArray[indexPath.row].financeServiceProviderName
            
            return financeServiceProviderCell
        }else{
            
            if indexPath.section==0{
                let  FinanceDetailEntryHeadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailEntryHeadingTableViewCell") as! FinanceDetailEntryHeadingTableViewCell
                FinanceDetailEntryHeadingTableViewCell.financeTypeLbl.text=financeType_Selected
                FinanceDetailEntryHeadingTableViewCell.balanceAmountLbl.text="$ "+String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount))
                return FinanceDetailEntryHeadingTableViewCell
            } else if indexPath.section==2{
                    let financeDetailexpiryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
                financeDetailexpiryCell.dropDown.anchorView = financeDetailexpiryCell.dropdownAnchorView
                financeDetailexpiryCell.headingLbl.text="Finance Plan"
                financeDetailexpiryCell.dropDown.dataSource=financePlanArray
                if nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlanselected==""{
                    financeDetailexpiryCell.drorDownBtn.setTitle("Finance Plan", for: .normal)
                    financeDetailexpiryCell.drorDownBtn.setTitleColor(.lightGray, for: .normal)
                }else{
                    financeDetailexpiryCell.drorDownBtn.setTitle(nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlanselected, for: .normal)
                    financeDetailexpiryCell.drorDownBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
                }
                
                financeDetailexpiryCell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    financeDetailexpiryCell.drorDownBtn.setTitle(item, for: .normal)
                    financeDetailexpiryCell.drorDownBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
                    nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlanselected=item
                    nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlanIdSelected=financePlanIdArray[index]
                    
                    
                    
                }
                    
                    return financeDetailexpiryCell
                
            
            }else{

                if requiredFieldsArray[indexPath.row].name=="Drivers License State"{
                    let financeDetailexpiryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
                    financeDetailexpiryCell.dropDown.anchorView = financeDetailexpiryCell.dropdownAnchorView
                    
                    financeDetailexpiryCell.drorDownBtn.tag=requiredFieldsArray[indexPath.row].id ?? 0
                    if requiredFieldsArray[indexPath.row].valueEntered==""{
                        financeDetailexpiryCell.drorDownBtn.setTitleColor(.lightGray, for: .normal)
                        financeDetailexpiryCell.drorDownBtn.setTitle("Select State", for: .normal)
                    }else{
                        financeDetailexpiryCell.drorDownBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
                        financeDetailexpiryCell.drorDownBtn.setTitle(requiredFieldsArray[indexPath.row].valueEntered, for: .normal)
                    }
                    financeDetailexpiryCell.dropDown.dataSource=drivingStateArray
                    financeDetailexpiryCell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        financeDetailexpiryCell.drorDownBtn.setTitle(item, for: .normal)
                        financeDetailexpiryCell.drorDownBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
                        if financeDetailexpiryCell.drorDownBtn.tag==requiredFieldsArray[indexPath.row].id{
                            requiredFieldsArray[indexPath.row].valueEntered=item
                        }
                        
                    }
                    financeDetailexpiryCell.headingLbl.text=requiredFieldsArray[indexPath.row].name
                    
                    return financeDetailexpiryCell
                    
                }else if requiredFieldsArray[indexPath.row].name=="Drivers License Expiration Date"{
                    finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
                    finaceEntryExpirationCell.AmntTxtfld.delegate=self
                    finaceEntryExpirationCell.AmntTxtfld.tag=requiredFieldsArray[indexPath.row].id ?? 0
                    finaceEntryExpirationCell.headingLbl.text="Drivers License Expiration Date"
                    finaceEntryExpirationCell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnAction(sender: )), for: .touchUpInside)
                    if requiredFieldsArray[indexPath.row].valueEntered==""{
                        finaceEntryExpirationCell.AmntTxtfld.placeholder="MM/DD/YYYY"
                        finaceEntryExpirationCell.AmntTxtfld.text=""
                    }else{
                        finaceEntryExpirationCell.AmntTxtfld.text=requiredFieldsArray[indexPath.row].valueEntered
                    }
                                return finaceEntryExpirationCell
                    
                }else{
                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
                    financeDetailEntryCell.amountTxtFld.keyboardType = .numberPad
                    financeDetailEntryCell.amountTxtFld.delegate=self
//                    for i in 0...requiredFieldsArray.count-1{
                        financeDetailEntryCell.amountTxtFld.tag=requiredFieldsArray[indexPath.row].id ?? 0
//                    }
                    if requiredFieldsArray[indexPath.row].valueEntered==""{
                        financeDetailEntryCell.amountTxtFld.placeholder=requiredFieldsArray[indexPath.row].name
                        financeDetailEntryCell.amountTxtFld.text=""
                    }else{
                        financeDetailEntryCell.amountTxtFld.text=requiredFieldsArray[indexPath.row].valueEntered
                    }
                    financeDetailEntryCell.headingLbl.text=requiredFieldsArray[indexPath.row].name
//                    if requiredFieldsArray[indexPath.row].name=="Drivers License Expiration Date"{
//                        if requiredFieldsArray[indexPath.row].valueEntered==""{
//                            financeDetailEntryCell.amountTxtFld.placeholder="MM/DD/YYYY"
//                            financeDetailEntryCell.amountTxtFld.text=""
//                        }else{
//                            financeDetailEntryCell.amountTxtFld.text=requiredFieldsArray[indexPath.row].valueEntered
//                        }
//                        financeDetailEntryCell.amntLblTrailingconstraint.constant=20
//                        financeDetailEntryCell.dollarLbl.isHidden=true
//                    }else{
                        financeDetailEntryCell.amntLblTrailingconstraint.constant=48
                    if indexPath.row != 0
                    {
                        financeDetailEntryCell.dollarLbl.isHidden=false
                     financeDetailEntryCell.dollarWidthConstraint.constant = 20
                    }
                    else
                    {
                        financeDetailEntryCell.dollarLbl.isHidden=true
                        financeDetailEntryCell.dollarWidthConstraint.constant = 0
                        financeDetailEntryCell.amntLblTrailingconstraint.constant=20
                    }
//                    }
                    
                    return financeDetailEntryCell
                }
                  
            }
        }
    }
//                }else{
//                    if financeType_Selected=="Wells Fargo"{
//                        financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//                        if indexPath.row==0{
//                            financeDetailEntryCell.headingLbl.text="App ID*"
//                            financeDetailEntryCell.amountTxtFld.text="GS950036"
//                            financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                            financeDetailEntryCell.amountLblTrailing.constant=20
//                        }else{
//                            financeDetailEntryCell.headingLbl.text="Amount*"
//                            financeDetailEntryCell.amountTxtFld.text=finance_Amount
//                            financeDetailEntryCell.placeholderTextLbl.isHidden=false
//                            financeDetailEntryCell.amountLblTrailing.constant=45
//
//
//                        }
//
//                        return financeDetailEntryCell
//                    }else if financeType_Selected=="GreenSky"{
//                        if indexPath.row==0{
//                            financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//
//                            financeDetailEntryCell.headingLbl.text="App ID*"
//                            financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                            financeDetailEntryCell.amountLblTrailing.constant=20
//                            return financeDetailEntryCell
//
//                        }
//
//                        else if indexPath.row==1{
//                            finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
//                            finaceEntryExpirationCell.headingLbl.text="Amount*"
//                            finaceEntryExpirationCell.AmntTxtfld.text=finance_Amount
//                            //cell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnAction(sender: )), for: .touchUpInside)
//                            return finaceEntryExpirationCell
//
//                        }else{
//                            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
//                            cell.dropDown.anchorView = cell.dropdownAnchorView
//                            // cell.dropDown.width = financeProviderDetailstableView.frame.size.width-20
//
//                            return cell
//                        }
//
//
//                        //            else if financeType_Selected=="Synchrony"{
//                        //                if indexPath.row==0{
//                        //                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//                        //
//                        //                    financeDetailEntryCell.headingLbl.text="Account Number*"
//                        //                    financeDetailEntryCell.amountTxtFld.text="800069988653"
//                        //                    financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                        //                    financeDetailEntryCell.amountLblTrailing.constant=20
//                        //                    return financeDetailEntryCell
//                        //
//                        //                }
//                        //                else if indexPath.row==1{
//                        //                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
//                        //                    cell.dropDown.anchorView = cell.dropdownAnchorView
//                        //                    cell.headingLbl.text="Driving Licence Issue State*"
//                        //                    cell.selctstateTxtFld.placeholder="Select State"
//                        //                    return cell
//                        //                }
//                        //                else if indexPath.row==2{
//                        //                    finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
//                        //                    finaceEntryExpirationCell.headingLbl.text="Expiration Date*"
//                        //                    finaceEntryExpirationCell.AmntTxtfld.placeholder="MM/DD/YYYY"
//                        //
//                        //                    //cell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnAction(sender: )), for: .touchUpInside)
//                        //                    return finaceEntryExpirationCell
//                        //                }else if indexPath.row==3{
//                        //                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//                        //
//                        //                    financeDetailEntryCell.headingLbl.text="Amount"
//                        //                    financeDetailEntryCell.amountTxtFld.text=finance_Amount
//                        //                    financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                        //                    financeDetailEntryCell.amountLblTrailing.constant=20
//                        //                    return financeDetailEntryCell
//                        //                }else{
//                        //                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
//                        //                    cell.dropDown.anchorView = cell.dropdownAnchorView
//                        //                    //cell.dropDown.width = financeProviderDetailstableView.frame.size.width-20
//                        //                    return cell
//                        //                }
//
//                    }else{
//                        if indexPath.row==0{
//                            financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//
//                            financeDetailEntryCell.headingLbl.text="Account Number*"
//                            financeDetailEntryCell.amountTxtFld.text="800069988653"
//                            financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                            financeDetailEntryCell.amountLblTrailing.constant=20
//                            return financeDetailEntryCell
//
//                        }
//                        //                else if indexPath.row==2{
//                        //                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//                        //                    financeDetailEntryCell.headingLbl.text="Max Credit Limit*"
//                        //                    financeDetailEntryCell.placeholderTextLbl.isHidden=false
//                        //                    financeDetailEntryCell.amountLblTrailing.constant=45
//                        //                    return financeDetailEntryCell
//                        //                }
//                        else if indexPath.row==2{
//                            finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
//                            finaceEntryExpirationCell.headingLbl.text="Max Credit Limit*"
//                            finaceEntryExpirationCell.AmntTxtfld.text=finance_Amount
//
//                            //cell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnAction(sender: )), for: .touchUpInside)
//                            return finaceEntryExpirationCell
//                        }else if indexPath.row==1{
//                            financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//
//                            financeDetailEntryCell.headingLbl.text="Authorization Number*"
//                            financeDetailEntryCell.amountTxtFld.text="800069988653"
//                            financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                            financeDetailEntryCell.amountLblTrailing.constant=20
//                            return financeDetailEntryCell
//                        }else{
//                            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
//                            cell.dropDown.anchorView = cell.dropdownAnchorView
//                            //cell.dropDown.width = financeProviderDetailstableView.frame.size.width-20
//                            return cell
//                        }
//
//                    }
//                }
//            }
    //Before updated new finance api integration
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        if tableView==financeOptionTableView{
//            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
//                switch indexPath.section {
//                case 0:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
//                    cell.selectpaymentOptionLbl.text="SELECT A DEPOSIT PAYMENT OPTION"
//                    cell.checkBtn.addTarget(self, action: #selector(checkBtnActiom(sender: )), for: .touchUpInside)
//                    cell.creditCardBtn.addTarget(self, action: #selector(creditCardBtnAction(sender: )), for: .touchUpInside)
//                    cell.financeBtn.addTarget(self, action: #selector(financeBtnAction(sender: )), for: .touchUpInside)
//
//                    cell.financeOptionLbl.text="Inclusive of all taxes"
//
//
//                    return cell
//                case 1:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceNoFinanceTableViewCell") as! FinanceNoFinanceTableViewCell
//                    cell.nofinancedelegate=self
//                    cell.financenofinanceArray=noFinanceArray
//                    cell.financeNoFinanceCollectionView.reloadData()
//                    return cell
//                case 2:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceAmountTableViewCell") as! FinanceAmountTableViewCell
//                    cell.balanceAmountLbl.text="$ "+"8,000.00"
//                    cell.remainingAmountLbl.text="Remaining Amount:"
//                    cell.depositAmountLbl.text=""
//                    cell.remainingamountLblwidthConstraint.constant=268
//                    return cell
//
//                default:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
//                    return cell
//                }
//            }else{
//                switch indexPath.section {
//                case 0:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
//                    cell.selectpaymentOptionLbl.text="SELECT A DEPOSIT PAYMENT OPTION"
//                    cell.checkBtn.addTarget(self, action: #selector(checkBtnActiom(sender: )), for: .touchUpInside)
//                    cell.creditCardBtn.addTarget(self, action: #selector(creditCardBtnAction(sender: )), for: .touchUpInside)
//                    cell.financeBtn.addTarget(self, action: #selector(financeBtnAction(sender: )), for: .touchUpInside)
//
//                    cell.financeOptionLbl.text="Inclusive of all taxes"
//
//
//                    return cell
//                case 1:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceNoFinanceTableViewCell") as! FinanceNoFinanceTableViewCell
//                    cell.nofinancedelegate=self
//                    cell.financenofinanceArray=noFinanceArray
//                    cell.financeNoFinanceCollectionView.reloadData()
//                    return cell
//                case 2:
//                    financeDetailcell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsTableViewCell") as! FinanceDetailsTableViewCell
//                    //            if financeSelected==1{
//                    //                financeDetailcell.financenofinanceheightConstraint.constant=40
//                    //                financeDetailcell.finance_nofinanceLbl.text="FINANCE DETAILS"
//                    //            }else{
//                    financeDetailcell.financenofinanceheightConstraint.constant=0
//
//                    //            }
//                    financeDetailcell.collectionviewCellUnhideBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
//                    financeDetailcell.isFromBalanceVc=false
//                    financeDetailcell.finance_selected=nofinanceModel.financeSelected
//                    financeDetailcell.fianceproviderForCollectionViewArray=nofinanceModel.DepositFinanceProviderArray
//                    financeDetailcell.nofinanceCardDetailArray=nofinanceModel.cardCheckDetailArray
//
//
//                    //            if nofinanceModel.DepositFinanceProviderArray.count==0{
//                    financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
//                    financeDetailcell.addBtnViewIncollectionView.isHidden=true
//                    financeDetailcell.financeTypeCollectionView.isHidden=false
//                    financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
//                    financeDetailcell.addInsidecolletionViewBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
//
//                    financeDetailcell.cellDelegate=self
//                    financeDetailcell.amountEnteredLblArray=amountEnteredArray
//                    financeDetailcell.editActionTappedIndex=editTappedIndex
//                    // financeDetailcell.addBtninsideCollectionViewWidthConstarint.constant=CGFloat(financeProvidersSelectedArray.count*400)+10
//                    financeDetailcell.financeTypeCollectionView.reloadData()
//                    return financeDetailcell
//                case 3:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceAmountTableViewCell") as! FinanceAmountTableViewCell
//                    cell.balanceAmountLbl.text="$ "+"8,000.00"
//                    cell.remainingAmountLbl.text="Remaining Amount:"
//                    cell.depositAmountLbl.text=""
//                    cell.remainingamountLblwidthConstraint.constant=268
//                    return cell
//
//                default:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
//                    return cell
//                }
//            }
//        }else if tableView==financeserviceProviderListTableView{
//            financeServiceProviderCell = tableView.dequeueReusableCell(withIdentifier: "FinanceServiceProviderTableViewCell") as! FinanceServiceProviderTableViewCell
//            financeServiceProviderCell.outerView.borderWidth=2
//            financeServiceProviderCell.outerView.cornerRadius=8
//            // if selectedIndexFinanceProvidersArray[indexPath.row]==1{
//            if financeProviderNameArray[indexPath.row].isSelected==1{
//                financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#304CCE")
//                financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
//                financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "selected")
//            }else{
//                financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#CBCCD5")
//                financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
//                financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "unSelected")
//            }
//            financeServiceProviderCell.financeProviderSelctionBtn.tag=indexPath.row
//            financeServiceProviderCell.financeProviderSelctionBtn.addTarget(self, action: #selector(finaceProviderSelectionAction(sender: )), for: .touchUpInside)
//            financeServiceProviderCell.financeProviderLbl.text=financeProviderNameArray[indexPath.row].financeServiceProviderName
//            return financeServiceProviderCell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//            return cell
//        }
//    }
    
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if tableView==financeOptionTableView{
    
                    if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
    
    
                        switch indexPath.row {
                        case 0:
    
                            return 300
    
                        case 1:
    
                            return 170
    
                        default:
    
                            return 300
                        }
    
                    }else{
                        switch indexPath.row {
                        case 0:
    
                            return 300
                        case 1:
                            if nofinanceModel.financeSelected==0&&nofinanceModel.cardCheckDetailArray.count>0{
                                return 150
                            }else if nofinanceModel.financeSelected==1&&nofinanceModel.DepositFinanceProviderArray.count>0 {
                                return 150
                            }else{
                                return 150
                            }
                        case 2:
                            return 170
    
                        default:
    
                            return 300
                        }
                    }
                }else if tableView==financeserviceProviderListTableView{
                    return 84
                }else{
                    if indexPath.section==0{
                      return 230
                    }else if indexPath.section==2{
                        if financePlanArray.count>0{
                            return 120
                        }else{
                            return 0
                        }
                    }else{
                        return 120
                    }
                    
//                    if editTappedIndex==0{
//                        return 120
//                    }else if editTappedIndex==1{
//                        return 120
//                    }else{
//                        return 120
//                    }
                }
            }
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView==financeOptionTableView{
//            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
//
//                switch indexPath.section{
//                case 0:
//                    return 200
//                case 1:
//                    return 130
//                case 2:
//                    return 200
//
//                default:
//
//                    return 300
//                }
//            }else{
//                switch indexPath.section{
//                case 0:
//                    return 200
//                case 1:
//                    return 130
//                case 2:
//                    return 150
//                case 3:
//                    return 200
//                default:
//
//                    return 300
//                }
//            }
//        }else if tableView==financeserviceProviderListTableView{
//            return 80
//        }else{
//            return 200
//        }
//
//
//
//
//    }
    
    @objc func datePickerBtnAction(sender:UIButton){
        
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        popupView.isHidden=true
        finaceProviderEntryView.isHidden=true
        blurView.isHidden=false
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        
        datePicker.isHidden=false
        datePicker.backgroundColor =
            .white
        datePicker.datePickerMode = .date
        
        self.view.addSubview(datePicker)
        
    }
    
    func financeSelected(editAction: Bool, index: Int, didTappedIncollectionViewcell: Int, financeTypeSelected: String, financeAmount: String) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       print(textField.tag)
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        for i in 0...requiredFieldsArray.count-1{
            if textField.tag==requiredFieldsArray[i].id{
                requiredFieldsArray[i].valueEntered=newString
            }
            print("requiredFieldsArray",requiredFieldsArray)
            if requiredFieldsArray[i].name == "Drivers License Expiration Date"{
                if textField.tag==requiredFieldsArray[i].id{
                    guard let text = textField.text else { return false }
                    let newString = (text as NSString).replacingCharacters(in: range, with: string)
                    textField.text = self.format(with: "XX/XX/XXXX", phone: newString)
                    requiredFieldsArray[i].valueEntered=textField.text ?? ""
                    return false
                }
            }
        }
        if textField.tag == 4 || textField.tag == 11{
//                ||requiredFieldsArray[i].name == "Amount"{
                    let allowedCharacters = CharacterSet(charactersIn:".0123456789")//Here change this characters based on your requirement
                    let characterSet = CharacterSet(charactersIn: string)
                    return allowedCharacters.isSuperset(of: characterSet)
                }
                
        
        
        
            return true
        
    }
    
    
    
    @IBAction func datePickervalueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        
        print("selectedDate",selectedDate)
        print("selectedDate",selectedDate)
        
        let formattedDateString = convertDateToString(date: selectedDate)
        print(formattedDateString)
        for i in 0...requiredFieldsArray.count-1{
            if requiredFieldsArray[i].name=="Drivers License Expiration Date"{
                requiredFieldsArray[i].valueEntered=formattedDateString
            }
        }
        popupView.isHidden=true
        datePicker.isHidden=true
        financeProviderDetailstableView.reloadData()
        finaceProviderEntryView.isHidden=false
    }
    

    // Example usage:
  
    @objc func finaceProviderSelectionAction(sender:UIButton){
        ///        selectedIndexFinanceProvidersArray=[0,0]
        //        for i in 0...selectedIndexFinanceProvidersArray.count-1{
        //            if sender.tag==i{
        //                if selectedIndexFinanceProvidersArray[i]==0{
        //                selectedIndexFinanceProvidersArray[i]=1
        //                    financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#304CCE")
        //                    financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
        //                    financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "selected")
        //                }else{
        //                    selectedIndexFinanceProvidersArray[i]=0
        //                    financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#CBCCD5")
        //                    financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
        //                    financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "unSelected")
        //                }
        //            }else{
        //                selectedIndexFinanceProvidersArray[i]=0
        //                financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#CBCCD5")
        //                financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
        //                financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "unSelected")
        //            }
        //        }
        
        
       
        
        for i in 0...financeProviderNameArray.count-1{
            if sender.tag==i{
                if financeProviderNameArray[i].isSelected==0{
                    financeProviderNameArray[i].isSelected=1
                    financeType_Selected=financeProviderNameArray[i].financeServiceProviderName ?? ""
                    financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#304CCE")
                    financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "selected")
                }else{
                    if selectedIndexFinanceProvidersArray.count>0{
                        selectedIndexFinanceProvidersArray[i]=0
                    }
                    financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#CBCCD5")
                    financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
                    financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "unSelected")
                }
            }else{
                financeProviderNameArray[i].isSelected=0
                financeServiceProviderCell.outerView.borderColor=UIColor().colorFromHexString("#CBCCD5")
                financeServiceProviderCell.outerView.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
                financeServiceProviderCell.financeproviderSelectImageview.image=UIImage(named: "unSelected")
            }
        }
        
        
        financeserviceProviderListTableView.reloadData()
    }
    
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    //    {
    //        if tableView==financeserviceProviderListTableView{
    //
    //            for i in 0...selectedIndexFinanceProvidersArray.count-1{
    //                if indexPath.row==i{
    //                    if selectedIndexFinanceProvidersArray[i]==0{
    //                    selectedIndexFinanceProvidersArray[i]=1
    //                }else{
    //                    selectedIndexFinanceProvidersArray[i]=0
    //                }
    //            }
    //            }
    //            financeserviceProviderListTableView.reloadData()
    //        }
    //
    //    }
    @objc func collectionviewUnhideAction(sender:UIButton){
        if nofinanceModel.financeSelected==0{
            
            let Depositpayment = DepositPaymentMethodViewController.initialization()!
            
            
            self.navigationController?.pushViewController(Depositpayment, animated: true)
            
        }else{
            
            blurView.backgroundColor=UIColor().colorFromHexString("#232538")
                .withAlphaComponent(0.7)
            popupView.isHidden=false
            blurView.isHidden=false
            self.navView.addSubview(blurView)
            self.navViewBottomLine.addSubview(blurView)
            self.view.addSubview(popupView)
        }
        // self.navViewBottomLine.addSubview(popupView)
    }
    
    @IBAction func btnaction(_ sender: Any) {
        blurView.isHidden=true
        popupView.isHidden=true
    }
    
    @objc func checkBtnActiom(sender:UIButton){
        blurView.isHidden=true
        nofinanceModel.financeSelected=0
        let Depositpayment = DepositPaymentMethodViewController.initialization()!
        Depositpayment.cardSelected=1
        Depositpayment.ACHFieldArray=noFinanceACHRequiredFieldsArray
        Depositpayment.actualSaleAmount=actual_SaleAmount
        Depositpayment.balance_Amount=balanceAmount
        Depositpayment.Balance_Amount=String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount))
        self.navigationController?.pushViewController(Depositpayment, animated: true)
        
        
    }
    @objc func creditCardBtnAction(sender:UIButton){
        blurView.isHidden=true
        nofinanceModel.financeSelected=0
        let cardArray=noFinanceArray.filter({ $0.financePaymentTypeId == 2})
        var card_TypeArray=[String]()
        var cardIdArray=[Int]()
        if cardArray.count>0{
            for i in 0...cardArray.count-1{
                card_TypeArray.append(cardArray[i].financeServiceProviderName ?? "")
                cardIdArray.append(cardArray[i].financeServiceProviderId ?? 0)
            }
        }
        let Depositpayment = DepositPaymentMethodViewController.initialization()!
        Depositpayment.cardSelected=0
        Depositpayment.actualSaleAmount=actual_SaleAmount
        Depositpayment.cardTypeArray=card_TypeArray
        Depositpayment.cardArrayForCreditCard=cardArray
        Depositpayment.cardTypeIdArray=cardIdArray
        Depositpayment.Balance_Amount=String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount))
        Depositpayment.balance_Amount=balanceAmount
        self.navigationController?.pushViewController(Depositpayment, animated: true)
        
    }
    @objc func financeBtnAction(sender:UIButton){
        if financeProviderNameArray.count==0{
            self.showAlertOk(message: "Finance Service Providers are not available")
        }else{
            nofinanceModel.financeSelected=1
            blurView.backgroundColor=UIColor().colorFromHexString("#232538")
                .withAlphaComponent(0.7)
            popupView.isHidden=false
            blurView.isHidden=false
            self.navView.addSubview(blurView)
            self.navViewBottomLine.addSubview(blurView)
            self.view.addSubview(popupView)
            self.financeOptionTableView.reloadData()
        }
    }
    
    @IBAction func financeProvidecancelBtnAction(_ sender: Any) {
        blurView.isHidden=true
        popupView.isHidden=true
    }
    
    @IBAction func financeProviderNextBtnAction(_ sender: Any) {
//        let financecount = nofinanceModel.DepositFinanceProviderArray.filter({ $0.financeServiceProviderName == financeType_Selected })
//        if financecount.count>0{
//            self.showAlertOk(message: "Finance provider already selected")
//        }else{
//
            blurView.isHidden=true
            popupView.isHidden=true
            
            //       // financeProvidersSelectedArray.removeAll()
            //        for i in 0...selectedIndexFinanceProvidersArray.count-1{
            //            if selectedIndexFinanceProvidersArray[i]==1{
            //                financeProvidersSelectedArray.append(financeProviderNameArray[i])
            //            }
            //        }
            //        if financeProvidersSelectedArray.count>0{
            //        financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
            //        }
            //        financeOptionTableView.reloadData()
        var  financeproviderurl=String()
            for i in 0...financeProviderNameArray.count-1{
                if financeProviderNameArray[i].isSelected==1{
                    financeproviderurl=financeProviderNameArray[i].financeServiceProviderUrl ?? ""
                    nofinanceModel.DepositFinanceProviderArray.append(financeProviderNameArray[i])
                    // financeProvidersSelectedArray.append(financeProviderNameArray[i])
                }
            }
            //if financeProvidersSelectedArray.count>0{
            //        if nofinanceModel.DepositFinanceProviderArray.count>0{
            //        financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
            //        }
            nofinanceModel.financeSelected=1
           projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
            financeOptionTableView.reloadData()
        let financeprovider = FinanceproviderUrlViewController.initialization()!
        financeprovider.financeprovider_Url=financeproviderurl
        self.navigationController?.pushViewController(financeprovider, animated: true)
        
//        }
        
    }
     func scrollToTop() {
        // 1
        let topRow = IndexPath(row: 0,
                               section: 0)
                               
        // 2
        self.financeProviderDetailstableView.scrollToRow(at: topRow,
                                   at: .top,
                                   animated: false)
    }
    func editcollectionView(editAction: Bool, index: Int, didTappedIncollectionViewcell: Int, financeTypeSelected:String,financeAmount:String) {
        
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        
        finaceProviderEntryView.isHidden=false
        scrollToTop()
        //        if index==0{
        //        financeProviderEntryviewHeight.constant=320+(120*2)
        //        }else if index==1{
        //        financeProviderEntryviewHeight.constant=320+(120*3)
        //        }else{
        //        financeProviderEntryviewHeight.constant=320+(120*4)
        //        }
//        if financeTypeSelected=="Wells Fargo"{
//            financeProviderEntryviewHeight.constant=320+(120*2)
//        }else if financeTypeSelected=="GreenSky"{
//            financeProviderEntryviewHeight.constant=320+(120*3)
//        }else{
//            financeProviderEntryviewHeight.constant=320+(120*4)
//        }
        
        
        
        
       // editTappedIndex=nofinanceModel.DepositFinanceProviderArray.firstIndex(where: { $0.financeServiceProviderName == financeTypeSelected}) ?? 0
        editTappedIndex=index
        requiredFieldsArray=nofinanceModel.DepositFinanceProviderArray[editTappedIndex].requiredFields ?? []
        
        
        
        if CGFloat(320+(requiredFieldsArray.count*120))>=screenHeight{
            financeProviderEntryviewHeight.constant=screenHeight-100
        }else{
            financeProviderEntryviewHeight.constant=CGFloat(320+(requiredFieldsArray.count*120))
        }
        financePlanArray.removeAll()
        financePlanIdArray.removeAll()
        if nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlans?.count ?? 0>0{
            for i in 0...(nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlans?.count ?? 0)-1{
                financePlanArray.append(nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlans?[i].name ?? "")
                financePlanIdArray.append(nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlans?[i].id ?? 0)
                
            }
        }
        financeType_Selected=financeTypeSelected
        // if editTappedIndex==0{
        financeTypeLbl.text=financeType_Selected
        //        }else{
        //            financeTypeLbl.text=financeType_Selected
        //        }
        finance_Amount=financeAmount
        blurView.isHidden=false
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        self.view.addSubview(finaceProviderEntryView)
        financeProviderDetailstableView.reloadData()
        
    }
    
    @IBAction func financeProviderentryCancelAction(_ sender: Any) {
        blurView.isHidden=true
        finaceProviderEntryView.isHidden=true
    }
    
    @IBAction func financeProviderEntryNextBtnAction(_ sender: Any) {
        var isEmpty=false
        var Amounteneterd=Double()
        var creditEnetred=Double()
        for i in 0...requiredFieldsArray.count-1{
            if requiredFieldsArray[i].valueEntered==""{
                isEmpty=true
            }
            if requiredFieldsArray[i].name=="Amount"{
                Amounteneterd=(requiredFieldsArray[i].valueEntered as! NSString).doubleValue
            }
            if requiredFieldsArray[i].name=="Credit Limit"{
                creditEnetred=(requiredFieldsArray[i].valueEntered as! NSString).doubleValue
            }
           
        }
       
        
        if financePlanArray.count>0{
            if nofinanceModel.DepositFinanceProviderArray[editTappedIndex].financePlanselected==""{
                isEmpty=true
            }
        }
        
        if isEmpty==true{
            self.showAlertOk(message: "Please complete all fields to continue")
            
//        }else if Amounteneterd>creditEnetred {
//                self.showAlertOk(message: "Amount should not be higher than Credit Limit")
            }else{
                blurView.isHidden=true
                finaceProviderEntryView.isHidden=true
                var text=String()
                //        if financeType_Selected=="Wells Fargo"{
                //            text=financeDetailEntryCell.amountTxtFld.text ?? ""
                //        }else if financeType_Selected=="GreenSky"{
                //            text=finaceEntryExpirationCell.AmntTxtfld.text ?? ""
                //        }else{
                //            text=finaceEntryExpirationCell.AmntTxtfld.text ?? ""
                //        }
                for i in 0...requiredFieldsArray.count-1{
                    if requiredFieldsArray[i].name=="Amount"{
                        text=requiredFieldsArray[i].valueEntered
                    }
                }
               
                print("text",text)
                
                depositAmount=0.00
                
                if nofinanceModel.cardCheckDetailArray.count==0{
                    depositAmount=0.00
                }else{
                    
                    for i  in 0...nofinanceModel.cardCheckDetailArray.count-1{
                        let amount1=(nofinanceModel.cardCheckDetailArray[i]["amount"] as? String)?.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                    }
                }
                
                if nofinanceModel.DepositFinanceProviderArray.count==0{
                    depositAmount=0.00
                }else{
                    for i  in 0...nofinanceModel.DepositFinanceProviderArray.count-1{
                        print("editTappedIndex",editTappedIndex)
                        if i==editTappedIndex{
                            
                            nofinanceModel.DepositFinanceProviderArray[i].requiredFields=requiredFieldsArray
                            print("nofinanceModel.DepositFinanceProviderArray",nofinanceModel.DepositFinanceProviderArray)
                            if nofinanceModel.DepositFinanceProviderArray[i].price==""{
                                
                                let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                                let amount2=Double(amount1) ?? 0.0
                                depositAmount+=amount2
                                if depositAmount<=actual_SaleAmount{
                                    nofinanceModel.DepositFinanceProviderArray[i].price=text.numberFormatter(amount: text)
                                }else{
                                    self.showAlertOk(message: "The deposit amount should not be higher than overstock price")
                                }
                                print("nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price1111",nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price)
                            }else{
                                //nofinanceModel.DepositFinanceProviderArray[i].price=""
                                let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                                let amount2=Double(amount1) ?? 0.0
                                depositAmount+=amount2
                                if depositAmount<=actual_SaleAmount{
                                    nofinanceModel.DepositFinanceProviderArray[i].price=amount1.numberFormatter(amount: amount1)
                                }else{
                                    self.showAlertOk(message: "The deposit amount should not be higher than overstock price")
                                }
                                
                            }
                            print("nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price222",nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price)
                        }else{
                            let amount1=nofinanceModel.DepositFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                            let amount2=Double(amount1) ?? 0.0
                            depositAmount+=amount2
                            print("nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price333",nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price)
                            //                        if depositAmount<=8000.00{
                            //                            nofinanceModel.DepositFinanceProviderArray[i].price=text.numberFormatter(amount: text)
                            //                        }else{
                            //                            self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
                            //                        }
                        }
                        //                        let amount1=nofinanceModel.DepositFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                        //                        let amount2=Double(amount1) ?? 0.0
                        //                        depositAmount+=amount2
                        
                        
                    }
                }
                //        let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                //        let amount2=Double(amount1) ?? 0.0
                //        if depositAmount>8000.00{
                //            self.showAlertOk(message: "The deposit amount should not be higher than  overstock price")
                //        }else{
                //            nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price=text.numberFormatter(amount: text)
                //        }
                // amountEnteredArray.insert(text.numberFormatter(amount: text), at: editTappedIndex)
                print("nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price",nofinanceModel.DepositFinanceProviderArray[editTappedIndex].price)
                projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
                financeOptionTableView.reloadData()
            }
        }
    
    
    func deleteCollectionView(deleteAction: Bool, index: Int, didTappedIncollectionViewcell: Int) {
        print(financeProvidersSelectedArray)
        //financeProvidersSelectedArray.remove(at: index)
        nofinanceModel.DepositFinanceProviderArray.remove(at: index)
        //financeDetailcell.fianceproviderForCollectionViewArray=financeProvidersSelectedArray
        financeDetailcell.fianceproviderForCollectionViewArray=nofinanceModel.DepositFinanceProviderArray
        if financeDetailcell.fianceproviderForCollectionViewArray.count==0{
            nofinanceModel.financeSelected=0
            
        }
        projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
        financeDetailcell.financeTypeCollectionView.reloadData()
        financeOptionTableView.reloadData()
        
    }
    
    @IBAction func nextBtnaction(_ sender: Any) {
        // let financeSummary = Finance_summaryViewController.initialization()!
        //        if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
        //
        //
        //        } else{
        //
        //
        //            if nofinanceModel.cardCheckDetailArray.count==0{
        //            }else{
        //                depositAmount=0.00
        //                    for i  in 0...nofinanceModel.cardCheckDetailArray.count-1{
        ////
        //                        let amount1=nofinanceModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
        //                        let amount2=Double(amount1) ?? 0.0
        //                        depositAmount+=amount2
        //                    }
        //                }
        //            if nofinanceModel.DepositFinanceProviderArray.count==0{
        //            }else{
        //                depositAmount=0.00
        //                    for i  in 0...nofinanceModel.DepositFinanceProviderArray.count-1{
        //                        let amount1=nofinanceModel.DepositFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
        //                        let amount2=Double(amount1) ?? 0.0
        //                        depositAmount+=amount2
        //
        //                    }
        //                }
        
        
        projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=nofinanceModel.cardCheckDetailArray
    
   
        projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
        if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0{
            depositAmount=0.0
        }
        var isEmpty=false
        if nofinanceModel.DepositFinanceProviderArray.count>0{
            for i in 0...nofinanceModel.DepositFinanceProviderArray.count-1{
                var requiredfield=nofinanceModel.DepositFinanceProviderArray[i].requiredFields
                for j in 0...(requiredfield?.count ?? 0)-1{
                    if requiredfield?[j].valueEntered==""{
                        isEmpty=true
                    }
                }
            }
        }
        
        if isEmpty==true{
            self.showAlertOk(message: "Please enter finance provider details to continue.")
            
        }else{
            let balanceAmount=(String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount)))
            
            projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
            if balanceAmount=="0.00"{
                let financeSummary = Finance_summaryViewController.initialization()!
                financeSummary.depositAmount=(String(depositAmount).numberFormatter(amount: String(depositAmount)))
                financeSummary.actual_SaleAmount=actual_SaleAmount
                balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
                balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
                balanceNoFinanceSelectedModel.cardCheckArrayDict=[:]
                self.navigationController?.pushViewController(financeSummary, animated: true)
            }else if (actual_SaleAmount-depositAmount)<0{
                self.showAlertOk(message: "The deposit amount should not be higher than overstock price")
            } else{
                
                
                let balancePayment = BalancePaymentOptionViewController.initialization()!
                //            if  balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
                balanceNoFinanceSelectedModel.cardCheckDetailArray=nofinanceModel.cardCheckDetailArray
                balancePayment.depositAmount=depositAmount
                balancePayment.depositAmountSummary=(String(depositAmount).numberFormatter(amount: String(depositAmount)))
                balancePayment.balanceAmnt=(String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount)))
                //            }else{
                //                for i in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                //                    print(balanceNoFinanceSelectedModel.cardCheckDetailArray[i])
                //                    for j in 0...nofinanceModel.cardCheckDetailArray.count-1{
                //                        if balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["creditCardNumber"]==nofinanceModel.cardCheckDetailArray[j]["creditCardNumber"]{
                //
                //                        }else{
                //                            balanceNoFinanceSelectedModel.cardCheckDetailArray.append(nofinanceModel.cardCheckDetailArray[j])
                //
                //                        }
                //                    }
                //                }
                //            }
                
                
                
                
                
                balancePayment.financeSelected=nofinanceModel.financeSelected
                
                // First case when finance option details has to be passed to balance
                
                //            if balanceNoFinanceSelectedModel.cardCheckDetailArray.count>0{
                //                for i in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                //                    balanceNoFinanceSelectedModel.cardCheckDetailArray[i].updateValue("", forKey: "amount")
                //                }
                //            }
                //
                //            //            if  balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
                //            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
                //
                //            if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count>0{
                //                for i in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
                //                    balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price=""
                //                    for j in 0...(balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].requiredFields?.count ?? 0)-1{
                //                        if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].requiredFields?[j].name=="Amount"{
                //                            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].requiredFields?[j].valueEntered=""
                //                        }
                //                    }
                //                }
                //
                //            }
                balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
                balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
                balanceNoFinanceSelectedModel.cardCheckArrayDict=[:]
                //            }
                balancePayment.actualSaleAmount=actual_SaleAmount
                
                self.navigationController?.pushViewController(balancePayment, animated: true)
            }
        }
    }
    
    func editCardcollectionView(editCardAction: Bool, index: Int, didTappedIncollectionViewcell: Int, nofinanceTypeSelected: [String : Any], isFromBalanceVc: Bool) {
        let Depositpayment = DepositPaymentMethodViewController.initialization()!
        Depositpayment.editDict=nofinanceTypeSelected
        Depositpayment.editcardAction=editCardAction
        Depositpayment.editedIndex=index
        Depositpayment.ACHFieldArray=noFinanceACHRequiredFieldsArray
        Depositpayment.isFromBalancePaymentVC=isFromBalanceVc
        Depositpayment.actualSaleAmount=actual_SaleAmount
        Depositpayment.balance_Amount=balanceAmount
        Depositpayment.Balance_Amount=String(actual_SaleAmount-depositAmount).numberFormatter(amount: String(actual_SaleAmount-depositAmount))
        self.navigationController?.pushViewController(Depositpayment, animated: true)
    }
    
    func deleteCardCollectionView(deleteAction: Bool, index: Int, didTappedIncollectionViewcell: Int,isFromBalanceVc: Bool) {
        nofinanceModel.cardCheckDetailArray.remove(at: index)
        projects[projectSelectIndex].nofinanceModelcardCheckDetailArray =  nofinanceModel.cardCheckDetailArray
        financeDetailcell.financeTypeCollectionView.reloadData()
        financeOptionTableView.reloadData()
    }
    
    
    //
}

