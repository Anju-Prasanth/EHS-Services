//
//  SelectPaymentTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 12.04.2023.
//

import UIKit

class SelectPaymentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var checkBtn: UIButton!
   
    @IBOutlet weak var financeBtn: UIButton!
    
    @IBOutlet weak var selectpaymentOptionLbl: UILabel!
    @IBOutlet weak var creditCardBtn: UIButton!
    @IBOutlet weak var financeView: UIView!
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var dashedViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newoverstockPriceLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var newoverstockpriceLbl: UILabel!
    @IBOutlet weak var inclusiveallTaxesView: UIView!
   
    @IBOutlet weak var financeImageView: UIImageView!
    @IBOutlet weak var noFinanceImageView: UIImageView!
   
   
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var dashedView: DashedView!
    
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var financeOptionLbl: UILabel!
    var financetype=Int()
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
        
        
    }
}
extension UIView{
func addDashedBorder() {

    let color = UIColor.red.cgColor
    let shapeLayer = CAShapeLayer()
    let frameSize = self.bounds.size
    let shapeRect = CGRect(x:0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.frame = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 3
//    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [100,100]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
}
}
    
        
       // drawDottedLine(start: CGPoint(x: dashedView.bounds.minX, y: dashedView.bounds.minY), end: CGPoint(x: dashedView.bounds.minX, y: dashedView.bounds.maxY), view: dashedView, color: UIColor().colorFromHexString("#304CCE"))
    
    

