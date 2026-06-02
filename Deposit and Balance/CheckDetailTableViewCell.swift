//
//  CheckDetailTableViewCell.swift
//  Express Home
//
//  Created by Anju on 01.06.2023.
//

import UIKit

class CheckDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var AcntnumberTxtFld: UITextField!
    
    
    @IBOutlet weak var headingtopLblTopconstraint: NSLayoutConstraint!
    
    
   
    @IBOutlet weak var enterACHDetailLblHeight: NSLayoutConstraint!
    @IBOutlet weak var enterAcHDetailsLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var amntTxtFld: UITextField!
    @IBOutlet weak var routeNumberTxtFld: UITextField!
    @IBOutlet weak var cardnumberTxtFld: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        AcntnumberTxtFld.setLeftPaddingPoints(25)
        routeNumberTxtFld.setLeftPaddingPoints(25)
        cardnumberTxtFld.setLeftPaddingPoints(25)
        amntTxtFld.setLeftPaddingPoints(57)
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
