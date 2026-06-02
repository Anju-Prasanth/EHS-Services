//
//  BalancePaymentOptionViewController.swift
//  Express Home
//
//  Created by Anju on 31.05.2023.
//

import UIKit

var balanceNoFinanceSelectedModel=BalanceNoFinanceSelectedModel()
class BalancePaymentOptionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CollectionViewCellDelegate,UITextFieldDelegate{
    

    
    
    static func initialization() -> BalancePaymentOptionViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "BalancePaymentOptionViewController") as? BalancePaymentOptionViewController
    }
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var dropDownAnchorView: UIView!
    @IBOutlet weak var balancepaymentTableView: UITableView!
    
    @IBOutlet weak var financeTypeLbl: UILabel!
    @IBOutlet weak var financeProviderEntryviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var financeProviderDetailstableView: UITableView!
    @IBOutlet weak var financeProviderNameLbl: UILabel!
    @IBOutlet weak var finaceProviderEntryView: UIView!
    @IBOutlet weak var financeserviceProviderListTableView: UITableView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    var financeSelected=0
    var balanceAmnt=""
    var navView = UIView()
    var navViewBottomLine = UIView()
    var financeDetailcell=FinanceDetailsTableViewCell()
    var selectedIndexFinanceProvidersArray=[Int]()
    var financeProviderNameArray=[FinanceProvider]()
    var financeProvidersSelectedArray=[FinanceProvider]()
    var amountEnteredArray=["",""]
    var editTappedIndex=Int()
    var financeDetailEntryCell=FinanceDetailsEntryTableViewCell()
    var financeServiceProviderCell=FinanceServiceProviderTableViewCell()
    var financeProviderViewModel=FinanceProviderViewModel()
    var finance_Selected=String()
    var isFromBalanceVC=Bool()
    var finaceEntryExpirationCell=FinanceEntryExpirationTableViewCell()
    var financeType_Selected=String()
    var finance_Amount=String()
    var depositAmount=0.00
    var noFinanceArray=[FinanceProvider]()
    var balancenoFinanceACHRequiredFieldsArray=[RequiredFields]()
    var requiredFieldsArray=[RequiredFields]()
    var depositAmountSummary=""
    var financePlanArray=[String]()
    var financePlanIdArray=[Int]()
    var actualSaleAmount=Double()
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
        balancepaymentTableView.register(UINib(nibName: "SelectPaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectPaymentTableViewCell")
        balancepaymentTableView.register(UINib(nibName: "FinanceDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceDetailsTableViewCell")
        balancepaymentTableView.register(UINib(nibName: "FinanceAmountTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceAmountTableViewCell")
        financeserviceProviderListTableView.register(UINib(nibName: "FinanceServiceProviderTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceServiceProviderTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceDetailsEntryTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceDetailsEntryTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceEntryDrivingLicenseTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceEntryDrivingLicenseTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceEntryExpirationTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceEntryExpirationTableViewCell")
        financeProviderDetailstableView.register(UINib(nibName: "FinanceDetailEntryHeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceDetailEntryHeadingTableViewCell")

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
       print("refreshtoken")
        if let dict = notification.userInfo as NSDictionary? {
            print("refreshtokendict")
            if let token = dict["token"] as? Int{
                print("refreshtokentoken")
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
   
    // MARK: func to get finna

 func financeProviders(data: [FinanceProvider]) {
    print("data",data)
     financeProviderNameArray=data
     let noFinanceACHArray=data.filter({ $0.financeServiceProviderName == "ACH" })
     balancenoFinanceACHRequiredFieldsArray=noFinanceACHArray[0].requiredFields ?? []
     
     noFinanceArray=data.filter({ $0.financePaymentTypeId == 2 || $0.financePaymentTypeId == 3})
     financeProviderNameArray=data.filter({ $0.financePaymentTypeId == 1 })
     if financeProviderNameArray.count>0{
         financeProviderNameArray[0].isSelected=1
     }
     financeserviceProviderListTableView.reloadData()
    
}

override func viewWillAppear(_ animated: Bool){
//    if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0&&balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
//    refreshMSALToken()
//    nextBtn.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
//    nextBtn.isUserInteractionEnabled=false
//    }else{
//        nextBtn.backgroundColor=UIColor().colorFromHexString("#304CCE")
//
//    }
    
    setnavBarView()
    balancepaymentTableView.reloadData()
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
   
    setNavigationBarbacklogoNameForFinance(name: "Balance Payment Option",superview: navView)
}
//     override func performSegueToReturnBack(){
//            let financeOptions = FinanceOptionsViewController.initialization()!
//
//            self.navigationController?.pushViewController(financeOptions, animated: true)
//        }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
           if tableView==balancepaymentTableView{
               if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0&&balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0&&balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
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
//    if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0&&balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
//
//    nextBtn.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
//}else{
    nextBtn.backgroundColor=UIColor().colorFromHexString("#304CCE")
//}
    if tableView==balancepaymentTableView{
        if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0&&balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0&&balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
            
     return 1
    }else{
    return 2
    }
    }else if tableView==financeserviceProviderListTableView{
        return financeProviderNameArray.count
    }else{
//        if financeType_Selected=="Wells Fargo"{
//        return 2
//        }else if financeType_Selected=="GreenSky"{
//        return 3
//        }else{
//            return 4
//        }
        
        
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
        
        
        
        
        
    }
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var balanceAmount=Double()
        balanceAmount=0.0
        if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count>0{
            for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
                let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                balanceAmount+=amount2
                
            }
        }
        if balanceNoFinanceSelectedModel.cardCheckDetailArray.count>0{
            for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                let amount1=balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                balanceAmount+=amount2
                
            }
            
        }
        
//        if String(balanceAmount).numberFormatter(amount: String(balanceAmount))==balanceAmnt{
//            nextBtn.backgroundColor=UIColor().colorFromHexString("#304CCE")
//            nextBtn.isUserInteractionEnabled=true
//        }else{
//            nextBtn.backgroundColor=UIColor().colorFromHexString("#E9EBEF")
//            nextBtn.isUserInteractionEnabled=false
//        }
        
        if tableView==balancepaymentTableView{
            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0&&balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0&&balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    cell.checkBtn.addTarget(self, action: #selector(checkBtnActiom(sender: )), for: .touchUpInside)
                    cell.creditCardBtn.addTarget(self, action: #selector(creditCardBtnAction(sender: )), for: .touchUpInside)
                    cell.financeBtn.addTarget(self, action: #selector(financeBtnAction(sender: )), for: .touchUpInside)
                    // cell.financeOptionLbl.text=finance_Selected
                    cell.dashedViewHeightConstraint.constant=125
                    cell.newoverstockPriceLblTopConstraint.constant=46
                    cell.newoverstockpriceLbl.text="Balance Amount"
                    cell.priceLbl.text="$ "+balanceAmnt
                    cell.inclusiveallTaxesView.isHidden=true
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
                    
                    //            }else{
                    //                cell.creditCardView.borderColor=UIColor().colorFromHexString("#CBCCD5")
                    //                cell.checkView.borderColor=UIColor().colorFromHexString("#304CCE")
                    //                cell.noFinanceImageView.image=UIImage(named: "unSelected")
                    //                cell.financeImageView.image=UIImage(named: "selected")
                    //                cell.creditCardView.backgroundColor=UIColor().colorFromHexString("#F2F3F5")
                    //                cell.checkView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    //                cell.creditCardView.borderWidth=1
                    //                cell.checkView.borderWidth=2
                    return cell
                    //    case 1:
                    //        financeDetailcell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsTableViewCell") as! FinanceDetailsTableViewCell
                    //        financeDetailcell.finance_nofinanceLbl.text="FINANCE DETAILS"
                    //        financeDetailcell.collectionviewCellUnhideBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
                    //        financeDetailcell.finance_selected=financeSelected
                    //        financeDetailcell.isFromBalanceVc=true
                    //        financeDetailcell.fianceproviderForCollectionViewArray=financeProvidersSelectedArray
                    ////        if financeProvidersSelectedArray.count==0{
                    //            financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
                    //            financeDetailcell.addBtnViewIncollectionView.isHidden=true
                    //            financeDetailcell.financeTypeCollectionView.isHidden=false
                    //            financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
                    ////        }else{
                    ////            financeDetailcell.financeTypeCollectionView.isHidden=false
                    ////            financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
                    ////            financeDetailcell.addBtnViewIncollectionView.isHidden=false
                    ////            financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
                    ////        }
                    //        financeDetailcell.addInsidecolletionViewBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
                    //
                    //        financeDetailcell.cellDelegate=self
                    //        financeDetailcell.amountEnteredLblArray=amountEnteredArray
                    //        financeDetailcell.editActionTappedIndex=editTappedIndex
                    //       // financeDetailcell.addBtninsideCollectionViewWidthConstarint.constant=CGFloat(financeProvidersSelectedArray.count*400)+10
                    //        financeDetailcell.financeTypeCollectionView.reloadData()
                    //        return financeDetailcell
                    
                    
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    
                    return cell
                }
            }else{
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell") as! SelectPaymentTableViewCell
                    cell.selectpaymentOptionLbl.text="SELECT A BALANCE PAYMENT OPTION"
                    cell.checkBtn.addTarget(self, action: #selector(checkBtnActiom(sender: )), for: .touchUpInside)
                    cell.creditCardBtn.addTarget(self, action: #selector(creditCardBtnAction(sender: )), for: .touchUpInside)
                    cell.financeBtn.addTarget(self, action: #selector(financeBtnAction(sender: )), for: .touchUpInside)
                    cell.creditCardView.borderWidth=1
                    //cell.financeOptionLbl.text="Inclusive of all taxes"
                    cell.dashedViewHeightConstraint.constant=125
                    cell.newoverstockPriceLblTopConstraint.constant=46
                    cell.newoverstockpriceLbl.text="Balance Amount"
                    cell.priceLbl.text="$ "+balanceAmnt
                    cell.inclusiveallTaxesView.isHidden=true
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
                    
                    //            }else{
                    //                cell.creditCardView.borderColor=UIColor().colorFromHexString("#CBCCD5")
                    //                cell.checkView.borderColor=UIColor().colorFromHexString("#304CCE")
                    //                cell.noFinanceImageView.image=UIImage(named: "unSelected")
                    //                cell.financeImageView.image=UIImage(named: "selected")
                    //                cell.creditCardView.backgroundColor=UIColor().colorFromHexString("#F2F3F5")
                    //                cell.checkView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
                    //                cell.creditCardView.borderWidth=1
                    //                cell.checkView.borderWidth=2
                    return cell
                case 1:
                    financeDetailcell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsTableViewCell") as! FinanceDetailsTableViewCell
                    //                    if financeSelected==1{
                    //                        financeDetailcell.financenofinanceheightConstraint.constant=40
                    //                        financeDetailcell.finance_nofinanceLbl.text="FINANCE DETAILS"
                    //                    }else{
                    financeDetailcell.financenofinanceheightConstraint.constant=0
                    
                    //                    }
                    // financeDetailcell.finance_nofinanceLbl.text="NO FINANCE PAYMENT OPTION"
                    financeDetailcell.collectionviewCellUnhideBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
                    financeDetailcell.finance_selected=financeSelected
                    
                    financeDetailcell.fianceproviderForCollectionViewArray=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray
                    //                if financeProvidersSelectedArray.count==0{
                    financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
                    financeDetailcell.addBtnViewIncollectionView.isHidden=true
                    financeDetailcell.financeTypeCollectionView.isHidden=false
                    financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
                    //                }else{
                    //                    financeDetailcell.financeTypeCollectionView.isHidden=false
                    //                    financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
                    //                    financeDetailcell.addBtnViewIncollectionView.isHidden=false
                    //                    financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
                    //                }
                    financeDetailcell.addInsidecolletionViewBtn.addTarget(self, action: #selector(collectionviewUnhideAction(sender: )), for: .touchUpInside)
                    //
                    financeDetailcell.cellDelegate=self
                    //                financeDetailcell.amountEnteredLblArray=amountEnteredArray
                    //                financeDetailcell.editActionTappedIndex=editTappedIndex
                    //            if balanceNoFinanceSelectedModel.cardCheckDetailArray.count>0{
                    //            financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
                    //            financeDetailcell.financeTypeCollectionView.isHidden=false
                    //            financeDetailcell.addBtnViewoutsidecollectionView.isHidden=true
                    //            financeDetailcell.addBtnViewIncollectionView.isHidden=false
                    //            }
                    
                    financeDetailcell.isFromBalanceVc=true
                    financeDetailcell.financeTypeCollectionView.reloadData()
                    return financeDetailcell
                    
                    
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
                if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
                    
                }else{
                    
                    for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                        //
                        let amount1=(balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"] as? String)?.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                    }
                }
                if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
                }else{
                    // depositAmount=0.00
                    for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
                        let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                        
                    }
                }
                FinanceDetailEntryHeadingTableViewCell.balanceAmountLbl.text="$ "+String(actualSaleAmount-depositAmount).numberFormatter(amount: String(actualSaleAmount-depositAmount))
                return FinanceDetailEntryHeadingTableViewCell
            } else if indexPath.section==2{
                let financeDetailexpiryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
                
                financeDetailexpiryCell.dropDown.anchorView = financeDetailexpiryCell.dropdownAnchorView
                financeDetailexpiryCell.headingLbl.text="Finance Plan"
                financeDetailexpiryCell.dropDown.dataSource=financePlanArray
                //if financeProviderNameArray[editTappedIndex].financePlanselected==""{
                if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlanselected==""{
                    financeDetailexpiryCell.drorDownBtn.setTitle("Finance Plan", for: .normal)
                    financeDetailexpiryCell.drorDownBtn.setTitleColor(.lightGray, for: .normal)
                }else{
                    financeDetailexpiryCell.drorDownBtn.setTitle(balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlanselected, for: .normal)
                    financeDetailexpiryCell.drorDownBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
                }
                
                financeDetailexpiryCell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    financeDetailexpiryCell.drorDownBtn.setTitle(item, for: .normal)
                    financeDetailexpiryCell.drorDownBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
                    balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlanselected=item
                    balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlanIdSelected=financePlanIdArray[index]
                    
                    
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
                } else if requiredFieldsArray[indexPath.row].name=="Drivers License Expiration Date"{
                        finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
                        finaceEntryExpirationCell.AmntTxtfld.delegate=self
                        finaceEntryExpirationCell.AmntTxtfld.tag=requiredFieldsArray[indexPath.row].id ?? 0
                        finaceEntryExpirationCell.headingLbl.text="Drivers License Expiration Date"
                        finaceEntryExpirationCell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnActions(sender: )), for: .touchUpInside)
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
                    financeDetailEntryCell.amountTxtFld.tag=requiredFieldsArray[indexPath.row].id ?? 0
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
            
            
    @IBAction func datepickerValueChanged(_ sender: UIDatePicker) {
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
    
            
    
//        }else{
//            if financeType_Selected=="Wells Fargo"{
//                financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//                if indexPath.row==0{
//                    financeDetailEntryCell.headingLbl.text="App ID*"
//                    financeDetailEntryCell.amountTxtFld.text="GS950036"
//                    financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                    financeDetailEntryCell.amountLblTrailing.constant=20
//                }else{
//                    financeDetailEntryCell.headingLbl.text="Amount*"
//                    financeDetailEntryCell.amountTxtFld.text=finance_Amount
//                    financeDetailEntryCell.placeholderTextLbl.isHidden=false
//                    financeDetailEntryCell.amountLblTrailing.constant=45
//
//
//                }
//
//                return financeDetailEntryCell
//            }else  if financeType_Selected=="GreenSky"{
//                if indexPath.row==0{
//                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//
//                    financeDetailEntryCell.headingLbl.text="App ID*"
//                    financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                    financeDetailEntryCell.amountLblTrailing.constant=20
//                    return financeDetailEntryCell
//
//                }
////                else if indexPath.row==3{
////                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
////                    financeDetailEntryCell.headingLbl.text="Amount*"
////                    financeDetailEntryCell.placeholderTextLbl.isHidden=false
////                    financeDetailEntryCell.amountLblTrailing.constant=45
////                    return financeDetailEntryCell
////                }
//                else if indexPath.row==1{
//                     finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
//                    finaceEntryExpirationCell.headingLbl.text="Amount*"
//                    finaceEntryExpirationCell.AmntTxtfld.text=finance_Amount
//                    //cell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnAction(sender: )), for: .touchUpInside)
//                    return finaceEntryExpirationCell
//
//                }else{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
//                    cell.dropDown.anchorView=cell.dropdownAnchorView
//
//                    return cell
//                }
//
//
//            }else{
//                if indexPath.row==0{
//                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//
//                    financeDetailEntryCell.headingLbl.text="Account Number*"
//                    financeDetailEntryCell.amountTxtFld.text="800069988653"
//                    financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                    financeDetailEntryCell.amountLblTrailing.constant=20
//                    return financeDetailEntryCell
//
//                }
//                //                else if indexPath.row==2{
//                //                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//                //                    financeDetailEntryCell.headingLbl.text="Max Credit Limit*"
//                //                    financeDetailEntryCell.placeholderTextLbl.isHidden=false
//                //                    financeDetailEntryCell.amountLblTrailing.constant=45
//                //                    return financeDetailEntryCell
//                //                }
//                else if indexPath.row==2{
//                     finaceEntryExpirationCell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryExpirationTableViewCell") as! FinanceEntryExpirationTableViewCell
//                    finaceEntryExpirationCell.headingLbl.text="Max Credit Limit*"
//                    finaceEntryExpirationCell.AmntTxtfld.text=finance_Amount
//                    //cell.datePickerBtn.addTarget(self, action: #selector(datePickerBtnAction(sender: )), for: .touchUpInside)
//                    return finaceEntryExpirationCell
//                }else if indexPath.row==1{
//                    financeDetailEntryCell = tableView.dequeueReusableCell(withIdentifier: "FinanceDetailsEntryTableViewCell") as! FinanceDetailsEntryTableViewCell
//
//                    financeDetailEntryCell.headingLbl.text="Authorization Number*"
//                    financeDetailEntryCell.amountTxtFld.text="800069988653"
//                    financeDetailEntryCell.placeholderTextLbl.isHidden=true
//                    financeDetailEntryCell.amountLblTrailing.constant=20
//                    return financeDetailEntryCell
//                }else{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceEntryDrivingLicenseTableViewCell") as! FinanceEntryDrivingLicenseTableViewCell
//                    cell.dropDown.anchorView=cell.dropdownAnchorView
//                    return cell
//                }
//
//            }
//        }
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView==balancepaymentTableView{
            
            if nofinanceModel.cardCheckDetailArray.count==0&&nofinanceModel.DepositFinanceProviderArray.count==0&&balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0&&balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
                switch indexPath.row {
                    
                case 0:
                    return 300
                    
//                case 1:
//                    
//                    return 170
                    
                default:
                    
                    return 300
                }
                
            
            
        }else{
            switch indexPath.row {
            case 0:
                
                return 300
            case 1:
                
                return 300
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
//        if financeType_Selected=="Wells Fargo"{
//        return 120
//        }else if financeType_Selected=="GreenSky"{
//            return 120
//        }else{
//            return 120
//        }
    }
}
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            print(textField.tag)
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            for i in 0...requiredFieldsArray.count-1{
                if textField.tag==requiredFieldsArray[i].id{
                    requiredFieldsArray[i].valueEntered=newString
                }
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
        
        
    @objc func datePickerBtnActions(sender:UIButton){
        
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
                selectedIndexFinanceProvidersArray[i]=0
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
        if financeSelected==0{
            
            let Depositpayment = DepositPaymentMethodViewController.initialization()!
              Depositpayment.isFromBalancePaymentVC=true
            
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
    financeSelected=0
    
    let Depositpayment = DepositPaymentMethodViewController.initialization()!
    Depositpayment.cardSelected=1
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
    if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
        
    }else{
        
        for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
            //
            let amount1=(balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"] as? String)?.replacingOccurrences(of: ",", with: "") ?? ""
            let amount2=Double(amount1) ?? 0.0
            depositAmount+=amount2
        }
    }
    if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
    }else{
        // depositAmount=0.00
        for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
            let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
            let amount2=Double(amount1) ?? 0.0
            depositAmount+=amount2
            
        }
    }
    
    Depositpayment.Balance_Amount=String(actualSaleAmount-depositAmount).numberFormatter(amount: String(actualSaleAmount-depositAmount))
    Depositpayment.balance_Amount=balanceAmnt
    Depositpayment.ACHFieldArray=balancenoFinanceACHRequiredFieldsArray
    Depositpayment.isFromBalancePaymentVC=true
    self.navigationController?.pushViewController(Depositpayment, animated: true)
}
@objc func creditCardBtnAction(sender:UIButton){
    blurView.isHidden=true
    financeSelected=0
    let Depositpayment = DepositPaymentMethodViewController.initialization()!
    Depositpayment.cardSelected=0
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
    if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
        
    }else{
        
        for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
            //
            let amount1=(balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"] as? String)?.replacingOccurrences(of: ",", with: "") ?? ""
            let amount2=Double(amount1) ?? 0.0
            depositAmount+=amount2
        }
    }
    if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
    }else{
        // depositAmount=0.00
        for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
            let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
            let amount2=Double(amount1) ?? 0.0
            depositAmount+=amount2
            
        }
    }
    
    
    Depositpayment.Balance_Amount=String(actualSaleAmount-depositAmount).numberFormatter(amount: String(actualSaleAmount-depositAmount))
    Depositpayment.balance_Amount=balanceAmnt
    Depositpayment.isFromBalancePaymentVC=true
    let cardArray=noFinanceArray.filter({ $0.financePaymentTypeId == 2})
    if cardArray.count>0{
        for i in 0...cardArray.count-1{
            Depositpayment.cardTypeArray.append(cardArray[i].financeServiceProviderName ?? "")
            Depositpayment.cardTypeIdArray.append(cardArray[i].financeServiceProviderId ?? 0)
           
        }
        Depositpayment.cardArrayForCreditCard=cardArray
    }
    self.navigationController?.pushViewController(Depositpayment, animated: true)
}
@objc func financeBtnAction(sender:UIButton){
       financeSelected=1
        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
            .withAlphaComponent(0.7)
        popupView.isHidden=false
        blurView.isHidden=false
        self.navView.addSubview(blurView)
        self.navViewBottomLine.addSubview(blurView)
        self.view.addSubview(popupView)
        self.balancepaymentTableView.reloadData()
    }
@IBAction func financeProvidecancelBtnAction(_ sender: Any) {
    blurView.isHidden=true
    popupView.isHidden=true
}

@IBAction func financeProviderNextBtnAction(_ sender: Any) {
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
//    for i in 0...financeProviderNameArray.count-1{
//        if financeProviderNameArray[i].isSelected==1{
//            financeProvidersSelectedArray.append(financeProviderNameArray[i])
//        }
//    }
//    if financeProvidersSelectedArray.count>0{
//    financeDetailcell.collectionviewCellUnhideBtn.isHidden=true
//    }
    var  financeproviderurl=String()
    for i in 0...financeProviderNameArray.count-1{
        if financeProviderNameArray[i].isSelected==1{
            financeproviderurl=financeProviderNameArray[i].financeServiceProviderUrl ?? ""
            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.append(financeProviderNameArray[i])
           // financeProvidersSelectedArray.append(financeProviderNameArray[i])
        }
    }
    financeSelected=1
    balancepaymentTableView.reloadData()
    let financeprovider = FinanceproviderUrlViewController.initialization()!
    financeprovider.financeprovider_Url=financeproviderurl
    self.navigationController?.pushViewController(financeprovider, animated: true)
}
    func editcollectionView(editAction: Bool, index: Int, didTappedIncollectionViewcell: Int, financeTypeSelected:String,financeAmount:String) {
    blurView.backgroundColor=UIColor().colorFromHexString("#232538")
        .withAlphaComponent(0.7)
    finaceProviderEntryView.isHidden=false
//    if financeTypeSelected=="Wells Fargo"{
//    financeProviderEntryviewHeight.constant=320+(120*2)
//    }else if financeTypeSelected=="GreenSky"{
//    financeProviderEntryviewHeight.constant=320+(120*3)
//    }else{
//    financeProviderEntryviewHeight.constant=320+(120*4)
//    }
    editTappedIndex=index
    requiredFieldsArray=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].requiredFields ?? []
        
        
        if CGFloat(320+(requiredFieldsArray.count*120))>=screenHeight{
            financeProviderEntryviewHeight.constant=screenHeight-100
        }else{
            financeProviderEntryviewHeight.constant=CGFloat(320+(requiredFieldsArray.count*120))
        }
        financePlanArray.removeAll()
        financePlanIdArray.removeAll()
        if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlans?.count ?? 0>0{
            for i in 0...(balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlans?.count ?? 0)-1{
                financePlanArray.append(balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlans?[i].name ?? "")
                financePlanIdArray.append(balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlans?[i].id ?? 0)
                
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
        if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].financePlanselected==""{
            isEmpty=true
        }
    }
    
    if isEmpty==true{
        self.showAlertOk(message: "Please complete all fields to continue")
        
//    }else if Amounteneterd>creditEnetred {
//            self.showAlertOk(message: "Amount should not be higher than Credit Limit")
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
       
        depositAmount=0.00
        if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
            depositAmount=0.00
        }else{
            
            for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                //
                let amount1=balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
            }
        }
        //    if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
        //        depositAmount=0.00
        //    }else{
        //       // depositAmount=0.00
        //            for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
        //
        //
        //                if i==editTappedIndex{
        //                    if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price==""{
        //                        let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
        //                        let amount2=Double(amount1) ?? 0.0
        //                        depositAmount+=amount2
        //                    }else{
        //                        balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price=""
        //                    }
        //                }
        //
        //
        //
        //                let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
        //                let amount2=Double(amount1) ?? 0.0
        //                depositAmount+=amount2
        //
        //            }
        //        }
        
        
        
        
        if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
            // depositAmount=0.00
        }else{
            for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
                
                if i==editTappedIndex{
                    balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].requiredFields=requiredFieldsArray
                    if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price==""{
                        
                        let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                        
                        
                        let balance_Amount=balanceAmnt.replacingOccurrences(of: ",", with: "")
                        if depositAmount>(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                            self.showAlertOk(message: "The  amount should not be higher than  balance amount")
                        }else{
                            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price=text.numberFormatter(amount: text)
                            amountEnteredArray.insert(text.numberFormatter(amount: text), at: editTappedIndex)
                        }
                        
                        
                        
                    }else{
                        //nofinanceModel.DepositFinanceProviderArray[i].price=""
                        let amount1=text.replacingOccurrences(of: ",", with: "") ?? ""
                        let amount2=Double(amount1) ?? 0.0
                        depositAmount+=amount2
                        let balance_Amount=balanceAmnt.replacingOccurrences(of: ",", with: "")
                        if depositAmount>(balance_Amount as? NSString)?.doubleValue ?? 0.0{
                            self.showAlertOk(message: "The  amount should not be higher than  balance amount")
                        }else{
                            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price=text.numberFormatter(amount: text)
                            amountEnteredArray.insert(text.numberFormatter(amount: text), at: editTappedIndex)
                        }
                        
                        
                    }
                }else{
                    let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                    let amount2=Double(amount1) ?? 0.0
                    depositAmount+=amount2
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
        
        
        
        
        
        
        
        //    let amount1=text.replacingOccurrences(of: ",", with: "")
        //    let amount2=Double(amount1) ?? 0.0
        //    let balance_Amount=balanceAmnt.replacingOccurrences(of: ",", with: "")
        //    if depositAmount>(balance_Amount as? NSString)?.doubleValue ?? 0.0{
        //        self.showAlertOk(message: "The  amount should not be higher than  balance amount")
        //    }else{
        //        balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[editTappedIndex].price=text.numberFormatter(amount: text)
        //        amountEnteredArray.insert(text.numberFormatter(amount: text), at: editTappedIndex)
        //    }
        
        
        balancepaymentTableView.reloadData()
    }
}

func deleteCollectionView(deleteAction: Bool, index: Int, didTappedIncollectionViewcell: Int) {
    print(financeProvidersSelectedArray)
    balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.remove(at: index)
   // financeProvidersSelectedArray.remove(at: index)
    financeDetailcell.fianceproviderForCollectionViewArray=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray
    if financeDetailcell.fianceproviderForCollectionViewArray.count==0{
        financeSelected=0
       
    }
    balancepaymentTableView.reloadData()
    financeDetailcell.financeTypeCollectionView.reloadData()
    
}

@IBAction func nextBtnaction(_ sender: Any) {
    var balanceAmount=Double()
    balanceAmount=0.0
    if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count>0{
        for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
            let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
            let amount2=Double(amount1) ?? 0.0
            balanceAmount+=amount2
            
        }
    }
    if balanceNoFinanceSelectedModel.cardCheckDetailArray.count>0{
        for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
            let amount1=balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"]?.replacingOccurrences(of: ",", with: "") ?? ""
            let amount2=Double(amount1) ?? 0.0
            balanceAmount+=amount2
            
        }
        
    }
    
    if (String(balanceAmount).numberFormatter(amount: String(balanceAmount)) != balanceAmnt) || (balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0&&balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0){
        self.showAlertOk(message: "The sum of the deposit and balance amounts must be equivalent to the total overstock price.")

                }else{
                    let financeSummary = Finance_summaryViewController.initialization()!
                    financeSummary.actual_SaleAmount=actualSaleAmount
                    financeSummary.balanceAmount=balanceAmnt
                    financeSummary.depositAmount=depositAmountSummary
                    self.navigationController?.pushViewController(financeSummary, animated: true)
                }
            
        
}
    
    

