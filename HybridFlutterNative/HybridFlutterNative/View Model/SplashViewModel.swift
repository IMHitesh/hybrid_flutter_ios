//
//  SplashViewModel.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 20/01/23.
//

import Foundation
import SVProgressHUD


protocol SplashDelegate: BaseViewModelDelegate {
    func onAuthStatusResponse(isLoggedIn: Bool)
}

class SplashViewModel: BaseViewModel{
    var delegate: SplashDelegate?
    
    override init() {
        super.init()
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
    func getAuthStatus(){
        SVProgressHUD.setBackgroundColor(.black)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show()
        AppViewModel.shared.triggerFlutterMethod(action: .getAuthStatus)
    }
}

//MARK: Callback from the flutter
extension SplashViewModel {
    func onAuthStatusResponse(data: [String: Any]){
        SVProgressHUD.dismiss()
        if let isLoggedIn = data["is_login"] as? Bool{
            delegate?.onAuthStatusResponse(isLoggedIn: isLoggedIn)
        }else {
            delegate?.onAuthStatusResponse(isLoggedIn: false)
        }
    }
}
