//
//  Router.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 19/01/23.
//

import UIKit
let APP_DELEGATE: AppDelegate = UIApplication.shared.delegate as! AppDelegate


class Router {
    static var storyboard: UIStoryboard?
    
    static func navigateToDashboard(){
        let story = UIStoryboard(name: "Main", bundle:nil)
        let dashboard = story.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        UIApplication.shared.keyWindow?.rootViewController = dashboard
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    static func navigateToLogin(){
        let story = UIStoryboard(name: "Main", bundle:nil)
        let dashboard = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        UIApplication.shared.keyWindow?.rootViewController = dashboard
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
