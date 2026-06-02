//
//  ProductListSubTableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 05/05/23.
//

import UIKit

class ProductListSubTableViewCell: UITableViewCell {

    @IBOutlet weak var productNumberLbl: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var productColourNameLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
