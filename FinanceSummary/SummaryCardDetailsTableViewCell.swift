//
//  SummaryCardDetailsTableViewCell.swift
//  Express Home
//
//  Created by Anju on 06.07.2023.
//

import UIKit
import AlignedCollectionViewFlowLayout

class SummaryCardDetailsTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var collectionviewbalanceDetailHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionviewCardDetailHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewbalanceDetails: UICollectionView!
    
    @IBOutlet weak var collectionViewCardDetails: UICollectionView!
    
    @IBOutlet weak var expandImageView: UIImageView!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var collectionviewDiscountoffers: UICollectionView!
    var promoArray=[String]()
    var voucherArray=[cardDetails]()
    // var promoArray=["SALE50","FIFTY FIFTY"]
    //    var voucherArray=["Travel voucher","Special Promo"]
    var cardTypeArray=["Credit Card ","Check/ACH ","Credit Card ","Check/ACH "]
    var cardNumberArray=["**** 3659 :","95368002 :","**** 3659 :","95368002 :"]
    var amountArray=["500.00","1,000.00","500.00","1,000.00"]
    var fianceArray=["GreenSky:","Synchrony:","GreenSky:","Synchrony:"]
    var financeTypeArray=["120 Month Payment","Deferred Interest","120 Month Payment"]
    var amountfianaceArray=["3,000.00","3,500.00","3,000.00"]
    var layout=UICollectionViewFlowLayout()
    var layout1=UICollectionViewFlowLayout()
    var fianceproviderForCollectionViewArray=[FinanceProvider]()
    var nofinanceCardDetailArray=[[String:Any]]()
    var balancefianceproviderForCollectionViewArray=[FinanceProvider]()
    var balancenofinanceCardDetailArray=[[String:Any]]()
    var deposit_Amount=""
    var balance_Amount=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewCardDetails.delegate=self
        collectionViewCardDetails.dataSource=self
        collectionViewbalanceDetails.delegate=self
        collectionViewbalanceDetails.dataSource=self
        
        // Initialization code
        
