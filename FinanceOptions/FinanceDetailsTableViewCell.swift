//
//  FinanceDetailsTableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 13.04.2023.
//

import UIKit
protocol CollectionViewCellDelegate{
    func editcollectionView(editAction: Bool, index: Int, didTappedIncollectionViewcell: Int,financeTypeSelected:String,financeAmount:String)
    func deleteCollectionView(deleteAction: Bool, index: Int, didTappedIncollectionViewcell: Int)
    func editCardcollectionView(editCardAction: Bool, index: Int, didTappedIncollectionViewcell: Int,nofinanceTypeSelected:[String:Any],isFromBalanceVc:Bool)
    func deleteCardCollectionView(deleteAction: Bool, index: Int, didTappedIncollectionViewcell: Int,isFromBalanceVc:Bool)
    // other delegate methods that you can define to perform action in viewcontroller
}
class FinanceDetailsTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var financenofinanceheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var finance_nofinanceLbl: UILabel!
    @IBOutlet weak var addBtninsideCollectionViewWidthConstarint: NSLayoutConstraint!
    @IBOutlet weak var addInsidecolletionViewBtn: UIButton!
    @IBOutlet weak var addBtnViewoutsidecollectionView: UIView!
    @IBOutlet weak var addBtnViewIncollectionView: UIView!
    @IBOutlet weak var collectionviewCellUnhideBtn: UIButton!
    @IBOutlet weak var financeTypeCollectionView: UICollectionView!
   // var fianceproviderForCollectionViewArray=[String]()
    var fianceproviderForCollectionViewArray=[FinanceProvider]()
    var nofinanceCardDetailArray=[[String:Any]]()
    var cellDelegate: CollectionViewCellDelegate?
    var amountEnteredLblArray=[String]()
    var editActionTappedIndex=Int()
    var finance_selected=Int()
    var isFromBalanceVc=Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        financeTypeCollectionView.delegate=self
        financeTypeCollectionView.dataSource=self
        financeTypeCollectionView.register(UINib(nibName: "AddFinanceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddFinanceCollectionViewCell")
        financeTypeCollectionView.register(UINib(nibName: "CardcheckDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardcheckDetailCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("nofinanceMode",nofinanceModel.cardCheckDetailArray)
        if isFromBalanceVc{
            nofinanceCardDetailArray=balanceNoFinanceSelectedModel.cardCheckDetailArray
        }else{
            nofinanceCardDetailArray=nofinanceModel.cardCheckDetailArray
        }
        if isFromBalanceVc{
            fianceproviderForCollectionViewArray=balanceNoFinanceSelectedModel.BalanceFinanceProviderArray
        }else{
            fianceproviderForCollectionViewArray=nofinanceModel.DepositFinanceProviderArray
        }
      //  if finance_selected==1{
        if section==0{
            return fianceproviderForCollectionViewArray.count
            
        }else{
            return nofinanceCardDetailArray.count
        }
//        return fianceproviderForCollectionViewArray.count+nofinanceCardDetailArray.count
    }
    
    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if indexPath.section==0{
            
            if  fianceproviderForCollectionViewArray.count==0{
                return CGSize(width: 0, height: 0)
            }else{
                return CGSize(width: 400, height: 110)
            }
        }else{
            return CGSize(width: 470, height: 110)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section==0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFinanceCollectionViewCell", for: indexPath) as! AddFinanceCollectionViewCell
            cell.financeProviderLbl.text=fianceproviderForCollectionViewArray[indexPath.row].financeServiceProviderName
            cell.editBtn.tag=indexPath.item
            cell.deleteBtn.tag=indexPath.item
            cell.editBtn.addTarget(self, action: #selector(editBtnAction(sender: )), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnAction(sender: )), for: .touchUpInside)
            cell.dollarlbl.isHidden=true
            cell.financeProviderleadingconstraint.constant=11
            
            cell.dollarlbl.isHidden=false
            if fianceproviderForCollectionViewArray[indexPath.row].price==""{
                cell.priceLbl.text="_ _"
            }else{
                cell.priceLbl.text=fianceproviderForCollectionViewArray[indexPath.row].price
            }
//            if amountEnteredLblArray.count>0{
//
//                if indexPath.item==editActionTappedIndex{
//                    if amountEnteredLblArray[editActionTappedIndex]==""{
//                        cell.priceLbl.text="_ _"
//                    }else{
//                        cell.priceLbl.text=amountEnteredLblArray[editActionTappedIndex]
//                    }
//
//                    if amountEnteredLblArray[editActionTappedIndex] != ""{
//                        cell.financeProviderleadingconstraint.constant=11
//                        cell.dollarlbl.isHidden=false
//                    }
//                }
////                else{
////                    cell.priceLbl.text="_ _"
////                    cell.dollarlbl.isHidden=false
////                }
//            }

            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardcheckDetailCollectionViewCell", for: indexPath) as! CardcheckDetailCollectionViewCell
            cell.cardtypeLbl.text=nofinanceCardDetailArray[indexPath.row]["cardType"] as? String
            cell.editBtn.tag=indexPath.item
            cell.deleteBtn.tag=indexPath.item
            cell.editBtn.addTarget(self, action: #selector(editBtnCardAction(sender: )), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnCardAction(sender: )), for: .touchUpInside)
            
           
            if nofinanceCardDetailArray[indexPath.row]["cardType"] as? String=="ACH"{
                
                cell.cardcheckNumberLbl.text=nofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? String
                
                cell.editBtn.isHidden=false
                cell.editbtnWidthconstant.constant=50
                
            }else{
                let substring=subString(from: (nofinanceCardDetailArray[indexPath.row]["creditCardNumber"] as? NSString ?? ""), length: 4)
                cell.cardcheckNumberLbl.text="**** "+substring
                cell.editBtn.isHidden=true
                cell.editbtnWidthconstant.constant=00
            }
            cell.cardCheckAmountLbl.text=nofinanceCardDetailArray[indexPath.row]["amount"] as? String
            return cell
        }
      }
    func subString(from myString: NSString, length: Int)->String {
        let mystring=NSString(string: myString.trimmingCharacters(in: .whitespaces))
        let myNSRange = NSRange(location: mystring.length - length, length: length)
        print(myString.substring(with: myNSRange))
        return myString.substring(with: myNSRange)
    }
    @objc func editBtnAction(sender:UIButton){
        self.cellDelegate?.editcollectionView(editAction: true, index: sender.tag, didTappedIncollectionViewcell: 0,financeTypeSelected:fianceproviderForCollectionViewArray[sender.tag].financeServiceProviderName ?? "",financeAmount:fianceproviderForCollectionViewArray[sender.tag].price)
    }
    @objc func deleteBtnAction(sender:UIButton){
        self.cellDelegate?.deleteCollectionView(deleteAction: true, index: sender.tag, didTappedIncollectionViewcell: 0)
    }
    
    @objc func editBtnCardAction(sender:UIButton){
        if isFromBalanceVc==true{
            self.cellDelegate?.editCardcollectionView(editCardAction: true, index: sender.tag, didTappedIncollectionViewcell: 0, nofinanceTypeSelected: nofinanceCardDetailArray[sender.tag],isFromBalanceVc:true)
        }else{
            self.cellDelegate?.editCardcollectionView(editCardAction: true, index: sender.tag, didTappedIncollectionViewcell: 0, nofinanceTypeSelected: nofinanceCardDetailArray[sender.tag],isFromBalanceVc:false)
        }
    }
    @objc func deleteBtnCardAction(sender:UIButton){
        if isFromBalanceVc==true{
            self.cellDelegate?.deleteCardCollectionView(deleteAction: true, index: sender.tag, didTappedIncollectionViewcell: 0, isFromBalanceVc: true)
        }else{
            self.cellDelegate?.deleteCardCollectionView(deleteAction: true, index: sender.tag, didTappedIncollectionViewcell: 0, isFromBalanceVc: false)
        }
    }
}
