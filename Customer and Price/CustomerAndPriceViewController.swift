//
//  CustomerAndPriceViewController.swift
//  EHS_Sales
//
//  Created by Anju on 25/04/23.
//

import UIKit


class CustomerAndPriceViewController: UIViewController, CustomAlertDismissProtocol, timerRestartProtocol
{
    func backToPresentingClassFromoverstockPopupForMax() {
        
    }
    
    func backToPresentingClassFromOffersPopup(DollarAmount: String) {
        
    }
    
    
    
    func backToPresentingClassFromoverstockPopup(status: Int, customprice: String) {
        //customPrice=customprice
        if projects[projectSelectIndex].customPrice==customprice{
            if projects[projectSelectIndex].customPriceName != ""{
                for i in 0...(projects[projectSelectIndex].customerTypepricingArray?.count ?? 0)-1{
                    if projects[projectSelectIndex].customerTypepricingArray?[i].name==projects[projectSelectIndex].customPriceName{
                        projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=true
                    }
                }
            }
        }else{
            projects[projectSelectIndex].customPrice=customprice
            projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=[]
        
       
            projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=[]
            
//
//            nofinanceModel.DepositFinanceProviderArray=[]
//            nofinanceModel.cardCheckDetailArray=[]
//            nofinanceModel.cardCheckArrayDict.removeAll()
//            balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
//            balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
//            balanceNoFinanceSelectedModel.cardCheckArrayDict.removeAll()
            
            for i in 0...(projects[projectSelectIndex].customerTypepricingArray?.count ?? 0)-1{
                projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=false
            }
            
        }
        // let index=IndexPath(row: 0, section: 1)
        // self.customerPriceTableView.reloadRows(at: [index], with: .automatic)
        self.customerPriceTableView.reloadData()
    }
//    func timerRestart(time: Int,timerIndex:Int)
//    {
//        timerValue = time
//        isTimerRestart = true
//        customerPriceTableView.reloadData()
//    }
    
    func timerRestart(time: Int,timerIndex:Int)
    {
        print(time)
        self.timerValue = time
        self.timerIndex = timerIndex
        projectSelectIndex = didCellTap.firstIndex(of: true)!
       // isCourtesy[projectSelectIndex] = true
        timer[projectSelectIndex].isCourtesy=true
       // isTimerRestart[timerIndex] = true
        timer[timerIndex].isTimerRestart=true
       // for index in 0...isTimerRestart.count - 1
        for index in 0...timer.count - 1
        {
            if index == timerIndex
            {
                //isTimerRestart[timerIndex] = true
                timer[timerIndex].isTimerRestart = true
            }
            else
            {
                //isTimerRestart[index] = false
                timer[index].isTimerRestart = false
            }
        }
       // isCourtesyCalled[timerIndex] = false
        timer[timerIndex].isCourtesyCalled=false
        
        
       // NotificationCenter.default.removeObserver(self, name: Notification.Name("com.user.globalTimer.reStart"), object: nil)
        
        customerPriceTableView.reloadData()
    }
    
