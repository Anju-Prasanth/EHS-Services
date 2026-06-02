//
//  CommisionTierTableViewCell.swift
//  Express Home
//
//  Created by Anju on 23.08.2023.
//

import UIKit

class CommisionTierTableViewCell: UITableViewCell {

    @IBOutlet weak var commissionEstimateLbl: UILabel!
    @IBOutlet weak var cellTappedBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var topviewHeight: NSLayoutConstraint!
    @IBOutlet weak var commisionTierLbl: UILabel!
    @IBOutlet weak var saleAmountLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var selectionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
