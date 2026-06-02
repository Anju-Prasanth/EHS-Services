//
//  Finance_summaryViewController.swift
//  EHS_Sales
//
//  Created by Anju on 27.04.2023.
//

import UIKit

class Finance_summaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    static func initialization() -> Finance_summaryViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "Finance_summaryViewController") as? Finance_summaryViewController
    }

    @IBOutlet weak var financeSummaryTableview: UITableView!
    var navView = UIView()
    var navViewBottomLine = UIView()
    var rowheight=120
    var balanceAmount=""
    var depositAmount=""
    var actual_SaleAmount=Double()
    var projectSelectIndex=Int()
    override func viewDidLoad() {
        super.viewDidLoad()
       print("depositAmount",depositAmount)
        financeSummaryTableview.register(UINib(nibName: "PriceDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceDetailsTableViewCell")
        financeSummaryTableview.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentMethodTableViewCell")
        financeSummaryTableview.register(UINib(nibName: "SummaryCardDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryCardDetailsTableViewCell")
        
        
        
    }
    override func viewWillAppear(_ animated: Bool){
     projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
       
//        if projects[projectSelectIndex].nofinanceModelcardCheckDetailArray.count==0{
//            nofinanceModel.cardCheckDetailArray=[]
//        }else{
//            nofinanceModel.cardCheckDetailArray=projects[projectSelectIndex].nofinanceModelcardCheckDetailArray
//        }
//        if projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray.count==0{
//            nofinanceModel.DepositFinanceProviderArray=[]
//        }else{
//            nofinanceModel.DepositFinanceProviderArray=projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray
//        }
//        if  nofinanceModel.DepositFinanceProviderArray.count>0{
//            var Array=nofinanceModel.DepositFinanceProviderArray
//            for i in 0...nofinanceModel.DepositFinanceProviderArray.count-1{
//                if nofinanceModel.DepositFinanceProviderArray[i].price==""{
//                    Array.remove(at: i)
//                }
//            }
//            nofinanceModel.DepositFinanceProviderArray=Array
//            projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=nofinanceModel.DepositFinanceProviderArray
//        }
//        if  balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count>0{
//            var balanceArray=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray
//            for i in 0...balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count-1{
//                if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray[i].price==""{
//                    balanceArray.remove(at: i)
//                }
//            }
//            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=balanceArray
//        }
        
        setnavBarView()
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
       
        setNavigationBarbacklogoNameForFinance(name: "Summary",superview: navView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCardDetailsTableViewCell") as! SummaryCardDetailsTableViewCell
            cell.expandBtn.addTarget(self, action: #selector(expandBtnAction(sender: )), for: .touchUpInside)
            if rowheight == 480||rowheight==300{
                cell.expandImageView.image=UIImage(named:"upArrow")
                
            }else{
                cell.expandImageView.image=UIImage(named:"downArrow")
            }
            cell.balance_Amount=balanceAmount
            cell.deposit_Amount=depositAmount
            cell.fianceproviderForCollectionViewArray=nofinanceModel.DepositFinanceProviderArray
            cell.nofinanceCardDetailArray=nofinanceModel.cardCheckDetailArray
            cell.balancefianceproviderForCollectionViewArray=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray
            cell.balancenofinanceCardDetailArray=balanceNoFinanceSelectedModel.cardCheckDetailArray
            cell.collectionViewbalanceDetails.reloadData()
            cell.collectionViewCardDetails.reloadData()
            
            return cell
        case 1:
       let cell = tableView.dequeueReusableCell(withIdentifier: "PriceDetailsTableViewCell") as! PriceDetailsTableViewCell
            
            if projects[projectSelectIndex].discountDollars != "0.00"&&projects[projectSelectIndex].discountDollars != ""&&projects[projectSelectIndex].discountDollars != "0"{
                cell.newOverstockpriceLbl.text="New Overstock Price"
            }else{
                cell.newOverstockpriceLbl.text="Overstock Price"
            }
            let overstockprice=String(actual_SaleAmount as! Double)
            cell.overstockPriceLbl.text="$ "+overstockprice.numberFormatter(amount: overstockprice)
            if depositAmount==""||depositAmount=="0.00"{
                cell.depositPriceLbl.text="$0.00"
            }else{
                cell.depositPriceLbl.text="$ "+depositAmount
            }
            if balanceAmount==""||balanceAmount=="0.00"{
                cell.balancePriceLbl.text="$0.00"
            }else{
                cell.balancePriceLbl.text="$ "+balanceAmount
            }
        return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell") as! PaymentMethodTableViewCell
            
             return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceDetailsTableViewCell") as! PriceDetailsTableViewCell
            
             return cell
        }
    }
    @objc func expandBtnAction(sender:UIButton){
        
        if rowheight == 480||rowheight == 300{
            rowheight=120
            
        }else {
        if (nofinanceModel.DepositFinanceProviderArray.count>0||nofinanceModel.cardCheckDetailArray.count>0)&&(balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count>0||balanceNoFinanceSelectedModel.cardCheckDetailArray.count>0){
                rowheight=480
            }else
                if balanceNoFinanceSelectedModel.BalanceFinanceProviderArray.count==0||balanceNoFinanceSelectedModel.cardCheckDetailArray.count==0||nofinanceModel.DepositFinanceProviderArray.count>0||nofinanceModel.cardCheckDetailArray.count>0{
                    rowheight=300
            }else{
                
            }
        }
        financeSummaryTableview.reloadData()
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        let priceDetails = CustomerDetailsEditViewController.initialization()!
        projects[projectSelectIndex].saleAmount=actual_SaleAmount
        UserDefaults.standard.set("", forKey: "secondsignor")
        nofinanceModel.coapplicantlastName=""
        nofinanceModel.coapplicantfirstName=""
        nofinanceModel.coapplicantmiddleName=""
        self.navigationController?.pushViewController(priceDetails, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return CGFloat(rowheight)
        case 1:
        return 270
        case 2:
        return 0
        default:
        return 270
    }
    }
}
