//
//  OffersViewController.swift
//  EHS_Sales
//
//  Created by Anju on 28.04.2023.
//

import UIKit
import MSAL


class OffersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,VoucherDelegate, ReadMoreDismissprotocol, CustomAlertDismissProtocol {
    func backToPresentingClassFromoverstockPopupForMax() {
        
    }
    
    
    
    func backToPresentingClassFromOffersPopup(DollarAmount: String) {
        let priceDetails = PriceDetailsViewController.initialization()!
        offerapplied=true
        priceDetails.isOfferApplied=offerapplied
        priceDetails.promocodesAdded=promoCell.promocodeArrayForCollectionView
        voucherAddedArray.removeAll()
        for i in 0...promoCell.voucherArray.count-1{
           // if promoCell.voucherArray[i].price==""{
            if promoCell.voucherArray[i].isSelected==0{
                
            }else{
                voucherAddedArray.append(promoCell.voucherArray[i])
            }
        }
        priceDetails.voucherAdded=voucherAddedArray
        priceDetails.voucherFullArray=promoCell.voucherArray
        priceDetails.promoNameArray=promoArray
        if promoCell.promocodeArrayForCollectionView.count>0{
            priceDetails.discountDollars=self.discountDollarText
            // priceDetails.discountpercent=self.discountPercentText
        }else{
            priceDetails.discountDollars=""
            // priceDetails.discountpercent=""
        }
        projects[projectSelectIndex].discountDollars=priceDetails.discountDollars
        projects[projectSelectIndex].promoArray=priceDetails.promocodesAdded
        projects[projectSelectIndex].voucherArray=promoCell.voucherArray
        projects[projectSelectIndex].isOfferApplied=offerapplied
        projects[projectSelectIndex].promofullArray=promoArray
        projects[projectSelectIndex].promoAddedFullArray=promoAddedFullArray
        self.navigationController?.pushViewController(priceDetails, animated: true)
    }
    
    func backToPresentingClass(status: Int, isInternalNote: Bool) {
        
    }
    
    func backToPresentingClassFromoverstockPopup(status: Int, customprice: String) {
        
    }
    
    func promocodesdeleteAction(promoAddedFullArray: [PromotionalCodes],promArrayCollectionView:[String]) {
        self.promoAddedFullArray=promoAddedFullArray
        promoCell.promoAddedFullArray=promoAddedFullArray
        promoCell.promocodeArrayForCollectionView=promArrayCollectionView
        OfferAppliedpromocodeArrayForCollectionView=promArrayCollectionView
        
        if self.promoAddedFullArray.count>0{
            
        }else{
            promoCell.discountDollarTxtFld.text = "0"
            discountDollarText="0"
        }
        DispatchQueue.main.async{
            self.promoCell.collectionviewPromocodes.reloadData()
            self.promoOffersTableView.reloadData()
        }
    }
    
    func backToPresentingClassAddtax(taxRate: Double) {
       
    }
    
    
    
    
    
    
    
