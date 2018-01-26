//
//  AppDelegate.swift
//  Touchy
//
//  Created by Joo Hee Kim on 2018. 1. 14..
//  Copyright © 2018년 Joo Hee Kim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        print("application shouldSaveApplicationState")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
//        showTouchIDVC()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
        showTouchIDVC()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDiDBecomeActive")
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate")
        
        clearCache()
    }
    
    // rootViewController 보여주기 전, Touch ID View Controller 보여주는 함수
    // rootViewController에서 Touch ID View Controller를 보여주는 방법.
    func showTouchIDVC() {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let authenticationVC : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "AuthenticationVC") as UIViewController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(authenticationVC, animated: true, completion: nil)
    }
    
    
    func clearCache() {
        print("Clear Cache")
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        print("Cleared Cache!!!!")
    }
    
    func clearCacheInSystem() {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                } catch let error as NSError {
                    debugPrint("Ooops! Something went wrong: \(error)")
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}
