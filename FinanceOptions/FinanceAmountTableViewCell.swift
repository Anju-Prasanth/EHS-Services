//
//  FinanceAmountTableViewCell.swift
//  EHS_Sales
//
//  Created by Anjuon 13.04.2023.
//

import UIKit

class FinanceAmountTableViewCell: UITableViewCell {

    @IBOutlet weak var balanceAmountLbl: UILabel!
    @IBOutlet weak var depositAmountLbl: UILabel!
    @IBOutlet weak var remainingamountLblwidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var remainingAmountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
