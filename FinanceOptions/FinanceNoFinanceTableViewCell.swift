//
//  FinanceNoFinanceTableViewCell.swift
//  Express Home
//
//  Created by Anju on 10.11.2023.
//

import UIKit


protocol financeNoFinanceCellDelegate{
    func NofinanceSelected(requiredFields: [RequiredFields],headingName:String,finance_selected:Int,financePaymentTypeId:Int)
    func financeSelected(finance_selected:Int)
        
    }
class FinanceNoFinanceTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    

    @IBOutlet weak var financeNoFinanceCollectionView: UICollectionView!
    var financenofinanceArray=[FinanceProvider]()
    var nofinancedelegate:financeNoFinanceCellDelegate!
    var financeSelected=Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        financeNoFinanceCollectionView.delegate=self
        financeNoFinanceCollectionView.dataSource=self
        financeNoFinanceCollectionView.register(UINib(nibName: "FinanceNoFinanceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FinanceNoFinanceCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return financenofinanceArray.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinanceNoFinanceCollectionViewCell", for: indexPath) as! FinanceNoFinanceCollectionViewCell
        
        cell.OuterView.cornerRadius=8
        cell.OuterView.borderWidth=2
        
        cell.OuterView.borderColor=UIColor().colorFromHexString("#304CCE")
        cell.OuterView.backgroundColor=UIColor().colorFromHexString("#FFFFFF")
        
        if indexPath.row==financenofinanceArray.count{
            cell.OuterView.cornerRadius=8
            cell.OuterView.borderWidth=2
            cell.financeServiceProviderNameLbl.text="+"+"Finance"
            cell.financeServiceProviderSelectionBtn.tag=indexPath.item
            cell.financeServiceProviderSelectionBtn.addTarget(self, action: #selector(noFinanceSelectedAction(sender: )), for: .touchUpInside)
            financeSelected=1
        }else{
            
            cell.financeServiceProviderNameLbl.text="+"+(financenofinanceArray[indexPath.item].financeServiceProviderName ?? "")
            cell.financeServiceProviderSelectionBtn.tag=indexPath.item
            cell.financeServiceProviderSelectionBtn.addTarget(self, action: #selector(noFinanceSelectedAction(sender: )), for: .touchUpInside)
            financeSelected=0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

            return CGSize(width: 290, height: 80)
        }
    
    @objc func noFinanceSelectedAction(sender:UIButton){
        if sender.tag==financenofinanceArray.count{
            self.nofinancedelegate.financeSelected(finance_selected:financeSelected)
        }else{
            self.nofinancedelegate.NofinanceSelected(requiredFields: financenofinanceArray[sender.tag].requiredFields ?? [],headingName:financenofinanceArray[sender.tag].financeServiceProviderName ?? "",finance_selected:financeSelected,financePaymentTypeId:financenofinanceArray[sender.tag].financePaymentTypeId ?? 0)
        }
    }
    @objc func FinanceSelectedAction(sender:UIButton){
        self.nofinancedelegate.financeSelected(finance_selected:financeSelected)
    }
}
