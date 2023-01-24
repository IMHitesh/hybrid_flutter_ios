//
//  File.swift
//
//
//  Created by Hitesh Surani on 16/01/23.
//

import Foundation
import SVProgressHUD

protocol LoginDelegate: BaseViewModelDelegate {
    func onLoginSuccess()    
}

class LoginViewModel: BaseViewModel{
    
    var delegate: LoginDelegate?
    var isValid = false
    var isLoading = true
    
    override init() {
        super.init()
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    func onLoginClick(){
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .loginClick)
    }
    
    func validateEmailPassword(email: String?, password: String?){
        let data: [String: String] = [
            "email": email ?? "",
            "password": password ?? ""
        ]
        AppViewModel.shared.triggerFlutterMethod(action: .validateLoginCred, data: data)
    }
}

///Callback from the flutter
extension LoginViewModel{
    func validateEmailPasswordResponse(data: [String: Any] ){
        if let isValidInput = data["is_valid"] as? Bool{
            isValid = isValidInput
            delegate?.reload()
        }
    }
    
    func onLoginClickResponse(data: [String: Any]){
        SVProgressHUD.dismiss()
        if let isLoggedIn = data["is_login"] as? Bool{
            if isLoggedIn {
                delegate?.onLoginSuccess()
            }else{
                let message: String = data["message"] as? String ?? ""
                delegate?.onFail(message: message)
            }
        }
    }
}
