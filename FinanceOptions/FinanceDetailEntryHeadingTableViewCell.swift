//
//  FinanceDetailEntryHeadingTableViewCell.swift
//  Express Home
//
//  Created by Anju on 20.11.2023.
//

import UIKit

class FinanceDetailEntryHeadingTableViewCell: UITableViewCell {

    @IBOutlet weak var balanceAmountLbl: UILabel!
    @IBOutlet weak var financeTypeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
