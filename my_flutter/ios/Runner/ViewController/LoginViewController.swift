//
//  ViewController.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 17/01/23.
//

import UIKit
import Flutter
import SVProgressHUD

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPassword : UITextField!
    @IBOutlet weak var btnLogin : UIButton!
    @IBOutlet weak var btnForgotPassword : UIButton!
    
    var isValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        ///Pegion setup
        LoginSetup.setUp(binaryMessenger: flutterEngine.binaryMessenger, api: self)
        
        //Sample user login
        //https://gorest.co.in/public/v2/users
        txtEmail.text = "msgr_tanushree_shukla@franecki.biz"
        txtEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        try? validateCredential(isValid: false)
    }
}

//Mark:- Login callback method
extension LoginViewController: Login{
    func validateCredential(isValid: Bool) throws {
        self.isValid = isValid
        btnLogin.isEnabled = self.isValid
    }
    
    
    func loginSuccess(user: User) throws {
        SVProgressHUD.dismiss()
        Router.navigateToDashboard()
    }
    
    func loginFailed(message: String) throws {
        SVProgressHUD.dismiss()
        showAlert(title: "Error", subTitle: message)
    }
}



//Mark:- Actions
extension LoginViewController{
    
    @objc func textFieldDidChange(){
        let data: [String: String] = [
            "email": txtEmail.text ?? "",
            "password": txtPassword.text ?? ""
        ]
        
        AppViewModel.shared.triggerFlutterMethod(action: .validateLoginCred, data: data)
    }
    
    @IBAction func btnLoginClick(){
        self.view.endEditing(true)
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .loginClick)
    }
    
    @IBAction func btnForgotPasswordClick(){
        
    }
}
