//
//  ProductlistSubTestTableViewCell.swift
//  Express Home
//
//  Created by Anju on 10.02.2024.
//

import UIKit

class ProductlistSubTestTableViewCell: UITableViewCell {
    @IBOutlet weak var productNumberLbl: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
   
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
