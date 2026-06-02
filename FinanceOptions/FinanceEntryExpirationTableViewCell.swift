//
//  FinanceEntryExpirationTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 17.04.2023.
//

import UIKit

class FinanceEntryExpirationTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var dollarLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var AmntTxtfld: UITextField!
    @IBOutlet weak var datePickerBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        AmntTxtfld.setLeftPaddingPoints(25)
        AmntTxtfld.delegate=self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == AmntTxtfld {
            let allowedCharacters = CharacterSet(charactersIn:"+.0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
}
