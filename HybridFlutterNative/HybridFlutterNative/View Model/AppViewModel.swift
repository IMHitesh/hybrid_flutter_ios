//
//  MethodChannelHandler.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 18/01/23.
//

import Foundation
import Flutter


enum Action: String {
    case appConfig
    case loginClick
    case validateLoginCred
    case logoutClick
    case getAuthStatus
    case getDashboardData
    case countDownInit
    case timerPauseOrChangeOrPause
}

class AppViewModel {
    
    static let shared = AppViewModel()
    
    var arrObserver: [BaseViewModel] = []
    
    
    private init(){
        setupFlutterCallBackHandler()
    }
    
    private func setupFlutterCallBackHandler(){
        if let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine{
            let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            let batteryChannel = FlutterMethodChannel(name: "com.bytes.fast",
                                                      binaryMessenger: flutterViewController.binaryMessenger)
            batteryChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                self.handleFlutterCallback(method: call)
            })
        }
    }
    
    private func handleFlutterCallback(method: FlutterMethodCall){
        let action = Action(rawValue: method.method)
        print(method.method)
        
        switch action {
        case .loginClick:
            onLoginClickResponse(method)
        case .validateLoginCred:
            validateLoginCred(method)
            break
        case .logoutClick:
            onLogoutClickResponse(method)
            break
        case .appConfig:
            print("No callback required")
            break
        case .getDashboardData:
            getDashboardDataResponse(method)
            break
        case .getAuthStatus:
            onAuthStatusResponse(method)
            break
        case .countDownInit:
            timerStartOrChangeOrPause(method)
            break
        case .timerPauseOrChangeOrPause:
            timerStartOrChangeOrPause(method)
            break
        case .none:
            print("Method is not handled")
        }
        
    }
    
    
    func triggerFlutterMethod(action: Action, channelName: String = "com.bytes.fast", data: Dictionary<String, Any>? = nil){
        if let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine{
            let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            let channel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
            
            var convertedString: String? = nil
            
            if let data = data {
                do {
                    let dataFormat =  try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                    convertedString = String(data: dataFormat, encoding: String.Encoding.utf8)
                } catch let myJSONError {
                    print("Json conversion error: \(myJSONError)")
                }
            }
            print(action.rawValue)
            channel.invokeMethod(action.rawValue, arguments: convertedString)
        }
    }
}

//Mark:- LoginViewModel
extension AppViewModel{
    fileprivate func validateLoginCred(_ method: FlutterMethodCall) {
        if let data = method.arguments as? [String: Any]{
            let loginViewModel = arrObserver.find(_obj: LoginViewModel.self)
            loginViewModel?.validateEmailPasswordResponse(data: data)
        }
    }
    
    fileprivate func onLoginClickResponse(_ method: FlutterMethodCall) {
        if let data = method.arguments as? [String: Any]{
            let loginViewModel = arrObserver.find(_obj: LoginViewModel.self)
            loginViewModel?.onLoginClickResponse(data: data)
        }
    }
    
    fileprivate func onAuthStatusResponse(_ method: FlutterMethodCall) {
        if let data = method.arguments as? [String: Any]{
            let splashViewModel = arrObserver.find(_obj: SplashViewModel.self)
            splashViewModel?.onAuthStatusResponse(data: data)
        }
    }
}

//Mark:- Dashboard
extension AppViewModel {
    
    private func onLogoutClickResponse(_ method: FlutterMethodCall) {
        if let data = method.arguments as? [String: Any]{
            let dashboardViewModel = arrObserver.find(_obj: DashboardViewModel.self)
            dashboardViewModel?.onLogoutSuccess(data: data)
        }
    }
    
    private func getDashboardDataResponse(_ method: FlutterMethodCall) {
        if let data = method.arguments as? [String: Any]{
            let dashboardViewModel = arrObserver.find(_obj: DashboardViewModel.self)
            dashboardViewModel?.getDashboardDataResponse(data: data)
        }
    }
}

//MARK:- Counter
extension AppViewModel {
    private func timerStartOrChangeOrPause(_ method: FlutterMethodCall) {
        if let data = method.arguments as? [String: Any]{
            let counterViewModel = arrObserver.find(_obj: CounterViewModel.self)
            counterViewModel?.onTimerStartOrChangeResponse(data: data)
        }
    }
}
