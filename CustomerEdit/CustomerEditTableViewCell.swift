//
//  CustomerEditTableViewCell.swift
//  EHS_Sales
//
//  Created by Anju on 04.04.2023.
//

import UIKit

class CustomerEditTableViewCell: UITableViewCell {

    
    @IBOutlet weak var locationTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var customeremailLblHeight: NSLayoutConstraint!
    @IBOutlet weak var cityNameLblheightConstraint: NSLayoutConstraint!//31
    @IBOutlet weak var cityLblHeightConstraint: NSLayoutConstraint!//31
    @IBOutlet weak var gatecodeViewHeightConstraint: NSLayoutConstraint!//47
    @IBOutlet weak var customercellPhoneLblheightConstraint: NSLayoutConstraint!//46.5
    @IBOutlet weak var customerLocationLblHeightConstraint: NSLayoutConstraint!//46.5
    @IBOutlet weak var zipNameLbl: UILabel!
    @IBOutlet weak var zipLbl: UILabel!
    @IBOutlet weak var zipView: UIView!
    @IBOutlet weak var stateNameLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var customerEmailAdressLbl: UILabel!
    @IBOutlet weak var customerHomePhoneLbl: UILabel!
    @IBOutlet weak var customerHomePhoneImageView: UIImageView!
    @IBOutlet weak var crossStreetLbl: UILabel!
    @IBOutlet weak var crossStreetView: UIView!
    @IBOutlet weak var gateCodeLbl: UILabel!
    @IBOutlet weak var gateCodeView: UIView!
    @IBOutlet weak var customerCellphoneLbl: UILabel!
    @IBOutlet weak var customerCellPhoneImageView: UIImageView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var customerLocation: UILabel!
    @IBOutlet weak var customerlocationImageview: UIImageView!
    @IBOutlet weak var customernameLbl: UILabel!
    @IBOutlet weak var dashedView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var customerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        drawDottedLine(start: CGPoint(x: dashedView.bounds.minX, y: dashedView.bounds.minY), end: CGPoint(x: dashedView.bounds.minX, y: dashedView.bounds.maxY), view: dashedView, color: UIColor.lightGray)
        // Configure the view for the selected state
    }

}
