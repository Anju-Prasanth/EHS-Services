//
//  FinanceDetailsEntryTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 14.04.2023.
//

import UIKit

class FinanceDetailsEntryTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var dollarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var amntLblTrailingconstraint: NSLayoutConstraint!
    @IBOutlet weak var dollarLbl: UILabel!
    @IBOutlet weak var amountLblTrailing: NSLayoutConstraint!
    @IBOutlet weak var placeholderTextLbl: UILabel!
    @IBOutlet weak var amountTxtFld: UITextField!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var headingLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        amountTxtFld.delegate=self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == amountTxtFld {
            let allowedCharacters = CharacterSet(charactersIn:"+.0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
}
