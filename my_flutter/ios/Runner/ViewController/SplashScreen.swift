//
//  SplashScreen.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 20/01/23.
//

import UIKit
import SVProgressHUD

class SplashScreen: BaseViewController {
    let splashInteractor = SplashInteractor(binaryMessenger: flutterEngine.binaryMessenger)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        SplashSetup.setUp(binaryMessenger: flutterEngine.binaryMessenger, api: self)
        SVProgressHUD.setBackgroundColor(.black)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show()
        splashInteractor.getAuthStatus(completion: {})                
    }
}

//Mark:- Login callback method
extension SplashScreen: Splash {
    func onAuthStatusChange(isLogin: Bool) throws {
        if isLogin {
            Router.navigateToDashboard()
        }else{
            Router.navigateToLogin()
        }
    }
}
