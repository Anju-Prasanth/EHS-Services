//
//  CardcheckCollectionViewCell.swift
//  Express Home
//
//  Created by Anju on 06.07.2023.
//

import UIKit

class CardcheckCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardLblTopconstraint: NSLayoutConstraint!
    @IBOutlet weak var depositLblHeight: NSLayoutConstraint!
    @IBOutlet weak var dollarlbl: UILabel!
    @IBOutlet weak var depositAmountLbl: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var cardNumberLbl: UILabel!
    @IBOutlet weak var cardLbl: UILabel!
    @IBOutlet weak var dashedView: DashedView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
