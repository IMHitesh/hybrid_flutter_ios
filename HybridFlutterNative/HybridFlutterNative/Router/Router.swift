//
//  Router.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 19/01/23.
//

import UIKit
let APP_DELEGATE: AppDelegate = UIApplication.shared.delegate as! AppDelegate


class Router {
    static var storyboard: UIStoryboard!
    static var navigation: UINavigationController!
    
    static func navigateToDashboard(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle:nil)
        storyboard = mainStoryboard
        let authNavigation = storyboard.instantiateViewController(withIdentifier: "DashboardRoutes") as? UINavigationController
        navigation = authNavigation
        UIApplication.shared.keyWindow?.rootViewController = navigation
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    static func navigateToLogin(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle:nil)
        storyboard = mainStoryboard
        let dashboard = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        UIApplication.shared.keyWindow?.rootViewController = dashboard
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    static func navigateToCounterScreen(){
        let counter = storyboard.instantiateViewController(withIdentifier: "CounterVC") as! CounterVC
        navigation.pushViewController(counter, animated: true)
    }
}