    func backToPresentingClass(status: Int, isInternalNote: Bool)
    {
        
    }
    func courtesyHold(courtesyIndex:Int)
    {
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(globalTimerSetting(_:)),
                         name: NSNotification.Name ("com.user.globalTimer.success"),                                           object: nil)
        projectSelectIndex = didCellTap.firstIndex(of: true)!
        timer[projectSelectIndex].isCourtesyCalled=true
        timer[projectSelectIndex].isCourtesy=true
//        isCourtesy[projectSelectIndex] = true
//        isCourtesyCalled[projectSelectIndex] = true
        customerPriceTableView.reloadData()
    }
    
    
    static func initialization() -> CustomerAndPriceViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerAndPriceViewController") as? CustomerAndPriceViewController
    }

    @IBOutlet weak var customerPriceTableView: UITableView!
    @IBOutlet weak var customerAndPriceCollectionView: UICollectionView!
   // var didCellTap:[Bool] = []
    var didCellTapTableView:[Bool] = []
    var timerValue : Int = Int()
    var timerString : String = String()
    var isTimerRestart: Bool = Bool()
    var customPrice=String()
    var selectedIndex=20
    var typeArray=["Express Code","Overstock Price","2+ Houses","Contractors","Builders","Commercial","Friends/Family"]
    var totalSaleAmntArray=["$12,000.00","$7,500.00","$6,000.00","$5,500.00","$5,500.00","$4,500.00","$4,000.00"]
    var commisionerTierArray=["10% + 30%","10% + 30%","10%","8%","6%","4%","3%"]
    var isCourtesyCalled : [Bool] = []
    var timerSelectedIndex = -1
    var timerIndex:Int = Int()
    var projectSelectIndex:Int!
    var customerTypePricingArray=[Pricing]()
    var dispalyPricingArray=[Pricing]()
    var stairsCustomerPrice=[Stairs]()
    var roomsCustomerPrice = [Rooms]()
    var productList=ProductListTableViewCell()
    var requiredHeight=Int()
    
    //var projects=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // HeadingTableViewCell
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
        
        roomsCustomerPrice=projects[projectSelectIndex].pricingDetails?.rooms ?? []
        stairsCustomerPrice=projects[projectSelectIndex].pricingDetails?.stairs ?? []
        
        customerPriceTableView.register(UINib(nibName: "HeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadingTableViewCell")
        //PriceTableViewCell
        customerPriceTableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTableViewCell")
        //ProductListTableViewCell
        customerPriceTableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        //CustomerTypeTableViewCell
        customerPriceTableView.register(UINib(nibName: "CustomerTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerTypeTableViewCell")
        customerPriceTableView.register(UINib(nibName: "CommisionTierTableViewCell", bundle: nil), forCellReuseIdentifier: "CommisionTierTableViewCell")
        self.setNavigationBarbacklogoResetAndNext(name: "Customer & Price")
//        didCellTap = Array(repeating: false, count: 10)
        
        //didCellTapTableView[0]=true
        
//       let  customer_TypePricingArray=projects[projectSelectIndex].pricingDetails?.pricing ?? []
//        dispalyPricingArray=customer_TypePricingArray.filter({ $0.displayInSummary == true })
//        customerTypePricingArray=customer_TypePricingArray.filter({ $0.displayInSummary == false && $0.displayPrice == true })
//
//        dispalyPricingArray.sort { ($0.salesAmount ?? 0) > ($1.salesAmount ?? 0) }
//        customerTypePricingArray.sort { ($0.salesAmount ?? 0) > ($1.salesAmount ?? 0) }
        
        didCellTapTableView = Array(repeating: false, count: projects[projectSelectIndex].customerTypepricingArray?.count ?? 0)
        print("dispalyPricingArray",dispalyPricingArray)
        print("timer",timer)
        if projects[projectSelectIndex].customPriceName != ""{
            for i in 0...(projects[projectSelectIndex].customerTypepricingArray?.count ?? 0)-1{
                if projects[projectSelectIndex].customerTypepricingArray?[i].name==projects[projectSelectIndex].customPriceName{
                    projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=true
                }
            }
        }
        //didCellTap[0] = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.view.endEditing(true)
//        refreshMSALToken()
        if timer[projectSelectIndex].isCourtesyCalled==true{
        notificationAddObserver()
       
            NotificationCenter.default
                .addObserver(self,
                             selector:#selector(globalTimerSetting(_:)),
                             name: NSNotification.Name ("com.user.globalTimer.success"),                                           object: nil)
        }
    }
    @objc func globalTimerSetting(_ notification: Notification)
    {
        customerPriceTableView.reloadData()
    }
    override func performSegueToReturnBack(){
        let customerandprice = ProjectSummaryViewController.initialization()!
        
        self.navigationController?.pushViewController(customerandprice, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        notificationRemoveObserver()
        NotificationCenter.default.removeObserver(self, name: Notification.Name("com.user.globalTimer.success"), object: nil)
       
    }
    override func globalTimerRestartSetting(_ notification: Notification) {
//        let timerVC = PopUpViewController.initialization()!
//        timerVC.timerDelegate = self
//        timerVC.istimeUp = true
//       self.present(timerVC, animated: true)
//
        
        if let dict = notification.userInfo as NSDictionary? {
            if let id = dict["timer"] as? Int{
                let timerVC = PopUpViewController.initialization()!
                timerVC.timerDelegate = self
                timerVC.istimeUp = true
                timerVC.timerIndex = id
                if projectSelectIndex==id{
                    self.present(timerVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton)
    {
        let priceDetails = PriceDetailsViewController.initialization()!
        priceDetails.projectSelectIndex=projectSelectIndex
        // if customPrice != ""{
        if projects[projectSelectIndex].customPrice != ""{
            priceDetails.overstockPrice=projects[projectSelectIndex].customPrice
           
    }
        
//        nofinanceModel.DepositFinanceProviderArray=[]
//        nofinanceModel.cardCheckDetailArray=[]
//        nofinanceModel.cardCheckArrayDict.removeAll()
//        balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
//        balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
//        balanceNoFinanceSelectedModel.cardCheckArrayDict.removeAll()
        self.navigationController?.pushViewController(priceDetails, animated: true)
    }
    
}
extension CustomerAndPriceViewController :UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectSummeryCollectionViewCell", for: indexPath) as! ProjectSummeryCollectionViewCell
        cell.projectBtn.addTarget(self, action: #selector(projectBtnTapped(sender: )), for: .touchUpInside)
        //cell.projectBtn.setTitle("Project \(indexPath.row + 1)", for: .normal)
        cell.projectBtn.setTitle(projects[indexPath.row].name,for: .normal)
        cell.projectBtn.tag = indexPath.row
        cell.projectBtn.sizeToFit()
        if didCellTap[indexPath.row] == true
        {
            cell.projectBtn.setTitleColor(UIColor().colorFromHexString("#304CCE"), for: .normal)
            cell.projectView.backgroundColor = UIColor().colorFromHexString("#304CCE")
            cell.projectBtn.titleLabel?.font = UIFont(name: "PublicSans-SemiBold", size: 24)
            cell.projectViewHeightConstraint.constant = 2
        }
        else
        {
            cell.projectBtn.setTitleColor(UIColor().colorFromHexString("#34353C"), for: .normal)
            cell.projectView.backgroundColor = UIColor().colorFromHexString("#CBCCD5")
            cell.projectBtn.titleLabel?.font = UIFont(name: "PublicSans-Regular", size: 24)
            cell.projectViewHeightConstraint.constant = 1
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    @objc func projectBtnTapped(sender:UIButton)
    {
        print("Cell tapped")
        for index in 0...didCellTap.count - 1
        {
            if sender.tag == index
            {
                didCellTap[sender.tag] = !didCellTap[sender.tag]
            }
            else
            {
                if didCellTap[index] == true
                {
                    didCellTap[index] = !didCellTap[index]
                }
            }
//            let indexpath = IndexPath(item: index , section: 0)
//            customerAndPriceCollectionView.reloadItems(at: [indexpath])
            customerAndPriceCollectionView.reloadData()
        }
        projectSelectIndex=sender.tag
        roomsCustomerPrice=projects[projectSelectIndex].pricingDetails?.rooms ?? []
        stairsCustomerPrice=projects[projectSelectIndex].pricingDetails?.stairs ?? []
        UserDefaults.standard.set(sender.tag, forKey: "projectSelectedIndex")
        customerPriceTableView.reloadData()
        customerPriceTableView.scrollToRow(at: [0,0], at: .top, animated: true)
    }
}

extension CustomerAndPriceViewController : UITableViewDelegate , UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 1
            
//            return projects[projectSelectIndex].dispalyTypePricingArray?.count ?? 0
        case 2:
            return 1
        case 3:
          //  return 2
            return roomsCustomerPrice.count + stairsCustomerPrice.count
        case 4:
            return 1
        case 5:
            
            return projects[projectSelectIndex].customerTypepricingArray?.count ?? 0
//        case 6:
//            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch(indexPath.section)
        {
        case 0:
            let headingCell = tableView.dequeueReusableCell(withIdentifier: "HeadingTableViewCell") as! HeadingTableViewCell
            headingCell.headingLbl.text = "PRICE DETAILS"
            headingCell.customPriceBtn.isHidden = true
            headingCell.courtseyStackView.isHidden = true
            return headingCell
        case 1:
            let priceCell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell") as! PriceTableViewCell
//            if dispalyPricingArray[indexPath.row].highlightPrice==true{
//                priceCell.priceLbl.textColor=UIColor().colorFromHexString("#304CCE")
//                priceCell.priceNameLbl.textColor=UIColor().colorFromHexString("#304CCE")
//               priceCell.priceNameLbl.font = UIFont(name: "PublicSans-Bold", size: 26)
//                priceCell.priceLbl.font = UIFont(name: "PublicSans-Bold", size: 26)
//             }else{
//
//                priceCell.priceLbl.textColor=UIColor().colorFromHexString("#595A5D")
//                priceCell.priceNameLbl.font = UIFont(name: "PublicSans-Regular", size: 26)
//                priceCell.priceNameLbl.textColor=UIColor().colorFromHexString("#595A5D")
//                priceCell.priceLbl.font = UIFont(name: "PublicSans-Regular", size: 26)
//            }
//            priceCell.priceNameLbl.text=dispalyPricingArray[indexPath.row].name
//            let saleAmount=dispalyPricingArray[indexPath.row].salesAmount as! Double
//            let saleAmountString=String(saleAmount)
//            priceCell.priceLbl.text="$ "+saleAmountString.numberFormatter(amount: saleAmountString)
//
//            if indexPath.row == 0{
//                priceCell.hideTopBorder=false
//                priceCell.hideBottomBorder=true
//
//
//            }else if indexPath.row==1{
//                priceCell.hideTopBorder=true
//                priceCell.hideBottomBorder=true
//
//            }else{
//                priceCell.hideTopBorder=true
//                priceCell.hideBottomBorder=false
//            }
//
//            priceCell.hideBottomBorder = indexPath.row == 0 || indexPath.row == 1
//            priceCell.hideTopBorder = indexPath.row == 1 || indexPath.row == 2
//
//            if customPrice==""{
//                priceCell.overstockPriceLbl.text="$9,900.00"
//            }else{
//                priceCell.overstockPriceLbl.text="$"+customPrice.numberFormatter(amount: customPrice)
//            }
//
            
            priceCell.priceNameLbl.text=projects[projectSelectIndex].dispalyTypePricingArray?[0].name
            priceCell.expressPriceNameLbl.text=projects[projectSelectIndex].dispalyTypePricingArray?[1].name
            priceCell.overstockpriceNameLbl.text=projects[projectSelectIndex].dispalyTypePricingArray?[2].name
            let saleAmountRetail=projects[projectSelectIndex].dispalyTypePricingArray?[0].salesAmount as! Double
            let saleAmountExpress=projects[projectSelectIndex].dispalyTypePricingArray?[1].salesAmount as! Double
            let saleAmountOverstock=projects[projectSelectIndex].dispalyTypePricingArray?[2].salesAmount as! Double
            let saleAmountStringRetail=String(saleAmountRetail)
            let saleAmountStringExpress=String(saleAmountExpress)
            let saleAmountStringOverstock=String(saleAmountOverstock)
            priceCell.priceLbl.text="$ "+saleAmountStringRetail.numberFormatter(amount: saleAmountStringRetail)
            //
            priceCell.expressPriceLbl.text="$ "+saleAmountStringExpress.numberFormatter(amount: saleAmountStringExpress)
            priceCell.overstockPriceLbl.text="$ "+saleAmountStringOverstock.numberFormatter(amount: saleAmountStringOverstock)
            if projects[projectSelectIndex].dispalyTypePricingArray?[0].highlightPrice==true{
                            priceCell.priceLbl.textColor=UIColor().colorFromHexString("#304CCE")
                            priceCell.priceNameLbl.textColor=UIColor().colorFromHexString("#304CCE")
                           priceCell.priceNameLbl.font = UIFont(name: "PublicSans-Bold", size: 28)
                            priceCell.priceLbl.font = UIFont(name: "PublicSans-Bold", size: 28)
               // if customPrice==""{
                if projects[projectSelectIndex].customPrice==""{

                            }else{
                                priceCell.priceLbl.text="$"+projects[projectSelectIndex].customPrice.numberFormatter(amount: projects[projectSelectIndex].customPrice)
                            }
                         }else{

                            priceCell.priceLbl.textColor=UIColor().colorFromHexString("#34353C")
                            priceCell.priceNameLbl.font = UIFont(name: "PublicSans-Regular", size: 28)
                            priceCell.priceNameLbl.textColor=UIColor().colorFromHexString("#34353C")
                            priceCell.priceLbl.font = UIFont(name: "PublicSans-Regular", size: 28)
                        }



            if projects[projectSelectIndex].dispalyTypePricingArray?[1].highlightPrice==true{
                            priceCell.expressPriceLbl.textColor=UIColor().colorFromHexString("#304CCE")
                            priceCell.expressPriceNameLbl.textColor=UIColor().colorFromHexString("#304CCE")
                           priceCell.expressPriceNameLbl.font = UIFont(name: "PublicSans-Bold", size: 28)
                            priceCell.expressPriceLbl.font = UIFont(name: "PublicSans-Bold", size: 28)
              //  if customPrice==""{
                if projects[projectSelectIndex].customPrice==""{

                            }else{
                                priceCell.expressPriceLbl.text="$"+projects[projectSelectIndex].customPrice.numberFormatter(amount: projects[projectSelectIndex].customPrice)
                            }
                         }else{

                            priceCell.expressPriceLbl.textColor=UIColor().colorFromHexString("#34353C")
                            priceCell.expressPriceNameLbl.font = UIFont(name: "PublicSans-Regular", size: 28)
                            priceCell.expressPriceNameLbl.textColor=UIColor().colorFromHexString("#34353C")
                            priceCell.expressPriceLbl.font = UIFont(name: "PublicSans-Regular", size: 28)
                        }
            if projects[projectSelectIndex].dispalyTypePricingArray?[2].highlightPrice==true{
                            priceCell.overstockPriceLbl.textColor=UIColor().colorFromHexString("#304CCE")
                            priceCell.overstockpriceNameLbl.textColor=UIColor().colorFromHexString("#304CCE")
                           priceCell.overstockpriceNameLbl.font = UIFont(name: "PublicSans-Bold", size: 28)
                            priceCell.overstockPriceLbl.font = UIFont(name: "PublicSans-Bold", size: 28)
                //if customPrice==""{
                if projects[projectSelectIndex].customPrice==""{

                            }else{
                                priceCell.overstockPriceLbl.text="$"+projects[projectSelectIndex].customPrice.numberFormatter(amount: projects[projectSelectIndex].customPrice)
                            }
                         }else{

                            priceCell.overstockPriceLbl.textColor=UIColor().colorFromHexString("#34353C")
                            priceCell.overstockpriceNameLbl.font = UIFont(name: "PublicSans-Regular", size: 28)
                            priceCell.overstockpriceNameLbl.textColor=UIColor().colorFromHexString("#34353C")
                            priceCell.overstockPriceLbl.font = UIFont(name: "PublicSans-Regular", size: 28)
                        }
//            if  projects[projectSelectIndex].dispalyTypePricingArray?[indexPath.row].highlightPrice==true{
//                priceCell.priceLbl.textColor=UIColor().colorFromHexString("#304CCE")
//                priceCell.priceNameLbl.textColor=UIColor().colorFromHexString("#304CCE")
//               priceCell.priceNameLbl.font = UIFont(name: "PublicSans-Bold", size: 26)
//                priceCell.priceLbl.font = UIFont(name: "PublicSans-Bold", size: 26)
//                if projects[projectSelectIndex].customPrice==""{
//                    let saleAmount =  projects[projectSelectIndex].dispalyTypePricingArray?[indexPath.row].salesAmount as! Double
//                    let saleAmountString=String(saleAmount)
//                    priceCell.priceLbl.text="$ "+saleAmountString.numberFormatter(amount: saleAmountString)
//
//                            }else{
//                                priceCell.priceLbl.text="$"+projects[projectSelectIndex].customPrice.numberFormatter(amount: projects[projectSelectIndex].customPrice)
//                            }
//             }else{
//                 let saleAmount =  projects[projectSelectIndex].dispalyTypePricingArray?[indexPath.row].salesAmount as! Double
//                 let saleAmountString=String(saleAmount)
//                 priceCell.priceLbl.text="$ "+saleAmountString.numberFormatter(amount: saleAmountString)
//                priceCell.priceLbl.textColor=UIColor().colorFromHexString("#595A5D")
//                priceCell.priceNameLbl.font = UIFont(name: "PublicSans-Regular", size: 26)
//                priceCell.priceNameLbl.textColor=UIColor().colorFromHexString("#595A5D")
//                priceCell.priceLbl.font = UIFont(name: "PublicSans-Regular", size: 26)
//            }
//            priceCell.priceNameLbl.text = projects[projectSelectIndex].dispalyTypePricingArray?[indexPath.row].name
//                        let height=Double(dispalyPricingArray.count*100)
//                        if indexPath.row == 0{
//                            let topBorder = CAShapeLayer()
//                                let topPath = UIBezierPath(roundedRect: topBorder.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 16, height: 16))
//                                topPath.move(to: CGPoint(x: 0, y: 0))
//                            topPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
//                                topBorder.path = topPath.cgPath
//                            topBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                            topBorder.lineDashPattern = [6,5]
//                            topBorder.fillColor = nil
//                                topBorder.lineWidth = 2.0
//                            topBorder.cornerRadius=15
//                    topBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//
//                    priceCell.layer.addSublayer(topBorder)
//
//                let leftBorder = CAShapeLayer()
//                let leftPath = UIBezierPath(roundedRect: leftBorder.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 16, height: 16))
//                leftPath.move(to: CGPoint(x: 0, y: 0))
//                leftPath.addLine(to: CGPoint(x: 0, y: 80))
//                leftBorder.path = leftPath.cgPath
//                leftBorder.cornerRadius=15
//                leftBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                leftBorder.lineDashPattern = [6,5]
//                leftBorder.lineWidth = 2.0
//                leftBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//
//                    priceCell.layer.addSublayer(leftBorder)
//                let rightBorder = CAShapeLayer()
//                let rightPath = UIBezierPath()
//                rightPath.move(to: CGPoint(x: priceCell.frame.width, y: 0))
//                rightPath.addLine(to: CGPoint(x: priceCell.frame.width, y: 80))
//                rightBorder.path = rightPath.cgPath
//                rightBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                rightBorder.lineDashPattern = [6,5]
//                rightBorder.cornerRadius=15
//                rightBorder.lineWidth = 2.0
//                rightBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//
//                    priceCell.layer.addSublayer(rightBorder)
//
//
//            }else if indexPath.row==(projects[projectSelectIndex].dispalyTypePricingArray?.count ?? 0)-1{
//                let bottomBorder = CAShapeLayer()
//                    let bottomPath = UIBezierPath()
//                    bottomPath.move(to: CGPoint(x: 0, y: priceCell.frame.height-100))
//                    bottomPath.addLine(to: CGPoint(x: priceCell.frame.width, y: priceCell.frame.height-100))
//                    bottomBorder.path = bottomPath.cgPath
//                bottomBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                    bottomBorder.lineWidth = 2.0
//                bottomBorder.lineDashPattern = [6,5]
//                bottomBorder.cornerRadius=15
//                    bottomBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//                priceCell.layer.addSublayer(bottomBorder)
//                let leftBorder = CAShapeLayer()
//
//                let leftPath = UIBezierPath()
//                leftPath.move(to: CGPoint(x: 0, y: 0))
//                leftPath.addLine(to: CGPoint(x: 0, y: 80))
//                leftBorder.path = leftPath.cgPath
//                leftBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                leftBorder.lineDashPattern = [6,5]
//                leftBorder.lineWidth = 2.0
//                leftBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//                leftBorder.cornerRadius=15
//                    priceCell.layer.addSublayer(leftBorder)
//                let rightBorder = CAShapeLayer()
//                let rightPath = UIBezierPath()
//                rightPath.move(to: CGPoint(x: priceCell.frame.width, y: 0))
//                rightPath.addLine(to: CGPoint(x: priceCell.frame.width, y: 80))
//                rightBorder.path = rightPath.cgPath
//                rightBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                rightBorder.lineDashPattern = [6,5]
//                rightBorder.lineWidth = 2.0
//                rightBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//                rightBorder.cornerRadius=15
//                    priceCell.layer.addSublayer(rightBorder)
//            }else{
//                let leftBorder = CAShapeLayer()
//                let leftPath = UIBezierPath()
//                leftPath.move(to: CGPoint(x: 0, y: 0))
//                leftPath.addLine(to: CGPoint(x: 0, y: 80))
//                leftBorder.path = leftPath.cgPath
//                leftBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                leftBorder.lineDashPattern = [6,5]
//                leftBorder.lineWidth = 2.0
//                leftBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//
//                    priceCell.layer.addSublayer(leftBorder)
//                let rightBorder = CAShapeLayer()
//                let rightPath = UIBezierPath()
//                rightPath.move(to: CGPoint(x: priceCell.frame.width, y: 0))
//                rightPath.addLine(to: CGPoint(x: priceCell.frame.width, y: 80))
//                rightBorder.path = rightPath.cgPath
//                rightBorder.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//                rightBorder.lineDashPattern = [6,5]
//                rightBorder.lineWidth = 2.0
//                rightBorder.fillColor = UIColor().colorFromHexString("#304CCE").cgColor
//
//                    priceCell.layer.addSublayer(rightBorder)
//            }
            return priceCell
            
        case 2:
            let headingCell = tableView.dequeueReusableCell(withIdentifier: "HeadingTableViewCell") as! HeadingTableViewCell
            headingCell.headingLbl.text = "PRODUCT LIST"
            headingCell.courtseyStackView.isHidden = false
            headingCell.customPriceBtn.isHidden = true
//            headingCell.courtesyLbl.text=timerString
            
//            for i  in 0...timer.count-1{
//                if timer[i].isselected==1{
//                    timerSelectedIndex=i
//
//                }
//                if i==timerIndex{
//
//                }
//            }
//            if timerSelectedIndex == -1{
//
//                timer[projectSelectIndex].expiryTimeInterval = 1800
//                timer[projectSelectIndex].timerIndex = ["timer":projectSelectIndex]
//                tableCell.timerLbl.text = timer[projectSelectIndex].timerString
//                self.isCourtesyCalled[projectSelectIndex] = true
//            }else{
//                timer[timerSelectedIndex].isTimerActive = false
//                timer[timerSelectedIndex].expiryTimeInterval = TimeInterval(timerValue)
//                timer[timerSelectedIndex].timerIndex = ["timer":timerSelectedIndex]
               // headingCell.courtesyLbl.text = timer[timerSelectedIndex].timerString
//                self.isCourtesyCalled[timerSelectedIndex] = true
//            }
//            
            
            //headingCell.courtesyLbl.text = MyGlobalTimer.sharedTimer.timerString
//            if isTimerRestart
//            {
//                MyGlobalTimer.sharedTimer.isTimerActive = false
//                MyGlobalTimer.sharedTimer.expiryTimeInterval = TimeInterval(timerValue)
//            }
           // projectSelectIndex = didCellTap.firstIndex(of: true)!
            if timer[projectSelectIndex].isCourtesyCalled != true || timer[timerIndex].isCourtesyCalled != true
            {

               // if isCourtesyCalled[timerIndex] != true
                if timer[timerIndex].isCourtesyCalled != true
                {
                   // if isTimerRestart[timerIndex]
                    if timer[timerIndex].isTimerRestart
                    {
                        timer[timerIndex].isTimerActive = false
                        timer[timerIndex].expiryTimeInterval = TimeInterval(timerValue)
                        timer[projectSelectIndex].timerIndex = ["timer":timerIndex]
                        headingCell.courtesyLbl.text = timer[timerIndex].timerString
//                            self.isCourtesyCalled[timerIndex] = true
                        timer[timerIndex].isCourtesyCalled = true
                        
                        
                    }
                    else
                    {
                        headingCell.courtseyStackView.isHidden=true
                        timer[projectSelectIndex].expiryTimeInterval = 1800
                        timer[projectSelectIndex].timerIndex = ["timer":projectSelectIndex]
                        headingCell.courtesyLbl.text = timer[projectSelectIndex].timerString
                        headingCell.courtesyLbl.text = "30:00"
                       // self.isCourtesyCalled[projectSelectIndex] = true
//                        timer[projectSelectIndex].isCourtesyCalled = true
                    }
                }
                else
                {
//                        timer[projectSelectIndex].expiryTimeInterval = 1800
//                        timer[projectSelectIndex].timerIndex = ["timer":projectSelectIndex]
//                        tableCell.timerLbl.text = timer[projectSelectIndex].timerString
//                        self.isCourtesyCalled[projectSelectIndex] = true
                    headingCell.courtesyLbl.text = timer[projectSelectIndex].timerString
//                        timer[projectSelectIndex].isCourtesyCalled=true
                }

            }
            else
            {

                timer[projectSelectIndex].expiryTimeInterval = 1800
                timer[projectSelectIndex].timerIndex = ["timer":projectSelectIndex]
                headingCell.courtesyLbl.text = timer[projectSelectIndex].timerString
//                headingCell.courtesyLbl.text = "30:00"
               // self.isCourtesyCalled[projectSelectIndex] = true
//                timer[projectSelectIndex].isCourtesyCalled = true
            }
            
            
            
            return headingCell
            
        case 3:
             productList = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
            print(productList.requiredHeight,"......")
            if indexPath.row < roomsCustomerPrice.count{
                       // Configure the cell using roomTypeArray data
                productList.roomNameLbl.text=roomsCustomerPrice[indexPath.row].name
                productList.productList=roomsCustomerPrice[indexPath.row].products ?? []
                
                   } else {
                       // Configure the cell using stairTypeArray data
                       let stairIndex = indexPath.row - roomsCustomerPrice.count
                       productList.roomNameLbl.text=stairsCustomerPrice[stairIndex].name
                       productList.productList=stairsCustomerPrice[stairIndex].products ?? []
                   }
           
            productList.productListTableView.reloadData()
           
            return productList
            
        case 4:
            let headingCell = tableView.dequeueReusableCell(withIdentifier: "HeadingTableViewCell") as! HeadingTableViewCell
           // headingCell.headingLbl.text = "CUSTOMER TYPE"
            headingCell.headingLbl.text=""
            headingCell.customPriceBtn.isHidden = false
            headingCell.courtseyStackView.isHidden=true
            headingCell.customPriceBtn.addTarget(self, action: #selector(customPriceBtnClicked(sender: )), for: .touchUpInside)
            return headingCell
//        case 5:
//            let customerTypeCell = tableView.dequeueReusableCell(withIdentifier: "CustomerTypeTableViewCell") as! CustomerTypeTableViewCell
//            return customerTypeCell
        case 5:
            let customerTierCell = tableView.dequeueReusableCell(withIdentifier: "CommisionTierTableViewCell") as! CommisionTierTableViewCell
            if indexPath.row==0{
                customerTierCell.topviewHeight.constant=65
                }else{
                customerTierCell.topviewHeight.constant=0
                        
                }
            customerTierCell.typeLbl.text=projects[projectSelectIndex].customerTypepricingArray?[indexPath.row].name
           
            
            
            let saleAmount=projects[projectSelectIndex].customerTypepricingArray?[indexPath.row].salesAmount as! Double
            let saleAmountString=String(saleAmount)
            customerTierCell.saleAmountLbl.text="$ "+saleAmountString.numberFormatter(amount: saleAmountString)
            customerTierCell.commisionTierLbl.text=projects[projectSelectIndex].customerTypepricingArray?[indexPath.row].commissionTier
            let commisionest=String(projects[projectSelectIndex].customerTypepricingArray?[indexPath.row].commissionEst as? Double ?? 0)
            customerTierCell.commissionEstimateLbl.text="$ "+commisionest.numberFormatter(amount: commisionest)
            customerTierCell.cellTappedBtn.tag=indexPath.row
            customerTierCell.cellTappedBtn.addTarget(self, action: #selector(celltappedAction(sender: )), for: .touchUpInside)
            customerTierCell.selectionBtn.tag = indexPath.row
            customerTierCell.selectionBtn.addTarget(self, action: #selector(projectCellDidTap(sender: )), for: .touchUpInside)
            customerTierCell.selectionBtn.tag = indexPath.row
            
                
            
            if projects[projectSelectIndex].customerTypepricingArray?[indexPath.row].isSelected == true
            {
//                if indexPath.row==selectedIndex{
                    customerTierCell.bottomView.backgroundColor = .white
                    customerTierCell.bottomView.borderWidth = 2
                    customerTierCell.bottomView.borderColor = UIColor().colorFromHexString("#304CCE")
                    customerTierCell.selectionBtn.setImage(UIImage(named: "radioBtnSelected"), for: .normal)
                }else{
                    customerTierCell.bottomView.backgroundColor = UIColor().colorFromHexString("#E9EBEF")
                    customerTierCell.bottomView.borderWidth = 1
                    customerTierCell.bottomView.borderColor = UIColor().colorFromHexString("#CBCCD5")
                    customerTierCell.selectionBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                }
//            }
//            else
//            {
//                if indexPath.row==selectedIndex{
//                    customerTierCell.bottomView.backgroundColor = .white
//                    customerTierCell.bottomView.borderWidth = 2
//                    customerTierCell.bottomView.borderColor = UIColor().colorFromHexString("#304CCE")
//                    customerTierCell.selectionBtn.setImage(UIImage(named: "radioBtnSelected"), for: .normal)
//                }else{
//                    customerTierCell.bottomView.backgroundColor = UIColor().colorFromHexString("#E9EBEF")
//                    customerTierCell.bottomView.borderWidth = 1
//                    customerTierCell.bottomView.borderColor = UIColor().colorFromHexString("#CBCCD5")
//                    customerTierCell.selectionBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
//                }
//            }
            
            return customerTierCell
        default:
            return UITableViewCell()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 1
        {
//            return 80
            return 51 * 3 + 40
        }
        else if indexPath.section == 3
        {
            
//            if indexPath.row < roomsCustomerPrice.count{
//                return  CGFloat((productList.requiredHeight)+50)
//            }else{
//                let stairIndex = indexPath.row - roomsCustomerPrice.count
//
//
//            return  CGFloat(requiredHeight+50)
//            }
//            let contentWidth = productList..frame.width // Specify the width available for the label
//            let requiredHeight = myLabel.height(forWidth: contentWidth)
//            print("Required Height:", requiredHeight)
           // return 120 * 2 + 50
            if indexPath.row < roomsCustomerPrice.count{
                if roomsCustomerPrice[indexPath.row].products?.count==1{
                    let totalRows = roomsCustomerPrice.count + stairsCustomerPrice.count
                    return CGFloat(120*(roomsCustomerPrice[indexPath.row].products?.count ?? 0)+20)

                }else{
                    let totalRows = roomsCustomerPrice.count + stairsCustomerPrice.count
                    return CGFloat((120*(roomsCustomerPrice[indexPath.row].products?.count ?? 0))-(10*(roomsCustomerPrice[indexPath.row].products?.count ?? 0)))
                }
            }else{
                let stairIndex = indexPath.row - roomsCustomerPrice.count

                if stairsCustomerPrice[stairIndex].products?.count==1{

                    return CGFloat(120*(stairsCustomerPrice[stairIndex].products?.count ?? 0)+20)

                }else{
                    let totalRows = roomsCustomerPrice.count + stairsCustomerPrice.count
                    return CGFloat((120*(stairsCustomerPrice[stairIndex].products?.count ?? 0))-(10*(stairsCustomerPrice[stairIndex].products?.count ?? 0)))
                }

            }

//            return UITableView.automaticDimension
            
        }
        else if indexPath.section == 5
        {
            if indexPath.row==0{
                return 160
            }else{
                return 90
                
            }
            
        }
//            else if indexPath.section == 6{
//                    return 70
//            }
        else
        {
            return 90
        }
    }
    
    
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    let cornerRadius: CGFloat = 0.0
//    cell.backgroundColor = UIColor.clear
//    let layer: CAShapeLayer = CAShapeLayer()
//    let pathRef: CGMutablePath = CGMutablePath()
//    //dx leading an trailing margins
//    let bounds: CGRect = cell.bounds.insetBy(dx: 8, dy: 0)
//    var addLine: Bool = false
//
//        if indexPath.section == 1{
////            && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
//        }
////        else if indexPath.row == 0 {
////            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
////            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY),
////                           tangent2End: CGPoint(x: bounds.midX, y: bounds.minY),
////                           radius: cornerRadius)
////
////            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY),
////                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
////                           radius: cornerRadius)
////            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
////            addLine = true
////        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
////            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
////            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY),
////                           tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY),
////                           radius: cornerRadius)
////
////            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY),
////                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
////                           radius: cornerRadius)
////            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
////        } else {
////            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
////            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY),
////                           tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY),
////                           radius: cornerRadius)
////
////            pathRef.move(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
////            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY),
////                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
////                           radius: cornerRadius)
////            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
////            addLine = true
////        }
//        
//        layer.path = pathRef
//        layer.strokeColor = UIColor.lightGray.cgColor
//        layer.lineWidth = 1.0
//        layer.fillColor = UIColor.clear.cgColor
//        
//        if addLine == true {
//            let lineLayer: CALayer = CALayer()
//            let lineHeight: CGFloat = (1 / UIScreen.main.scale)
//            lineLayer.frame = CGRect(x: bounds.minX, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight)
//            lineLayer.backgroundColor = UIColor.clear.cgColor
//            layer.addSublayer(lineLayer)
//        }
//        
//        let backgroundView: UIView = UIView(frame: bounds)
//        backgroundView.layer.insertSublayer(layer, at: 0)
//        backgroundView.backgroundColor = .clear
//        cell.backgroundView = backgroundView
//
//    }
    
// func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//     guard section == 1 else {
//                 return nil
//             }
//
//
//            let headerView = UIView()
//            headerView.backgroundColor = UIColor.white // Set your desired background color
//            headerView.layer.borderWidth = 1.0 // Set the border width
//            headerView.layer.borderColor = UIColor.black.cgColor // Set the border color
//     // You can add other subviews or customize the header as needed
//
//            return headerView
//        }
//
    @objc func projectCellDidTap(sender:UIButton)
    {
       selectedIndex=sender.tag
        if projects[projectSelectIndex].customPriceName != ""{
           
        }
//        let amount1=totalSaleAmntArray[sender.tag].replacingOccurrences(of: "$", with: "")
        var amount=projects[projectSelectIndex].customerTypepricingArray?[sender.tag].salesAmount as! Double
        var er=Double(amount)
        let amount2=(er*100).rounded()/100
        let amount1=String(amount2)
//        let amount=amount1.replacingOccurrences(of: ",", with: "")
        customPrice=amount1
        if projects[projectSelectIndex].customPrice==customPrice{
            
            
        }else{
            projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=[]
        
       
            projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=[]
//            nofinanceModel.DepositFinanceProviderArray=[]
//                   nofinanceModel.cardCheckDetailArray=[]
//                   nofinanceModel.cardCheckArrayDict.removeAll()
//                   balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
//                   balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
//                   balanceNoFinanceSelectedModel.cardCheckArrayDict.removeAll()
            
        }
       // projects[projectSelectIndex].customPrice=amount1
        projects[projectSelectIndex].customPrice=""
        projects[projectSelectIndex].customPriceName=""
        didCellTapTableView[sender.tag] = !didCellTapTableView[sender.tag]
        for i in 0...(projects[projectSelectIndex].customerTypepricingArray?.count ?? 0)-1{
            if sender.tag==i&&projects[projectSelectIndex].customerTypepricingArray?[i].isSelected==false {
                projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=true
                projects[projectSelectIndex].customPrice=amount1
                projects[projectSelectIndex].customPriceName=projects[projectSelectIndex].customerTypepricingArray?[i].name ?? ""
            }else{
                projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=false
                
            }
        }
        
    
        
//        if didCellTapTableView[sender.tag]{
//            projects[projectSelectIndex].customPrice=amount1
//        }else{
//            projects[projectSelectIndex].customPrice=""
//        }
        customerPriceTableView.reloadData()
    }
    @objc func celltappedAction(sender:UIButton){
        selectedIndex=sender.tag
         if projects[projectSelectIndex].customPriceName != ""{
//             nofinanceModel.DepositFinanceProviderArray=[]
//                    nofinanceModel.cardCheckDetailArray=[]
//                    nofinanceModel.cardCheckArrayDict.removeAll()
//                    balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
//                    balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
//                    balanceNoFinanceSelectedModel.cardCheckArrayDict.removeAll()
             
         }
 //        let amount1=totalSaleAmntArray[sender.tag].replacingOccurrences(of: "$", with: "")
         var amount=projects[projectSelectIndex].customerTypepricingArray?[sender.tag].salesAmount as! Double
         var round=Double(amount)
         let roundAmount=(round*100).rounded()/100
         let amount1=String(roundAmount)
 //        let amount=amount1.replacingOccurrences(of: ",", with: "")
         customPrice=amount1
        if projects[projectSelectIndex].customPrice==customPrice{
            
        }else{
            projects[projectSelectIndex].nofinanceModelcardCheckDetailArray=[]
        
       
            projects[projectSelectIndex].nofinanceModelDepositFinanceProviderArray=[]
        
//                   nofinanceModel.cardCheckArrayDict.removeAll()
//                   balanceNoFinanceSelectedModel.cardCheckDetailArray=[]
//                   balanceNoFinanceSelectedModel.BalanceFinanceProviderArray=[]
//                   balanceNoFinanceSelectedModel.cardCheckArrayDict.removeAll()
            
        }
        // projects[projectSelectIndex].customPrice=amount1
         projects[projectSelectIndex].customPrice=""
         projects[projectSelectIndex].customPriceName=""
         didCellTapTableView[sender.tag] = !didCellTapTableView[sender.tag]
        for i in 0...(projects[projectSelectIndex].customerTypepricingArray?.count ?? 0)-1{
             if sender.tag==i&&projects[projectSelectIndex].customerTypepricingArray?[i].isSelected==false {
                 projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=true
                 projects[projectSelectIndex].customPrice=amount1
                 projects[projectSelectIndex].customPriceName=projects[projectSelectIndex].customerTypepricingArray?[i].name ?? ""
             }else{
                 projects[projectSelectIndex].customerTypepricingArray?[i].isSelected=false
                 
             }
         }
        customerPriceTableView.reloadData()
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        selectedIndex=indexPath.row
//        didCellTapTableView[indexPath.row] = !didCellTapTableView[indexPath.row]
//        customerPriceTableView.reloadData()
//    }
    
    @objc func customPriceBtnClicked(sender:UIButton)
    {
        let notesVC = PopUpViewController.initialization()!
        notesVC.delegate = self
        notesVC.isOverStock = true
        notesVC.custom_Price=projects[projectSelectIndex].customPrice
        
        let minValue=projects[projectSelectIndex].pricingDetails?.pricing?.filter({ $0.isMin == true })
        let maxValue=projects[projectSelectIndex].pricingDetails?.pricing?.filter({ $0.isMax == true })
        notesVC.popupWarningAmountMin=minValue?[0].salesAmount ?? 0
        notesVC.popupWarningAmountMax=maxValue?[0].salesAmount ?? 0
        
        
       self.present(notesVC, animated: true)
        
    }
    
}
extension UILabel {
    func height(forWidth width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let attributes = [NSAttributedString.Key.font: self.font as Any]
        let rect = self.text?.boundingRect(with: size, options: options, attributes: attributes, context: nil) ?? CGRect.zero
        return ceil(rect.height)
    }
}
