//
//  CustomerDetail2TableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 27.03.2023.
//

import UIKit

class CustomerDetail2TableViewCell: UITableViewCell {

   
    @IBOutlet weak var crossstreetTxtFld: UITextField!
    @IBOutlet weak var gatecodeTxtFld: UITextField!
    @IBOutlet weak var zipTxtfld: UITextField!
    @IBOutlet weak var stateTxtfld: UITextField!
    @IBOutlet weak var citytxtFld: UITextField!
    @IBOutlet weak var lastNameTxtfld: UITextField!
    @IBOutlet weak var mddlenameTxtfld: UITextField!
    @IBOutlet weak var firstNameTxtfld: UITextField!
    @IBOutlet weak var streetTxtfld: UITextField!
    @IBOutlet weak var homephoneTxtFld: UITextField!
    @IBOutlet weak var emailTxtfld: UITextField!
    @IBOutlet weak var contactNumberTxtfld: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    @IBOutlet weak var addcustomer2DetailsBtn: UIButton!
    @IBOutlet weak var addcustmeRImageView: UIImageView!
   
    @IBOutlet weak var coapplicantLastName: UITextField!
    @IBOutlet weak var coapplicantMiddleName: UITextField!
    @IBOutlet weak var coapplicantFirstName: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
