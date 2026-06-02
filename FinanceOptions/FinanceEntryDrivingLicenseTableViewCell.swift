//
//  FinanceEntryDrivingLicenseTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju  on 17.04.2023.
//

import UIKit
import DropDown

class FinanceEntryDrivingLicenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var dropdownAnchorView: UIView!
    @IBOutlet weak var downArrowImageview: UIImageView!
    @IBOutlet weak var outerView: UIView!
    var dropDown = DropDown()
    @IBOutlet weak var selctstateTxtFld: UITextField!
    @IBOutlet weak var drorDownBtn: UIButton!
   // var array=["Plan#2739 – 120 Payments","Plan#7099 – 120 Payments"]
    override func awakeFromNib() {
        super.awakeFromNib()
       // drorDownBtn.setTitle("   Plan#2739 – 120 Payments", for: .normal)
        
        dropDown.width = outerView.frame.size.width+downArrowImageview.frame.size.width+20
//        dropDown.width = dropdownAnchorView.frame.size.width+70
       // dropDown.dataSource=array
    }

    @IBAction func dropdownAction(_ sender: Any) {
        dropDown.show()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
