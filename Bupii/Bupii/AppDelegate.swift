//
//  AppDelegate.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 03/05/2025.
//

import UIKit
import GoogleSignIn
import TalsecRuntime

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        TalsecConfigure.sharedObjc.initializeTalsec()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
