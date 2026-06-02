//
//  PromoTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 28.04.2023.
//

import UIKit
import DropDown
import AlignedCollectionViewFlowLayout

protocol VoucherDelegate{
    func collectionViewTapped(VoucherName: String, index: Int, voucherPrice:String)
    func promocodesdeleteAction(promoAddedFullArray: [PromotionalCodes],promArrayCollectionView:[String])
    

}

class PromoTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var retailPriceLbl: UILabel!
    @IBOutlet weak var imageViewprcntEditable: UIImageView!
    @IBOutlet weak var imageViewdollarEditable: UIImageView!
    @IBOutlet weak var discountPrcntTxtfld: UITextField!
    @IBOutlet weak var discountDollarTxtFld: UITextField!
    @IBOutlet weak var voucherCollectionView: UICollectionView!
    @IBOutlet weak var discountprcntLbl: UILabel!
    @IBOutlet weak var discountprcntPlusBtn: UIButton!
    @IBOutlet weak var discountprecntMinusBtn: UIButton!
    @IBOutlet weak var discountDollarLbl: UILabel!
    @IBOutlet weak var discountdollarPlusBtn: UIButton!
    @IBOutlet weak var discountdollarMinusBtn: UIButton!
    

    
    @IBOutlet weak var selectPrmoBtn: UIButton!

    @IBOutlet weak var topConstrntDiscntwithCollcctionView: NSLayoutConstraint!
    @IBOutlet weak var collectionviewPromoHeight: NSLayoutConstraint!
    var delegate: VoucherDelegate?
    var dropDown = DropDown()
    
    @IBOutlet weak var collectionviewPromocodes: UICollectionView!
    var promocodeArray=[String]()
    var promocodeArrayForCollectionView=[String]()
    var voucherArray=[PromoOffers]()
