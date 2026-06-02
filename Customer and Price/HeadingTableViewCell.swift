//
//  HeadingTableViewCell.swift
//  EHS_Sales
//
//  Created by Bincy C A on 28/04/23.
//

import UIKit

class HeadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customPriceBtn: UIButton!
    @IBOutlet weak var courtseyStackView: UIStackView!
    @IBOutlet weak var courtesyLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default
            .addObserver(self,
                         selector:#selector(globalTimerSetting(_:)),
                         name: NSNotification.Name ("com.user.globalTimer.success"),                                           object: nil)    }
    
    // GlobalTimer.expiryTimeInterval = 90
    
    @objc func globalTimerSetting(_ notification: Notification)
    {
        //courtesyLbl.text = MyGlobalTimer.sharedTimer.timerString
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
    
