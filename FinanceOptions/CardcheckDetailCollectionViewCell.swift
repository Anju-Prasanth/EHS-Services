//
//  CardcheckDetailCollectionViewCell.swift
//  Express Home
//
//  Created by Anju on 05.06.2023.
//

import UIKit

class CardcheckDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var editbtnWidthconstant: NSLayoutConstraint!
    @IBOutlet weak var cardCheckAmountLbl: UILabel!
    @IBOutlet weak var cardcheckNumberLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var cardtypeLbl: UILabel!
    @IBOutlet weak var cardnumberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