//                let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
//                collectionViewCardDetails.collectionViewLayout = alignedFlowLayout
//
//                layout.itemSize = UICollectionViewFlowLayout.automaticSize
//                layout.estimatedItemSize = CGSize(width: 460, height: 140)
//                layout.minimumInteritemSpacing=0
//                layout.minimumLineSpacing=0
//        layout.scrollDirection = .horizontal
//                collectionViewCardDetails.collectionViewLayout=layout
//        layout1.itemSize = UICollectionViewFlowLayout.automaticSize
//        layout1.estimatedItemSize = CGSize(width: 560, height: 140)
//        layout1.minimumInteritemSpacing=0
//        layout1.minimumLineSpacing=0
//        layout1.scrollDirection = .horizontal
//                collectionViewbalanceDetails.collectionViewLayout=layout1
//        let layout = CustomFlowLayout()
//        collectionViewCardDetails.collectionViewLayout = layout
        
        
        
        collectionViewCardDetails.register(UINib(nibName: "CardcheckCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardcheckCollectionViewCell")
        collectionViewCardDetails.register(UINib(nibName: "FinanceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FinanceCollectionViewCell")
        collectionViewbalanceDetails.register(UINib(nibName: "CardcheckCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardcheckCollectionViewCell")
        collectionViewbalanceDetails.register(UINib(nibName: "FinanceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FinanceCollectionViewCell")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        if collectionView==collectionViewCardDetails{
            return 2
        }else{
            return 2
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if nofinanceCardDetailArray.count>0||fianceproviderForCollectionViewArray.count>0{
            collectionviewCardDetailHeight.constant=180
        }
        if nofinanceCardDetailArray.count==0&&fianceproviderForCollectionViewArray.count==0{
            collectionviewCardDetailHeight.constant=0
        }
        
//        else{
//            collectionviewCardDetailHeight.constant=200
//        }
        
        if balancenofinanceCardDetailArray.count>0||balancefianceproviderForCollectionViewArray.count>0{
            collectionviewbalanceDetailHeight.constant=180
        }
//        }else{
//            collectionviewbalanceDetailHeight.constant=200
//        }
        if collectionView==collectionViewCardDetails{
            if section==0{
                return nofinanceCardDetailArray.count
            }else{
                return fianceproviderForCollectionViewArray.count
                
            }
        }else{
            if section==0{
                return balancenofinanceCardDetailArray.count
            }else{
                return balancefianceproviderForCollectionViewArray.count
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

        if collectionView==collectionViewCardDetails{
            if indexPath.section==0{
                
                if  nofinanceCardDetailArray.count==0{
                    return CGSize(width: 0, height: 0)
                    
                }else{
                    return CGSize(width: 400, height: 130)
                }
            }else{
                if  fianceproviderForCollectionViewArray.count==0{
                    return CGSize(width: 0, height: 0)
                }else{
                    return CGSize(width: 370, height: 130)
                }
                
            }
        }else{
            if indexPath.section==0{
                if  balancenofinanceCardDetailArray.count==0{
                    return CGSize(width: 0, height: 0)
                }else{
                    return CGSize(width: 400, height: 130)
                }
                
            }else{
                if  balancefianceproviderForCollectionViewArray.count==0{
                    return CGSize(width: 0, height: 0)
                }else{
                    return CGSize(width: 370, height: 130)
                }
            }
        }
        
//
//        if indexPath.section==0{
//            return CGSize(width: 450, height: 140)
//            //
//        }else{
//            return CGSize(width: 550, height: 200)
//        }


    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //    }
    //
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView==collectionViewCardDetails{
            switch indexPath.section{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardcheckCollectionViewCell", for: indexPath) as! CardcheckCollectionViewCell
                if indexPath.item==0{
//                    cell.depositLblHeight.constant=21
//                    cell.cardLblTopconstraint.constant=20
                    cell.depositLbl.isHidden=false
                    cell.depositAmountLbl.isHidden=false
                }else{
//                    cell.depositLblHeight.constant=0
//                    cell.cardLblTopconstraint.constant=0
                    cell.depositLbl.isHidden=true
                    cell.depositAmountLbl.isHidden=true
                }
                
                cell.cardLbl.numberOfLines=0
                cell.cardLbl.lineBreakMode = .byWordWrapping
                cell.cardLbl.sizeToFit()
                
                cell.cardNumberLbl.numberOfLines=0
                cell.cardNumberLbl.lineBreakMode = .byWordWrapping
                cell.cardNumberLbl.sizeToFit()
                
                cell.dollarlbl.numberOfLines=0
                cell.dollarlbl.lineBreakMode = .byWordWrapping
                cell.dollarlbl.sizeToFit()
                
                cell.amountLbl.numberOfLines=0
                cell.amountLbl.lineBreakMode = .byWordWrapping
                cell.amountLbl.sizeToFit()
                
                
                cell.depositLbl.text="Deposit: "
                cell.depositAmountLbl.text="$ "+deposit_Amount
                
                cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString(" #797B83").cgColor
                
                cell.dashedView.shapeLayer.lineWidth=1
                cell.dashedView.shapeLayer.lineDashPattern=[5,5]
                cell.cardLbl.text=nofinanceCardDetailArray[indexPath.row]["cardType"] as? String
                if nofinanceCardDetailArray[indexPath.row]["cardType"] as? String=="ACH"{
                    let string=nofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as! String
                    if string.count>4{
                        let substring=subString(from: (nofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? NSString ?? ""), length: 4)
                        // cell.cardNumberLbl.text=nofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? String
                        cell.cardNumberLbl.text="**** "+substring
                    }else{
                        cell.cardNumberLbl.text=string
                        }
                    
                }else{
                    let substring=subString(from: (nofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? NSString ?? ""), length: 4)
                    cell.cardNumberLbl.text="**** "+substring
                }
               
                cell.amountLbl.text=nofinanceCardDetailArray[indexPath.row]["amount"] as? String
                
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinanceCollectionViewCell", for: indexPath) as! FinanceCollectionViewCell
                if nofinanceCardDetailArray.count==0{
                    if indexPath.item==0{
                        cell.balanceAmntLbl.isHidden=false
                        cell.balanceLbl.isHidden=false
                        cell.balanceLbl.text="Deposit: "
                        cell.balanceAmntLbl.text="$ "+deposit_Amount
                    }else{
                        cell.balanceAmntLbl.isHidden=true
                        cell.balanceLbl.isHidden=true
                    }
                }
//                cell.balanceAmntLbl.isHidden=true
//                cell.balanceLbl.isHidden=true
//                cell.balanceLblHeight.constant=0
//                cell.cardLblTopConstraint.constant=0
                
                cell.cardLbl.numberOfLines=0
                cell.cardLbl.lineBreakMode = .byWordWrapping
                cell.cardLbl.sizeToFit()
                
                cell.cardNumberLbl.numberOfLines=0
                cell.cardNumberLbl.lineBreakMode = .byWordWrapping
                cell.cardNumberLbl.sizeToFit()
                
                cell.dollarLbl.numberOfLines=0
                cell.dollarLbl.lineBreakMode = .byWordWrapping
                cell.dollarLbl.sizeToFit()
                
                cell.amountLbl.numberOfLines=0
                cell.amountLbl.lineBreakMode = .byWordWrapping
                cell.amountLbl.sizeToFit()
                
                
                
                cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString(" #797B83").cgColor
                
                cell.dashedView.shapeLayer.lineWidth=1
                cell.dashedView.shapeLayer.lineDashPattern=[5,5]
                cell.cardLbl.text=fianceproviderForCollectionViewArray[indexPath.row].financeServiceProviderName
                cell.cardNumberLbl.text=fianceproviderForCollectionViewArray[indexPath.row].financePlanselected
                if fianceproviderForCollectionViewArray[indexPath.row].price==""{
                    cell.amountLbl.text="_ _"
                }else{
                    cell.amountLbl.text=fianceproviderForCollectionViewArray[indexPath.row].price
                }
                
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinanceCollectionViewCell", for: indexPath) as! FinanceCollectionViewCell
                
                
                return cell
            }
            
        }else{
            switch indexPath.section{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardcheckCollectionViewCell", for: indexPath) as! CardcheckCollectionViewCell
                if indexPath.item==0{
//                    cell.depositLblHeight.constant=21
//                    cell.cardLblTopconstraint.constant=20
                    cell.depositLbl.isHidden=false
                    cell.depositAmountLbl.isHidden=false
                }else{
//                    cell.depositLblHeight.constant=0
//                    cell.cardLblTopconstraint.constant=0
                    cell.depositLbl.isHidden=true
                    cell.depositAmountLbl.isHidden=true
                }
                
                cell.cardLbl.numberOfLines=0
                cell.cardLbl.lineBreakMode = .byWordWrapping
                cell.cardLbl.sizeToFit()
                
                cell.cardNumberLbl.numberOfLines=0
                cell.cardNumberLbl.lineBreakMode = .byWordWrapping
                cell.cardNumberLbl.sizeToFit()
                
                cell.dollarlbl.numberOfLines=0
                cell.dollarlbl.lineBreakMode = .byWordWrapping
                cell.dollarlbl.sizeToFit()
                
                cell.amountLbl.numberOfLines=0
                cell.amountLbl.lineBreakMode = .byWordWrapping
                cell.amountLbl.sizeToFit()
                
                
                
                
                cell.depositLbl.text="Balance: "
                cell.depositAmountLbl.text="$ "+balance_Amount
//
                cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString(" #797B83").cgColor
                
                cell.dashedView.shapeLayer.lineWidth=1
                cell.dashedView.shapeLayer.lineDashPattern=[5,5]
                cell.cardLbl.text=balancenofinanceCardDetailArray[indexPath.row]["cardType"] as? String
                if balancenofinanceCardDetailArray[indexPath.row]["cardType"] as? String=="ACH"{
                    let string=balancenofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as! String
                    if string.count>4{
                        let substring=subString(from: (balancenofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? NSString ?? ""), length: 4)
                        // cell.cardNumberLbl.text=balancenofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? String
                        cell.cardNumberLbl.text="**** "+substring
                    }else{
                        cell.cardNumberLbl.text=string
                    }
                    
                }else{
                    let substring=subString(from: (balancenofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? NSString ?? ""), length: 4)
                    cell.cardNumberLbl.text="**** "+substring
                }
               
                cell.amountLbl.text=balancenofinanceCardDetailArray[indexPath.row]["amount"] as? String
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinanceCollectionViewCell", for: indexPath) as! FinanceCollectionViewCell
                if balancenofinanceCardDetailArray.count==0{
                if indexPath.item==0{
                    cell.balanceAmntLbl.isHidden=false
                    cell.balanceLbl.isHidden=false
                    cell.balanceLbl.text="Balance: "
                    cell.balanceAmntLbl.text="$ "+balance_Amount
                }else{
                    cell.balanceAmntLbl.isHidden=true
                    cell.balanceLbl.isHidden=true
                }
            }
                
//                cell.balanceAmntLbl.isHidden=true
//                cell.balanceLbl.isHidden=true
//                cell.balanceLblHeight.constant=0
//                cell.cardLblTopConstraint.constant=0
                
                cell.cardLbl.lineBreakMode = .byWordWrapping
                cell.cardLbl.sizeToFit()
                
                cell.cardNumberLbl.numberOfLines=0
                cell.cardNumberLbl.lineBreakMode = .byWordWrapping
                cell.cardNumberLbl.sizeToFit()
                
                cell.dollarLbl.numberOfLines=0
                cell.dollarLbl.lineBreakMode = .byWordWrapping
                cell.dollarLbl.sizeToFit()
                
                cell.amountLbl.numberOfLines=0
                cell.amountLbl.lineBreakMode = .byWordWrapping
                cell.amountLbl.sizeToFit()
                
                cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString(" #797B83").cgColor
                
                cell.dashedView.shapeLayer.lineWidth=1
                cell.dashedView.shapeLayer.lineDashPattern=[5,5]
                cell.cardLbl.text=balancefianceproviderForCollectionViewArray[indexPath.row].financeServiceProviderName
                cell.cardNumberLbl.text=balancefianceproviderForCollectionViewArray[indexPath.row].financePlanselected
                if balancefianceproviderForCollectionViewArray[indexPath.row].price==""{
                    cell.amountLbl.text="_ _"
                }else{
                    cell.amountLbl.text=balancefianceproviderForCollectionViewArray[indexPath.row].price
                }
                
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinanceCollectionViewCell", for: indexPath) as! FinanceCollectionViewCell
                
                
                return cell
            }
        }
    }
    func subString(from myString: NSString, length: Int)->String {
        let mystring=NSString(string: myString.trimmingCharacters(in: .whitespaces))
        let myNSRange = NSRange(location: mystring.length - length, length: length)
        print(myString.substring(with: myNSRange))
        return myString.substring(with: myNSRange)
    }
    
}
