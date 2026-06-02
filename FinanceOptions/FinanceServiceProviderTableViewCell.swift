//
//  FinanceServiceProviderTableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 14.04.2023.
//

import UIKit

class FinanceServiceProviderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var financeProviderSelctionBtn: UIButton!
    @IBOutlet weak var financeProviderLbl: UILabel!
    @IBOutlet weak var financeproviderSelectImageview: UIImageView!
   
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
