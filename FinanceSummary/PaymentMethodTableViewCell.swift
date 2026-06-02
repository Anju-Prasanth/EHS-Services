//
//  PaymentMethodTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 27.04.2023.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionviewPaymentmethod: UICollectionView!
    var paymentmethodArray=["Credit Card","Debit Card","ACH"]
    var selectedindex=0
    var layout = UICollectionViewFlowLayout()
   // var paymentCell=PaymentMethodTableViewCell()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionviewPaymentmethod.delegate=self
        collectionviewPaymentmethod.dataSource=self
      
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionviewPaymentmethod.collectionViewLayout=layout
        
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionviewPaymentmethod.register(UINib(nibName: "PaymentMethodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PaymentMethodCollectionViewCell")
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return paymentmethodArray.count
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        
//        return CGSize(width: 250, height: 90)
//
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentMethodCollectionViewCell", for: indexPath) as! PaymentMethodCollectionViewCell
       
        
        
        cell.paymentMethodLbl.text=paymentmethodArray[indexPath.item]
        if indexPath.item==selectedindex{
            
            cell.selectionImageView.image=UIImage(named: "selected")
        }else{
            cell.selectionImageView.image=UIImage(named: "unSelected")
        }
       
        return cell
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        selectedindex=indexPath.item
        collectionviewPaymentmethod.reloadData()
        
    }
   
}
