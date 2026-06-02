//
//  PriceDetailsTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 27.04.2023.
//

import UIKit

class PriceDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newOverstockpriceLbl: UILabel!
    @IBOutlet weak var balancePriceLbl: UILabel!
    @IBOutlet weak var depositPriceLbl: UILabel!
    @IBOutlet weak var overstockPriceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
