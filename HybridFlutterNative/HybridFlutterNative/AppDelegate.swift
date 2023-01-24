//
//  AppDelegate.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 17/01/23.
//

import UIKit
import Flutter
import FlutterPluginRegistrant


@main
class AppDelegate: FlutterAppDelegate {

    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")


    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        
        let appConfig:[String : String] = [
            "env": "development",
            "api": "api",
            "iosAppId":"1234567890",
            "androidPackageName":"com.bytes.hitesh"
        ]
        
        AppViewModel.shared.triggerFlutterMethod(action: .appConfig,data: appConfig)
        
        // Override point for customization after application launch.
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

