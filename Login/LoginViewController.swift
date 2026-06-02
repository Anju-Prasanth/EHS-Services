//
//  LoginViewController.swift
//  EHS_Sales
//
//  Created by Anju 21.03.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    static func initialization() -> LoginViewController? {
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
    }
    
   
    @IBOutlet weak var versionLbl: UIButton!
    
   
    @IBOutlet weak var loginBtn: UIButton!
   
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    

    var placeHolderColor=UIColor()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let veryText="Version: \(text)"+" - DEV"
            versionLbl.setTitle(veryText, for: .normal)
            print(text)
        }
        
        UserDefaults.standard.set(true, forKey: "isFromAppointmentList")
      //  placeHolderColor=UIColor().colorFromHexString("#304CCE")
        navigationController?.navigationBar.isHidden=true
//        emailTF.setPlaceHolderWithColor(placeholder: "Email Address", colour: UIColor().colorFromHexString("#354BC5"))
//        passwordTF.setPlaceHolderWithColor(placeholder: "Password", colour: UIColor().colorFromHexString("#354BC5"))
       // UserDefaults.standard.set(true, forKey: "isloggedOut")
        if UserDefaults.standard.value(forKey: "isloggedOut") as? Bool==true{
                    intializeMSAL(isfromLoggedOut: false)
        }
        
        
    }
    
    
    

    @IBAction func passwordHideBtnAction(_ sender: Any) {
        
        
    }
    

    

   
    @IBAction func loginBtnAction(_ sender: Any) {
        
     loginButtonAction()
        
     
        
    }
    

    


    
}
