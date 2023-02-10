//
//  SplashScreen.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 20/01/23.
//

import UIKit

class SplashScreen: BaseViewController {
    
    lazy var viewModel = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        viewModel.delegate = self
        viewModel.getAuthStatus()
    }
}

//Mark:- Login callback method
extension SplashScreen: SplashDelegate{
    func onAuthStatusResponse(isLoggedIn: Bool){        
        if isLoggedIn {
            Router.navigateToDashboard()
        }else{
            Router.navigateToLogin()
        }
    }
}
