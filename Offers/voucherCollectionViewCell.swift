//
//  voucherCollectionViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 02.05.2023.
//

import UIKit

class voucherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var voucherdeleteBtnWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var voucherDeleteBtn: UIButton!
    @IBOutlet weak var voucherlblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectionBtn: UIButton!
    @IBOutlet weak var selectionbtnWidthconstraint: NSLayoutConstraint!
    @IBOutlet weak var dashedView: DashedView!
   
    @IBOutlet weak var voucherpriceLbl: UILabel!
    @IBOutlet weak var voucherNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dashedView.shapeLayer.strokeColor=UIColor().colorFromHexString("#797B83").cgColor
    }

}