    static func initialization() -> OffersViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "OffersViewController") as? OffersViewController
    }
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var txtfldVoucherPrice: UITextField!
    
    @IBOutlet weak var promoOffersTableView: UITableView!
    
    @IBOutlet weak var voucherselectedLbl: UILabel!
    @IBOutlet weak var popupView: UIView!
    var navView = UIView()
    var navViewBottomLine = UIView()
    // var promoArray=["SALE50","FIFTY FIFTY"]
    var promoArray=[String]()
    var promoCell=PromoTableViewCell()
    var discountDollarText=String()
    var discountPercentText=String()
    var voucherselectedIndex=Int()
    var promoViewmodel=PromotionalofferViewModel()
    var voucherAddedArray=[PromoOffers]()
    var promoFullArray=[PromotionalCodes]()
    var promoindex=0
    var offerapplied=false
    var voucherArray=[PromoOffers]()
    var  OfferAppliedpromocodeArrayForCollectionView=[String]()
    var discountMaximum=Double()
    var projectSelectIndex=Int()
    var retailPice=Double()
    var promoOffersIdArray=[Int]()
    var promoCodeIdArray=[Int]()
    var temparray=[String]()
    var promoAddedFullArray=[PromotionalCodes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
       // projects[projectSelectIndex].discountDollars=""
        txtfldVoucherPrice.delegate=self
        promoOffersTableView.register(UINib(nibName: "PromoTableViewCell", bundle: nil), forCellReuseIdentifier: "PromoTableViewCell")
        print(promoCell.promocodeArrayForCollectionView)
        promoAddedFullArray.removeAll()
        if projects[projectSelectIndex].promoArray?.count ?? 0>0{
            promoCell.promocodeArrayForCollectionView=projects[projectSelectIndex].promoArray ?? []
            promoArray=projects[projectSelectIndex].promofullArray ?? []
            offerapplied=projects[projectSelectIndex].isOfferApplied ?? false
            promoAddedFullArray=projects[projectSelectIndex].promoAddedFullArray ?? []
        }
        if projects[projectSelectIndex].voucherArray?.count ?? 0>0{
            self.voucherArray=projects[projectSelectIndex].voucherArray ?? []
            offerapplied=projects[projectSelectIndex].isOfferApplied ?? false
        }
        if projects[projectSelectIndex].discountDollars != "0.00"&&projects[projectSelectIndex].discountDollars != ""&&projects[projectSelectIndex].discountDollars != "0"{
            discountDollarText = projects[projectSelectIndex].discountDollars
            
        }
        
    }
    private func promotionalOffers(data: [PromoOffers]) {
        print("data",data)
        if offerapplied==false{
            voucherArray=data
            promoOffersTableView.reloadData()
        }
        if voucherArray.count>0{
            for i in 0...voucherArray.count-1{
                promoOffersIdArray.append(voucherArray[i].promoOfferId ?? 0)
            }
        }
        
    }
    
    
    private func promotionalCodes(data: [PromotionalCodes]) {
        print("data",data)
        promoFullArray=data
        promoCodeIdArray.removeAll()
        if promoFullArray.count>0{
            for i in 0...promoFullArray.count-1{
                promoCodeIdArray.append(promoFullArray[i].promoCodeId ?? 0)
            }
        }
        promoArray.removeAll()
        for value in data{
            promoArray.append(value.promoCodeName ?? "")
        }
        
        if offerapplied==false{
            
            promoOffersTableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        if let index=UserDefaults.standard.value(forKey: "promoIndex"){
            promoindex=UserDefaults.standard.value(forKey: "promoIndex") as! Int
        }
        NotificationCenter.default.addObserver(self,
                            selector: #selector(appCameToForeGroundOffers(notification:)),
                            name: UIApplication.didBecomeActiveNotification,
                            object: nil)
        UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
        if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
        {
            tokenexpirationCheck()

        }
        
        setnavBarView()
    }
    @objc func appCameToForeGroundOffers(notification: Notification) {
        if promoArray.count==0{
            
            if UserDefaults.standard.value(forKey: "token") != nil&&UserDefaults.standard.value(forKey: "token") as? String != ""
            {
                tokenexpirationCheck()
            }
        }
    
    }
    
    @objc override func refreshTokenCheck(notification: Notification) {
        
        if let dict = notification.userInfo as NSDictionary? {
            if let token = dict["token"] as? Int{
                UserDefaults.standard.set(token, forKey: "token")
                promoApiCalls()
            }
        }
    }
    func promoApiCalls(){
        let parameters=[String:Any]()
        promoViewmodel.promo_codes(parameters: parameters) { success, promoCodes, message in
            if success{
                self.promotionalCodes(data: promoCodes ?? [])
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                                       
                                        self.promoApiCalls()
                                    }
                                    
                                    let no = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                    no.setValue(UIColor.darkGray, forKey: "titleTextColor")
                                    self.alert( AppAlertMsg.netWorkAlertMessage, [yes,no])
                                }else{
                                    self.showAlertOk(message: message)
                                }
            }
        }
        
        promoViewmodel.promo_offers(parameters: parameters) { success, promoOffers, message in
            if success{
                self.promotionalOffers(data: promoOffers ?? [])
            }else{
                if message==AppAlertMsg.netWorkAlertMessage{
                                    let yes = UIAlertAction(title: "Try Again", style:.default) { (_) in
                                       
                                        self.promoApiCalls()
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
    
    func  setnavBarView(){
        navView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  120))
        navView.layer.masksToBounds = false
        navView.backgroundColor = UIColor().colorFromHexString("#F2F3F5")
        self.view.addSubview(navView)
        
        navViewBottomLine = UIView(frame: CGRect(x: 0, y: 120, width: self.view.frame.width, height:  1))
        navViewBottomLine.layer.masksToBounds = false
        navViewBottomLine.backgroundColor = UIColor().colorFromHexString("#CBCCD5").withAlphaComponent(1.0)
        self.view.addSubview(navViewBottomLine)
        
        setNavigationBarbacklogoNameForFinance(name: "Offers",superview: navView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        promoCell = tableView.dequeueReusableCell(withIdentifier: "PromoTableViewCell") as! PromoTableViewCell
//        if retailPice.contains("$"){
//            let retail_price=retailPice.replacingOccurrences(of: "$", with: "")
//            promoCell.retailPriceLbl.text=retail_price
//        }
        let overstock=String(retailPice)
        promoCell.retailPriceLbl.text = overstock.numberFormatter(amount: overstock)
        promoCell.dropDown.dataSource=promoArray
        promoCell.discountDollarTxtFld.delegate=self
        // promoCell.discountPrcntTxtfld.delegate=self
        promoCell.delegate=self
        promoCell.imageViewdollarEditable.isHidden=true
        //promoCell.imageViewprcntEditable.isHidden=true
        if offerapplied==true{
            promoCell.promocodeArrayForCollectionView=OfferAppliedpromocodeArrayForCollectionView
            promoCell.discountDollarTxtFld.text=self.discountDollarText
            promoCell.discountDollarTxtFld.text=projects[projectSelectIndex].discountDollars
            self.discountDollarText=projects[projectSelectIndex].discountDollars
            //promoCell.discountPrcntTxtfld.text=self.discountPercentText
            promoCell.collectionviewPromocodes.reloadData()
        }else{
            self.discountDollarText=promoCell.discountDollarTxtFld.text ?? ""
            // self.discountPercentText=promoCell.discountPrcntTxtfld.text ?? ""
        }
        promoCell.voucherArray=self.voucherArray
        promoCell.voucherCollectionView.reloadData()
        
        
        promoCell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
//            if promoCell.promocodeArrayForCollectionView.count>0{
//                self.showAlertOk(message: "Only one promocode can be added at a time")
//            }else{
                UserDefaults.standard.set(index, forKey: "promoIndex")
                
               // temparray.removeAll()
            
                temparray=promoCell.promocodeArrayForCollectionView
            
            if temparray.contains(item){
                self.showAlertOk(message: "Promocode already added")
            }else{
                temparray.append(item)
                promoCell.promocodeArrayForCollectionView=temparray
                //promoCell.promocodeArrayForCollectionView.append(item)
                OfferAppliedpromocodeArrayForCollectionView=temparray
                promoindex=index
                promoCell.discountPrcntTxtfld.isUserInteractionEnabled=true
                promoCell.discountDollarTxtFld.isUserInteractionEnabled=true
                
                promoAddedFullArray.append(promoFullArray[index])
                promoCell.promoAddedFullArray=promoAddedFullArray
               
                //promoCell.discountDollarTxtFld.text=String(promoFullArray[index].discountDollars ?? 0)
                //  promoCell.discountPrcntTxtfld.text=String(Int((promoFullArray[index].discountPercent ?? 0)*100))
               // self.discountDollarText=String(promoFullArray[index].discountDollars ?? 0)
               // discountMaximum=(promoFullArray[index].discountMaximum ?? 0)
                //self.discountPercentText=String(Int((promoFullArray[index].discountPercent ?? 0)*100))
                promoCell.collectionviewPromocodes.reloadData()
                //  promoOffersTableView.reloadData()
                self.view.setNeedsLayout()
                //            }
            }
            if promoAddedFullArray.count>0{
                let editableTrue=promoAddedFullArray.filter({ $0.isDiscountDollarsEditable == true })
                
                
                //if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                discountMaximum=0
                if editableTrue.count>0{
                    for i in 0...editableTrue.count-1{
                        discountMaximum+=editableTrue[i].discountMaximum ?? 0
                    }
                    promoCell.imageViewdollarEditable.isHidden=true
                }else{
                    promoCell.imageViewdollarEditable.isHidden=false
                }
            }
           
//            if promoFullArray[promoindex].isDiscountDollarsEditable==true{
//
//                promoCell.imageViewdollarEditable.isHidden=true
//
//            }else{
//
//                promoCell.imageViewdollarEditable.isHidden=false
//
//                //                self.showAlertOk(message: "Discount % is not editable")
//            }
            
            //            if promoFullArray[promoindex].isDiscountPercentEditable==true{
            //
            //                promoCell.imageViewprcntEditable.isHidden=true
            //
            //            }else{
            //
            //                promoCell.imageViewprcntEditable.isHidden=false
            //
            ////                self.showAlertOk(message: "Discount % is not editable")
            //            }
            
        }
        //                if promoFullArray[promoindex].isDiscountDollarsEditable==true{
        
        promoCell.discountdollarPlusBtn.addTarget(self, action: #selector(discountDollarPlusBtnAction(sender: )), for: .touchUpInside)
        promoCell.discountdollarMinusBtn.addTarget(self, action: #selector(discountDollarMinusBtnAction(sender: )), for: .touchUpInside)
        //               }
        //               else if promoFullArray[promoindex].isDiscountPercentEditable==true{
        
        //  promoCell.discountprcntPlusBtn.addTarget(self, action: #selector(discountPrcntPlusBtnAction(sender: )), for: .touchUpInside)
        //  promoCell.discountprecntMinusBtn.addTarget(self, action: #selector(discountPrcntMinusBtnAction(sender: )), for: .touchUpInside)
        //               }
        
    promoCell.selectPrmoBtn.addTarget(self, action: #selector(dropdownAction), for: .touchUpInside)
        return promoCell
    }
    @objc func dropdownAction(){
        promoCell.dropDown.show()
        
        // self.promoOffersTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  700
    }
    
    @objc func discountDollarPlusBtnAction(sender:UIButton){
        
        //        let cellIndexpath = IndexPath(row: sender.tag, section: 0)
        //        let cell = promoOffersTableView.cellForRow(at: cellIndexpath) as! PromoTableViewCell
        print("promoAddedFullArray",promoAddedFullArray)
        if promoAddedFullArray.count>0{
        let editableTrue=promoAddedFullArray.filter({ $0.isDiscountDollarsEditable == true })
            if promoCell.promocodeArrayForCollectionView.count>0{
                
                //if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                if editableTrue.count>0{
                    var discountDollarMax=Double()
                    for i in 0...editableTrue.count-1{
                        discountDollarMax+=editableTrue[i].discountMaximum ?? 0
                    }
                    
                    promoCell.imageViewdollarEditable.isHidden=true
                    // let discountDollarMax=promoFullArray[promoindex].discountMaximum ?? 0
                    if Double(discountDollarText) ?? 0>=discountDollarMax{
                        self.showAlertOk(message: "DiscountDollar should not be greater than \(discountDollarMax)")
                        
                    }else{
                        discountDollarText=promoCell.discountDollarTxtFld.text ?? ""
                        let previousQuantityStr = (discountDollarText)
                        //            let previousQuantity = Double(previousQuantityStr) ?? 0
                        let previousQuantity = Int(previousQuantityStr) ?? 0
                        let previousQuantitytext="\(previousQuantity + 1)"
                        discountDollarText=previousQuantitytext
                        promoCell.discountDollarTxtFld.text = previousQuantitytext
                    }
                }else{
                    
                    promoCell.imageViewdollarEditable.isHidden=false
                    
                    self.showAlertOk(message: "Discount $ is not editable")
                }
                //   promoOffersTableView.reloadData()
            }
        }else{
            showAlertOk(message: "Please select a promocode to continue")
        }
        
        
    }
    @objc func discountDollarMinusBtnAction(sender:UIButton){
        
        //        let cellIndexpath = IndexPath(row: sender.tag, section: 0)
        //        let cell = promoOffersTableView.cellForRow(at: cellIndexpath) as! PromoTableViewCell
        if promoAddedFullArray.count>0{
        let editableTrue=promoAddedFullArray.filter({ $0.isDiscountDollarsEditable == true })
            if promoCell.promocodeArrayForCollectionView.count>0{
                
                //if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                if editableTrue.count>0{
                    var discountDollarMax=Double()
                    for i in 0...editableTrue.count-1{
                        discountDollarMax+=editableTrue[i].discountMaximum ?? 0
                    }
                    
                    
                    // if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                    promoCell.imageViewdollarEditable.isHidden=true
                    discountDollarText=promoCell.discountDollarTxtFld.text ?? ""
                    let previousQuantityStr = (discountDollarText)
                    let previousQuantity = Int(previousQuantityStr) ?? 0
                    let previousQuantitytext="\(previousQuantity - 1)"
                    
                    if previousQuantity > 0{
                        promoCell.discountDollarTxtFld.text = previousQuantitytext
                        discountDollarText=previousQuantitytext
                    }else{
                        promoCell.discountDollarTxtFld.text = "0"
                        discountDollarText="0"
                    }
                    
                }else{
                    
                    promoCell.imageViewdollarEditable.isHidden=false
                    
                    self.showAlertOk(message: "Discount $ is not editable")
                }
            }
        }else{
            showAlertOk(message: "Please select a promocode to continue")
        }
    }
    @objc func discountPrcntPlusBtnAction(sender:UIButton){
        
        //        let cellIndexpath = IndexPath(row: sender.tag, section: 0)
        //        let cell = promoOffersTableView.cellForRow(at: cellIndexpath) as! PromoTableViewCell
        if promoCell.promocodeArrayForCollectionView.count>0{
            if promoFullArray[promoindex].isDiscountPercentEditable==true{
                promoCell.imageViewprcntEditable.isHidden=true
                discountPercentText=promoCell.discountPrcntTxtfld.text ?? ""
                let previousQuantityStr = discountPercentText
                let previousQuantity = Int(previousQuantityStr) ?? 0
                let previousQuantitytext="\(previousQuantity + 1)"
                promoCell.discountPrcntTxtfld.text = previousQuantitytext
                discountPercentText=previousQuantitytext
            }else{
                
                promoCell.imageViewprcntEditable.isHidden=false
                
                self.showAlertOk(message: "Discount % is not editable")
            }
        }else{
            showAlertOk(message: "Please select a promocode to continue")
        }
    }
    @objc func discountPrcntMinusBtnAction(sender:UIButton){
        
        //        let cellIndexpath = IndexPath(row: sender.tag, section: 0)
        //        let cell = promoOffersTableView.cellForRow(at: cellIndexpath) as! PromoTableViewCell
        if promoCell.promocodeArrayForCollectionView.count>0{
            if promoFullArray[promoindex].isDiscountPercentEditable==true{
                promoCell.imageViewprcntEditable.isHidden=true
                discountPercentText=promoCell.discountPrcntTxtfld.text ?? ""
                let previousQuantityStr = (discountPercentText)
                let previousQuantity = Int(previousQuantityStr) ?? 0
                let previousQuantitytext="\(previousQuantity - 1)"
                if previousQuantity > 0{
                    promoCell.discountPrcntTxtfld.text = "\(previousQuantity - 1)"
                    discountPercentText=previousQuantitytext
                }else{
                    promoCell.discountPrcntTxtfld.text = "0"
                    discountPercentText="0"
                }
            }else{
                
                promoCell.imageViewprcntEditable.isHidden=false
                
                self.showAlertOk(message: "Discount % is not editable")
            }
        }else{
            showAlertOk(message: "Please select a promocode to continue")
        }
    }
    
    @IBAction func popupCancelAction(_ sender: Any) {
        popupView.isHidden=true
        blurView.isHidden=true
    }
    
    @IBAction func poupsubmitAction(_ sender: Any) {
        let price=(txtfldVoucherPrice.text as? NSString)?.integerValue ?? 0
        if txtfldVoucherPrice.text==""{
            self.showAlertOk(message: "Please enter valid amount")
        }else  if price<=0{
            self.showAlertOk(message: "Please enter valid amount")
        }else{
            popupView.isHidden=true
            blurView.isHidden=true
            
            for i in 0...promoCell.voucherArray.count-1{
                if i==voucherselectedIndex{
                    if ((txtfldVoucherPrice.text?.contains(".")) != nil){
                        let amount1=txtfldVoucherPrice.text?.replacingOccurrences(of: ",", with: "")
                        
                        
                        promoCell.voucherArray[voucherselectedIndex].price=amount1?.numberFormatter1(amount: amount1 ?? "") ?? ""
                    }else{
                        let amount1=txtfldVoucherPrice.text?.replacingOccurrences(of: ".", with: "")
                        let amount2=amount1?.replacingOccurrences(of: ",", with: "")
                        let amount3=String((amount2 as? NSString)?.integerValue ?? 0)
                        promoCell.voucherArray[voucherselectedIndex].price=amount3.numberFormatter(amount: amount3)
                    }
                    // promoCell.voucherArray[voucherselectedIndex].price=txtfldVoucherPrice.text ?? ""
                    //                    promoCell.priceArray.insert(txtfldVoucherPrice.text ?? "", at: voucherselectedIndex)
                }
                
                if promoCell.voucherArray[i].price==""{
                    
                }else{
                    if voucherAddedArray.indices.contains(i){
                        if voucherAddedArray[i].price==""{
                            voucherAddedArray.append(promoCell.voucherArray[i])
                        }else{
                            voucherAddedArray.remove(at: i)
                            voucherAddedArray.append(promoCell.voucherArray[i])
                        }
                    }else{
                        voucherAddedArray.append(promoCell.voucherArray[i])
                    }
                    
                    //                    voucherAddedArray.append(promoCell.voucherArray[i])
                }
            }
            txtfldVoucherPrice.text=""
            let index=IndexPath(item: voucherselectedIndex, section: 0)
            promoCell.voucherCollectionView.reloadItems(at: [index])
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == txtfldVoucherPrice{
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789.")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == promoCell.discountDollarTxtFld{
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
           
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789.")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
                        return allowedCharacters.isSuperset(of: characterSet)
        }
//        if textField == promoCell.discountDollarTxtFld{
//            discountDollarText = textField.text ?? ""
//        }
        
        return true
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField==promoCell.discountDollarTxtFld{
            if promoAddedFullArray.count>0{
                let editableTrue=promoAddedFullArray.filter({ $0.isDiscountDollarsEditable == true })
                
                
                //if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                discountMaximum=0
                if editableTrue.count>0{
                    for i in 0...editableTrue.count-1{
                        discountMaximum+=editableTrue[i].discountMaximum ?? 0
                    }
                }
            }
           // let discountDollarMax=promoFullArray[promoindex].discountMaximum ?? 0
            if Double(discountDollarText) ?? 0>discountMaximum{
               // self.showAlertOk(message: "DiscountDollar should not be greater than \(discountMaximum)")
//                discountDollarText="0.00"
//                promoCell.discountDollarTxtFld.text="0.00"
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        if textField==promoCell.discountDollarTxtFld{
            if promoCell.promocodeArrayForCollectionView.count>0{
                if promoAddedFullArray.count>0{
                    let editableTrue=promoAddedFullArray.filter({ $0.isDiscountDollarsEditable == true })
                    
                    
                    //if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                    
                    if editableTrue.count>0{
                       
                
                
               // if promoFullArray[promoindex].isDiscountDollarsEditable==true{
                    
                    promoCell.discountDollarTxtFld.isUserInteractionEnabled=true
                    }else{
                        
                        promoCell.discountDollarTxtFld.isUserInteractionEnabled=false
                        
                        self.showAlertOk(message: "Discount $ is not editable")
                    }
                    
                }
                
            }else{
                promoCell.discountDollarTxtFld.isUserInteractionEnabled=false
                showAlertOk(message: "Please select a promocode to continue")
            }
        }else if textField==promoCell.discountPrcntTxtfld{
            
            if promoCell.promocodeArrayForCollectionView.count>0{
                
                
                if promoFullArray[promoindex].isDiscountPercentEditable==true{
                    promoCell.discountPrcntTxtfld.isUserInteractionEnabled=true
                    
                }else{
                    
                    
                    promoCell.discountPrcntTxtfld.isUserInteractionEnabled=false
                    self.showAlertOk(message: "Discount % is not editable")
                }
                
                
            }else{
                showAlertOk(message: "Please select a promocode to continue")
                promoCell.discountPrcntTxtfld.isUserInteractionEnabled=false
            }
        }
    }
    
    
    func collectionViewTapped(VoucherName: String, index: Int,voucherPrice:String) {
        
//        blurView.backgroundColor=UIColor().colorFromHexString("#232538")
//            .withAlphaComponent(0.7)
//        popupView.isHidden=false
//        blurView.isHidden=false
//        self.navView.addSubview(blurView)
//        self.navViewBottomLine.addSubview(blurView)
//        self.view.addSubview(popupView)
//        voucherselectedLbl.text=VoucherName
//        txtfldVoucherPrice.text=voucherPrice
       
        voucherselectedIndex=index
        collectionViewvoucherTapped()
    }
    
    
    func collectionViewvoucherTapped(){
        
       
            
            for i in 0...promoCell.voucherArray.count-1{
                if i==voucherselectedIndex{
                    
                        promoCell.voucherArray[voucherselectedIndex].isSelected=1
                   
                }
                
                if promoCell.voucherArray[i].isSelected==0{
                    
                }else{
                    if voucherAddedArray.indices.contains(i){
                        if voucherAddedArray[i].isSelected==0{
                            voucherAddedArray.append(promoCell.voucherArray[i])
                        }else{
                            voucherAddedArray.remove(at: i)
                            voucherAddedArray.append(promoCell.voucherArray[i])
                        }
                    }else{
                        voucherAddedArray.append(promoCell.voucherArray[i])
                    }
                    
                    //                    voucherAddedArray.append(promoCell.voucherArray[i])
                }
            }
            let index=IndexPath(item: voucherselectedIndex, section: 0)
            promoCell.voucherCollectionView.reloadItems(at: [index])
//        promoCell.voucherCollectionView.reloadData()
        }
        
    
    
    
    @IBAction func resetBtnaction(_ sender: Any) {
        resetAction()
        // let priceDetails = PriceDetailsViewController.initialization()!
        
        //        priceDetails.isOfferApplied=offerapplied
        //
        //        self.navigationController?.pushViewController(priceDetails, animated: true)
    }
    @IBAction func applyBtnAction(_ sender: Any) {
        let Vouchercount=promoCell.voucherArray.filter({$0.isSelected==1})
        //if promoCell.voucherArray[i].price==""{
        if discountDollarText != ""&&discountDollarText != "0"&&discountDollarText != "0.00"{
            if projects[projectSelectIndex].discountDollars != discountDollarText{
                projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=[]
                projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=[]
            }
        }
        
        
        //        if promoFullArray.count>0{
        //            discountMaximum=promoFullArray[promoindex].discountMaximum ?? 0
        //        }
        print("promoAddedFullArrayapply",promoAddedFullArray)
        if promoAddedFullArray.count>0{
            let editableTrue=promoAddedFullArray.filter({ $0.isDiscountDollarsEditable == true })
            
            
            //if promoFullArray[promoindex].isDiscountDollarsEditable==true{
            discountMaximum=0
            if editableTrue.count>0{
                for i in 0...editableTrue.count-1{
                    discountMaximum+=editableTrue[i].discountMaximum ?? 0
                }
            }
        }
        let minValue=projects[projectSelectIndex].pricingDetails?.pricing?.filter({ $0.isMin == true })
        let value=minValue?[0].salesAmount
       // let value=projects[projectSelectIndex].customerTypepricingArray?.last
        discountDollarText=promoCell.discountDollarTxtFld.text ?? ""
        let amount=discountDollarText.replacingOccurrences(of: ",", with: "")
        let amount1=(amount as? NSString)?.doubleValue ?? 0
        if Double(discountDollarText) ?? 0.00>discountMaximum{
            self.showAlertOk(message: "Discount Dollar value should not be greater than \(discountMaximum)")
//            discountDollarText="0.00"
//            promoCell.discountDollarTxtFld.text="0.00"
            
        
        }else{

            if retailPice-amount1<value ?? 0&&amount1 != 0.0{

       // if promoCell.promocodeArrayForCollectionView.count>0||Vouchercount.count>0{
            let notesVC = PopUpViewController.initialization()!
            notesVC.isFromOffers=true
            notesVC.delegate=self
            notesVC.dollarAmount=discountDollarText
            self.present(notesVC, animated: true)
              //  self.showAlertOk(message: "DiscountDollar should not be greater than \(discountMaximum)")
            }else{



                let priceDetails = PriceDetailsViewController.initialization()!
                if promoCell.promocodeArrayForCollectionView.count>0||Vouchercount.count>0{
                    offerapplied=true
               }else{
                offerapplied=false
              }
                priceDetails.isOfferApplied=offerapplied
                priceDetails.promocodesAdded=promoCell.promocodeArrayForCollectionView
                voucherAddedArray.removeAll()
                if voucherArray.count>0{
                    for i in 0...promoCell.voucherArray.count-1{
                        //if promoCell.voucherArray[i].price==""{
                        if promoCell.voucherArray[i].isSelected==0{

                        }else{
                            voucherAddedArray.append(promoCell.voucherArray[i])
                        }
                    }
                }
                priceDetails.voucherAdded=voucherAddedArray
                priceDetails.voucherFullArray=promoCell.voucherArray
                priceDetails.promoNameArray=promoArray
                if promoCell.promocodeArrayForCollectionView.count>0{
                    priceDetails.discountDollars=promoCell.discountDollarTxtFld.text ?? ""
                    //  priceDetails.discountpercent=self.discountPercentText
                }else{
                    priceDetails.discountDollars=""
                    // priceDetails.discountpercent=""
                }
            projects[projectSelectIndex].discountDollars=priceDetails.discountDollars
            projects[projectSelectIndex].promoArray=priceDetails.promocodesAdded
            projects[projectSelectIndex].voucherArray=promoCell.voucherArray
            projects[projectSelectIndex].isOfferApplied=offerapplied
            projects[projectSelectIndex].promofullArray=promoArray
            projects[projectSelectIndex].promoAddedFullArray=promoAddedFullArray
                self.navigationController?.pushViewController(priceDetails, animated: true)
            }
        }
    }
    func resetAction(){
        
        offerapplied=false
        promoCell.promocodeArrayForCollectionView.removeAll()
        OfferAppliedpromocodeArrayForCollectionView.removeAll()
        
        promoCell.collectionviewPromocodes.reloadData()
        for i in 0...self.voucherArray.count-1{
            //self.voucherArray[i].price=""
            self.voucherArray[i].isSelected=0
            
        }
        if voucherAddedArray.count>0{
            for i in 0...voucherAddedArray.count-1{
                //voucherAddedArray[i].price=""
                voucherAddedArray[i].isSelected=0
                
            }
        }
        voucherAddedArray.removeAll()
        projects[projectSelectIndex].discountDollars=""
        
        promoCell.voucherCollectionView.reloadData()
        promoCell.discountDollarTxtFld.text=""
        promoCell.discountPrcntTxtfld.text=""
        promoOffersTableView.reloadData()
        projects[projectSelectIndex].isOfferApplied=offerapplied
        projects[projectSelectIndex].voucherArray=[]
        projects[projectSelectIndex].promoArray=[]
        projects[projectSelectIndex].promofullArray=[]
        projects[projectSelectIndex].promoAddedFullArray=[]
    }
    func backToPresentingClassSalesSchedules() {
//        let priceDetails = PriceDetailsViewController.initialization()!
//        offerapplied=true
//        priceDetails.isOfferApplied=offerapplied
//        priceDetails.promocodesAdded=promoCell.promocodeArrayForCollectionView
//        voucherAddedArray.removeAll()
//        for i in 0...promoCell.voucherArray.count-1{
//           // if promoCell.voucherArray[i].price==""{
//            if promoCell.voucherArray[i].isSelected==0{
//
//            }else{
//                voucherAddedArray.append(promoCell.voucherArray[i])
//            }
//        }
//        priceDetails.voucherAdded=voucherAddedArray
//        priceDetails.voucherFullArray=promoCell.voucherArray
//        priceDetails.promoNameArray=promoArray
//        if promoCell.promocodeArrayForCollectionView.count>0{
//            priceDetails.discountDollars=self.discountDollarText
//            // priceDetails.discountpercent=self.discountPercentText
//        }else{
//            priceDetails.discountDollars=""
//            // priceDetails.discountpercent=""
//        }
//        projects[projectSelectIndex].discountDollars=priceDetails.discountDollars
//        projects[projectSelectIndex].promoArray=priceDetails.promocodesAdded
//        projects[projectSelectIndex].voucherArray=promoCell.voucherArray
//        projects[projectSelectIndex].isOfferApplied=offerapplied
//        projects[projectSelectIndex].promofullArray=promoArray
//        self.navigationController?.pushViewController(priceDetails, animated: true)
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
           promoApiCalls()
        
        }else{
           intializeMSAL(isfromLoggedOut: false)
            
        }
    }
    
    
}
