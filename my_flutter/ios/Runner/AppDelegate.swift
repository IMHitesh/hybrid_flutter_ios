//
//  AppDelegate.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 17/01/23.
//

import UIKit
import Flutter
//import FlutterPluginRegistrant


var flutterEngine = FlutterEngine(name: "my flutter engine")

@main
class AppDelegate: FlutterAppDelegate {
        
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with:flutterEngine)            

        // Override point for customization after application launch.
        Router.splashScreen()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