@IBAction func nextBtnAction(_ sender: Any) {
    let depositPayment = DepositPaymentMethodViewController.initialization()!
   
    
    self.navigationController?.pushViewController(depositPayment, animated: true)
}
    
    func editCardcollectionView(editCardAction: Bool, index: Int, didTappedIncollectionViewcell: Int, nofinanceTypeSelected: [String : Any],isFromBalanceVc:Bool) {
        let Depositpayment = DepositPaymentMethodViewController.initialization()!
        Depositpayment.editDict=nofinanceTypeSelected
        Depositpayment.editcardAction=editCardAction
        Depositpayment.balance_Amount=balanceAmnt
        Depositpayment.editedIndex=index
        Depositpayment.ACHFieldArray=balancenoFinanceACHRequiredFieldsArray
        Depositpayment.isFromBalancePaymentVC=isFromBalanceVc
        Depositpayment.balance_Amount=balanceAmnt
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
        if balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0{
            
        }else{
            
            for i  in 0...balanceNoFinanceSelectedModel.cardCheckDetailArray.count-1{
                //
                let amount1=(balanceNoFinanceSelectedModel.cardCheckDetailArray[i]["amount"] as? String)?.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
            }
        }
        if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0{
        }else{
            // depositAmount=0.00
            for i  in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
                let amount1=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price.replacingOccurrences(of: ",", with: "") ?? ""
                let amount2=Double(amount1) ?? 0.0
                depositAmount+=amount2
                
            }
        }
        Depositpayment.Balance_Amount=String(actualSaleAmount-depositAmount).numberFormatter(amount: String(actualSaleAmount-depositAmount))
        self.navigationController?.pushViewController(Depositpayment, animated: true)
    }
    
    func deleteCardCollectionView(deleteAction: Bool, index: Int, didTappedIncollectionViewcell: Int,isFromBalanceVc: Bool) {
        balanceNoFinanceSelectedModel.cardCheckDetailArray.remove(at: index)
        financeDetailcell.financeTypeCollectionView.reloadData()
        balancepaymentTableView.reloadData()
    }
    
}


    

