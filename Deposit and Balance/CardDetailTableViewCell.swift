//
//  CardDetailTableViewCell.swift
//  Express Home
//
//  Created by Anju on 01.06.2023.
//

import UIKit
import DropDown

class CardDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var requiredfieldnameLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var requiredfieldHeadingHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var requiredFieldnameLbl: UILabel!
    @IBOutlet weak var requiredFieldheadingLabel: UILabel!
    @IBOutlet weak var amntTexyFld: UITextField!
    @IBOutlet weak var CvvTxtFld: UITextField!
    @IBOutlet weak var ExpiretionDateTxtFld: UITextField!
    @IBOutlet weak var creditCardTxtFld: UITextField!
    @IBOutlet weak var AcntHolderTxtFld: UITextField!
    
    @IBOutlet weak var yearTxtFld: UITextField!
    @IBOutlet weak var dropdownBtn: UIButton!
    var dropDown = DropDown()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        AcntHolderTxtFld.setLeftPaddingPoints(25)
        ExpiretionDateTxtFld.setLeftPaddingPoints(20)
        creditCardTxtFld.setLeftPaddingPoints(25)
        CvvTxtFld.setLeftPaddingPoints(25)
        amntTexyFld.setLeftPaddingPoints(57)
        ExpiretionDateTxtFld.textAlignment = .center
        // Configure the view for the selected state
    }
    
    
}
