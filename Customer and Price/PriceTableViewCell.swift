//
//  PriceTableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 28/04/23.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

   
    @IBOutlet weak var expressPriceLbl: UILabel!
    
    @IBOutlet weak var overstockpriceNameLbl: UILabel!
    @IBOutlet weak var expressPriceNameLbl: UILabel!
    
    @IBOutlet weak var overstockPriceLbl: UILabel!
    @IBOutlet weak var dashView: DashedView!
   
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var priceNameLbl: UILabel!
    var hideTopBorder: Bool = false
    var hideBottomBorder: Bool = false
    var bottomBorderLayer = CAShapeLayer()
    var leftBorderLayer = CAShapeLayer()
    var rightBorderLayer = CAShapeLayer()
    var topBorderLayer = CAShapeLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
//    override func draw(_ rect: CGRect) {
//            super.draw(rect)
//
//         leftBorderLayer = CAShapeLayer()
//               leftBorderLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: bounds.height)).cgPath
//               leftBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//               leftBorderLayer.lineWidth = 1.0
//               leftBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
//               layer.addSublayer(leftBorderLayer)
//
//               // Draw right border
//             rightBorderLayer = CAShapeLayer()
//               rightBorderLayer.path = UIBezierPath(rect: CGRect(x: bounds.width - 1, y: 0, width: 1, height: bounds.height)).cgPath
//               rightBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//               rightBorderLayer.lineWidth = 1.0
//               rightBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
//               layer.addSublayer(rightBorderLayer)
//
//               // Draw top border
//                topBorderLayer = CAShapeLayer()
//               topBorderLayer.path = UIBezierPath(rect: CGRect(x: 1, y: 0, width: bounds.width - 2, height: 1)).cgPath
//               topBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//               topBorderLayer.lineWidth = 1.0
//               topBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
//               layer.addSublayer(topBorderLayer)
//
//               // Draw bottom border
//               bottomBorderLayer = CAShapeLayer()
//               bottomBorderLayer.path = UIBezierPath(rect: CGRect(x: 1, y: bounds.height - 1, width: bounds.width - 2, height: 1)).cgPath
//        bottomBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
//               bottomBorderLayer.lineWidth = 1.0
//               bottomBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
//               layer.addSublayer(bottomBorderLayer)
//
//               topBorderLayer.isHidden = hideTopBorder
//               bottomBorderLayer.isHidden = hideBottomBorder
//           }
//       
//        
//    override func layoutSubviews() {
//           super.layoutSubviews()
//
//           // Update the position of the borders
////        leftBorderLayer = CAShapeLayer()
////              leftBorderLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: bounds.height)).cgPath
////              leftBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
////              leftBorderLayer.lineWidth = 1.0
////              leftBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
////              layer.addSublayer(leftBorderLayer)
////
////              // Draw right border
////        
////            rightBorderLayer = CAShapeLayer()
////              rightBorderLayer.path = UIBezierPath(rect: CGRect(x: bounds.width - 1, y: 0, width: 1, height: bounds.height)).cgPath
////              rightBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
////              rightBorderLayer.lineWidth = 1.0
////              rightBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
////              layer.addSublayer(rightBorderLayer)
////
////              // Draw top border
////        
////               topBorderLayer = CAShapeLayer()
////              topBorderLayer.path = UIBezierPath(rect: CGRect(x: 1, y: 0, width: bounds.width - 2, height: 1)).cgPath
////              topBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
////              topBorderLayer.lineWidth = 1.0
////              topBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
////              layer.addSublayer(topBorderLayer)
////
////              // Draw bottom border
////              bottomBorderLayer = CAShapeLayer()
////              bottomBorderLayer.path = UIBezierPath(rect: CGRect(x: 1, y: bounds.height - 1, width: bounds.width - 2, height: 1)).cgPath
////       bottomBorderLayer.strokeColor = UIColor().colorFromHexString("#304CCE").cgColor
////              bottomBorderLayer.lineWidth = 1.0
////              bottomBorderLayer.lineDashPattern = [6, 5] // Customize the dash pattern here
////              layer.addSublayer(bottomBorderLayer)
//
//              topBorderLayer.isHidden = hideTopBorder
//              bottomBorderLayer.isHidden = hideBottomBorder
//       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

