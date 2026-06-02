//
//  FinanceCollectionViewCell.swift
//  Express Home
//
//  Created by Anju on 06.07.2023.
//

import UIKit

class FinanceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var cardNumberLbl: UILabel!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var dashedView: DashedView!

    @IBOutlet weak var dashedViewtopconstraint: NSLayoutConstraint!
    @IBOutlet weak var dollarLbl: UILabel!
    @IBOutlet weak var balanceAmntLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    @IBOutlet weak var cardLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var balanceLblHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
