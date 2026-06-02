//
//  InstructionViewController.swift
//  EHS_Sales
//
//  Created by Anju on 11/04/23.
//

import UIKit

class InstructionViewController: UIViewController {
    static func initialization() -> InstructionViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "InstructionViewController") as? InstructionViewController
    }
    @IBOutlet weak var instructionTextView: UITextView!
    
    @IBOutlet weak var getMeasurementsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 5)
        navigationController?.navigationBar.isHidden=true
        self.setNavigationBarbacklogoResetAndNext(name: "Instructions")
        getMeasurementsBtn.isEnabled = true
        getMeasurementsBtn.backgroundColor = UIColor().colorFromHexString("#F2F3F5")
        getMeasurementsBtn.borderColor = UIColor().colorFromHexString("#304CCE")
        getMeasurementsBtn.borderWidth = 2
        getMeasurementsBtn.setTitleColor(UIColor().colorFromHexString("#304CCE"), for: .normal)
        
    }
    override func viewWillAppear(_ animated: Bool){
//        refreshMSALToken()
       // platformViewDidLoadSetup()
       // UserDefaults.standard.set(false, forKey: "isFromAppointmentList")
    }
    override func performSegueToReturnBack(){
        let customerandprice = CustomerListViewController.initialization()!
        
        self.navigationController?.pushViewController(customerandprice, animated: true)
    }
    
    @IBAction func GotoMeasurementsBtnClicked(_ sender: UIButton)
    {
        getMeasurementsBtn.backgroundColor = UIColor().colorFromHexString("#F2F3F5")
        getMeasurementsBtn.borderColor = UIColor().colorFromHexString("#304CCE")
        getMeasurementsBtn.borderWidth = 2
        getMeasurementsBtn.setTitleColor(UIColor().colorFromHexString("#304CCE"), for: .normal)
        getMeasurementsBtn.isEnabled = true
        if let urlScheme = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] {
            if let urlSchemeValue = urlScheme.first?["CFBundleURLSchemes"] as? [String] {
               // if let url = URL(string: "\(urlSchemeValue.first!)" + "://")
                 
                    if UIApplication.shared.canOpenURL(URL(string: "measureSquareMobile://")!)
                    {
                        UIApplication.shared.open(URL(string: "measureSquareMobile://")!, options: [:], completionHandler: nil)
                    }
                    else
                    {
                        let appStoreURL = URL(string: "http://apps.apple.com/in/app/measuresquare-mobile/id845027391")
                        UIApplication.shared.open(appStoreURL!, options: [:], completionHandler: nil)
                    }
                

            }
        }
    }
    
    @IBAction func getMeasurementsBtnClicked(_ sender: UIButton)
    {
        let importProjectVC = ImportProjectsViewController.initialization()!

        self.navigationController?.pushViewController(importProjectVC, animated: true)
     
    }
}
