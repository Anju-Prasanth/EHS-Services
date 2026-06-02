//
//  ProductListTableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 05/05/23.
//

import UIKit
protocol YourTableViewCellDelegate: AnyObject {
    func didSelectValue(value: Int)
}
class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productlisttableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var productListTableView: UITableView!
    var projectSelectIndex=Int()
    @IBOutlet weak var roomNameLbl: UILabel!
    var productList=[Products]()
    var requiredHeight=Int()
    var delegare:YourTableViewCellDelegate!
    var labelHeights: [IndexPath: CGFloat] = [:]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        projectSelectIndex=UserDefaults.standard.value(forKey: "projectSelectedIndex") as? Int ?? 0
        
       
        productListTableView.dataSource = self
        productListTableView.delegate = self
        productListTableView.register(UINib(nibName: "ProductListSubTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListSubTableViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ProductListTableViewCell : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return 2
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListSubTableViewCell") as! ProductListSubTableViewCell
        cell.productNameLbl.sizeToFit()
        cell.productNameLbl.lineBreakMode = .byWordWrapping
        cell.productNameLbl.numberOfLines=0
        let string1 = "\(indexPath.row + 1). Product:  "
//        cell.productNumberLbl.text=string1
       // let string2 = "Tile"
        let string2 = productList[indexPath.row].name ?? ""
        var myMutableString = NSMutableAttributedString()
        
        let attr1 = [NSAttributedString.Key.font : UIFont(name: "PublicSans-Regular", size: 24.0)!, NSAttributedString.Key.foregroundColor : UIColor().colorFromHexString("#34353C")]
        let attr2 = [NSAttributedString.Key.font : UIFont(name: "PublicSans-Bold", size: 24.0)!, NSAttributedString.Key.foregroundColor : UIColor().colorFromHexString("#304CCE")]
        //myMutableString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Poppins-Regular", size: 14.0)!])
        let attributeString1 = NSMutableAttributedString(string: string1, attributes: attr1)
        let attributeString2 = NSMutableAttributedString(string: string2, attributes: attr2)
        attributeString1.append(attributeString2)
        myMutableString = attributeString1

        //att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor().colorFromHexString("#72C36F"), range: NSRange(location: string1.count, length: string2.count)
        
        cell.productNameLbl.attributedText = myMutableString
        if indexPath.row == productList.count-1
        {
            cell.bottomLineView.isHidden = true
        }
        
//        let contentWidth = cell.productNameLbl.frame.width // Specify the width available for the label
//        requiredHeight = Int(cell.productNameLbl.height(forWidth: contentWidth))
//        print("Required Height:", requiredHeight)
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableView.automaticDimension
    }
    
    
}
