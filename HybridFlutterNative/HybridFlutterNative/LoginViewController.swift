//
//  ViewController.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 17/01/23.
//

import UIKit
import Flutter

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPassword : UITextField!
    @IBOutlet weak var btnLogin : UIButton!
    @IBOutlet weak var btnForgotPassword : UIButton!
    
    lazy var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        //Sample user login
        //https://gorest.co.in/public/v2/users
        txtEmail.text = "ii_khanna_amarnath@wuckert.com"
        txtEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        reload()
        viewModel.delegate = self
    }
}


//Mark:- Actions
extension LoginViewController{
    
    @objc func textFieldDidChange(){
        viewModel.validateEmailPassword(email: txtEmail.text, password: txtPassword.text)
    }
    
    @IBAction func btnLoginClick(){
        self.view.endEditing(true)
        viewModel.onLoginClick()
    }
    
    @IBAction func btnForgotPasswordClick(){
        
    }
}

//Mark:- Login callback method
extension LoginViewController: LoginDelegate{
    func onLoginSuccess() {
        Router.navigateToDashboard()
        viewModel.removeObserver()
    }
    
    func onFail(message: String) {
        showAlert(title: "Error", subTitle: message)
    }
    
    func reload(){
        btnLogin.isEnabled = viewModel.isValid
    }
}