//    var voucherArray=["Travel voucher","Special Promo"]
    var selectedArray=["0","0"]
    var priceArray=["0","0"]
    var promoViewmodel=PromotionalofferViewModel()
    var layout=UICollectionViewFlowLayout()
    var layout1=UICollectionViewFlowLayout()
    var promoAddedFullArray=[PromotionalCodes]()
    var projectSelectIndex=Int()
    
    
       
    override func awakeFromNib() {
        super.awakeFromNib()
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
        
        if projects[projectSelectIndex].promoArray?.count ?? 0>0{
         
            promoAddedFullArray=projects[projectSelectIndex].promoAddedFullArray ?? []
        }
//        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
//        collectionviewPromocodes.collectionViewLayout = alignedFlowLayout
              
//        
//        layout1.itemSize = UICollectionViewFlowLayout.automaticSize
//        layout1.estimatedItemSize =  CGSize(width: 200, height: 70)
//        collectionviewPromocodes.collectionViewLayout=layout1
        voucherCollectionView.delegate=self
        voucherCollectionView.dataSource=self
        
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 420, height: 70)
        
        voucherCollectionView.collectionViewLayout=layout
        
        
        collectionviewPromocodes.delegate=self
        collectionviewPromocodes.dataSource=self
        collectionviewPromocodes.register(UINib(nibName: "PromoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PromoCollectionViewCell")
        voucherCollectionView.register(UINib(nibName: "voucherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "voucherCollectionViewCell")
       
          dropDown.anchorView = collectionviewPromocodes
        
        
        if promocodeArrayForCollectionView.count==0{
            collectionviewPromocodes.isHidden=true
        }else{
            collectionviewPromocodes.isHidden=false
        }
       
        dropDown.width = UIScreen.main.bounds.width-140
       // voucherCollectionView.reloadData()
//        let parameters=[String:Any]()
//        promoViewmodel.promo_offers(parameters: parameters) { success, promoOffers, message in
//            if success{
//            self.promotionalOffers(data: promoOffers ?? [])
//            }else{
//
//            }
//        }
    }
    
//    private func promotionalOffers(data: [PromoOffers]) {
//        print("data",data)
//        voucherArray=data
//        voucherCollectionView.reloadData()
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("voucherArray",voucherArray)
        if collectionView==collectionviewPromocodes{
            if promocodeArrayForCollectionView.count==0{
                collectionviewPromoHeight.constant=0
                topConstrntDiscntwithCollcctionView.constant=5
            }else{
                collectionviewPromocodes.isHidden=false
                collectionviewPromoHeight.constant=80
                topConstrntDiscntwithCollcctionView.constant=30
            }
            return promocodeArrayForCollectionView.count
        }else{
            return voucherArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         CGSize(width: 300, height: 70)
     }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        if collectionView==voucherCollectionView{
//            return CGSize(width: 270, height: 70)
//        }else{
//            return CGSize(width: 270, height: 70)
//        }
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView==collectionviewPromocodes{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCollectionViewCell", for: indexPath) as! PromoCollectionViewCell
            cell.promocodeLNbl.sizeToFit()
            cell.promocodeLNbl.text=promocodeArrayForCollectionView[indexPath.item]
            cell.promocodeappliedWidthconstraint.constant=195
            cell.deleteBtnwidthConstraint.constant=40
            cell.deleteBtn.tag=indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnAction(sender: )), for: .touchUpInside)
            cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString("#CBCCD5").cgColor
            
            if promocodeArrayForCollectionView.count==0{
                collectionviewPromoHeight.constant=0
                topConstrntDiscntwithCollcctionView.constant=5
            }else{
                collectionviewPromocodes.isHidden=false
                collectionviewPromoHeight.constant=80
                topConstrntDiscntwithCollcctionView.constant=30
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "voucherCollectionViewCell", for: indexPath) as! voucherCollectionViewCell
            
            
            cell.voucherNameLbl.text=voucherArray[indexPath.row].promoOfferName
            //if voucherArray[indexPath.row].price==""{
            if voucherArray[indexPath.row].isSelected==0{
                cell.selectionBtn.setImage(UIImage(named:"unSelected"), for: .normal)
                cell.voucherpriceLbl.isHidden=true
                cell.voucherdeleteBtnWidthConstraint.constant=0
                cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString("#D5D6DD").cgColor
                cell.dashedView.shapeLayer.lineDashPattern=[6,0]
            }else{
//                cell.voucherpriceLbl.numberOfLines=0
//                cell.voucherpriceLbl.lineBreakMode = .byWordWrapping
//                cell.voucherpriceLbl.sizeToFit()
                cell.selectionBtn.setImage(UIImage(named:"selected"), for: .normal)
                cell.voucherpriceLbl.isHidden=true
                cell.dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString("#CBCCD5").cgColor
                cell.voucherdeleteBtnWidthConstraint.constant=40
               // cell.voucherpriceLbl.text="$"+voucherArray[indexPath.row].price
                
//                if voucherArray[indexPath.row].price.contains("."){
//                    let amount1=voucherArray[indexPath.row].price.replacingOccurrences(of: ",", with: "")
//
//                    cell.voucherpriceLbl.text="$"+amount1.numberFormatter1(amount: amount1)
//                }else{
//                    let amount1=voucherArray[indexPath.row].price.replacingOccurrences(of: ".", with: "")
//                    let amount2=amount1.replacingOccurrences(of: ",", with: "")
//                    let amount3=String((amount2 as? NSString)?.integerValue ?? 0)
//                    cell.voucherpriceLbl.text="$"+amount3.numberFormatter(amount: amount3)
//                }
                
                
                
                cell.dashedView.shapeLayer.lineDashPattern=[5,5]
            }
            cell.voucherNameLbl.sizeToFit()
            cell.voucherNameLbl.numberOfLines=0
//            cell.voucherNameLbl.lineBreakMode = .byWordWrapping
           
            cell.selectionbtnWidthconstraint.constant=40
            cell.voucherlblLeadingConstraint.constant=10
            cell.dashedView.shapeLayer.lineWidth=1
            cell.selectionBtn.tag=indexPath.row
            cell.voucherDeleteBtn.tag=indexPath.row
            cell.selectionBtn.addTarget(self, action: #selector(selectionBtnAction(sender: )), for: .touchUpInside)
            cell.voucherDeleteBtn.addTarget(self, action: #selector(voucherDeleteBtnAction(sender: )), for: .touchUpInside)
            return cell
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if collectionView==voucherCollectionView{
            
            delegate?.collectionViewTapped(VoucherName: voucherArray[indexPath.item].promoOfferName ?? "", index: indexPath.item,voucherPrice:voucherArray[indexPath.item].price)
        }
        
    }
    @objc func  selectionBtnAction(sender:UIButton){
        delegate?.collectionViewTapped(VoucherName: voucherArray[sender.tag].promoOfferName ?? "", index: sender.tag,voucherPrice: voucherArray[sender.tag].price)
    }
    @objc func  voucherDeleteBtnAction(sender:UIButton){
        //voucherArray[sender.tag].price=""
        voucherArray[sender.tag].isSelected=0
        let index=IndexPath(item: sender.tag, section: 0)
        voucherCollectionView.reloadItems(at: [index])
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func deleteBtnAction(sender:UIButton){
        promocodeArrayForCollectionView.remove(at: sender.tag)
        promoAddedFullArray.remove(at: sender.tag)
       
//        discountDollarTxtFld.text=""
//        discountPrcntTxtfld.text=""
       // self.reloadInputViews()
       // collectionviewPromocodes.reloadData()
        delegate?.promocodesdeleteAction(promoAddedFullArray: promoAddedFullArray,promArrayCollectionView:promocodeArrayForCollectionView)
    }
    
}
