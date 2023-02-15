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
    
    private init(){
        
    }
    
    func triggerFlutterMethod(action: Action, channelName: String = "com.bytes.fast", data: Dictionary<String, Any>? = nil){
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
