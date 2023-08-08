//
//  AppDelegate.swift
//  WebKitCleanUp-Example
//
//  Created by Hoang Nguyen on 8/8/23.
//

import UIKit
import WebKitCleanUp

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    lazy var webKitCleanUp: WebKitCleanUp = {
        return WebKitCleanUpImp(webKitCleanUpConfig: WebKitCleanUpConfig(cleanUpEnabled: true, cleanUpDuration: 60))
     }()
     
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerWebKitCleanUpOnBackgroundTask(taskIdentifier: "", types: [.disk]) // Please update taskIdentifier
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func registerWebKitCleanUpOnBackgroundTask(taskIdentifier: String, types: [WebKitCacheType]) {
        guard #available(iOS 13.0, *) else { return }
        let bgScheduler = WebKitCleanUpBackgroundScheduler(webKitCleanUp: webKitCleanUp)
        bgScheduler.registerBackgroundTask(taskIdentifier: taskIdentifier, cacheTypes: types)
    }
    
}

