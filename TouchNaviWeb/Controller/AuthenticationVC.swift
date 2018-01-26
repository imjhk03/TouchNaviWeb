//
//  AuthenticationVC.swift
//  Touchy
//
//  Created by Joo Hee Kim on 2018. 1. 14..
//  Copyright © 2018년 Joo Hee Kim. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationVC: UIViewController {
    
    static func instantiate() -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthenticationVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isJailbroken = detectJailBreak()
        
        if isJailbroken {
            print("it is jailbroken!")
            
            let alertVC = UIAlertController(title: "Error", message: "탈옥한 기기에서는 앱을 실행할 수 없습니다!", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "끄기", style: .default, handler: { (action: UIAlertAction!) in
                print("끄기 눌렀어!!")
                exit(1)
            }))
            
            self.present(alertVC, animated: true, completion: nil)
            
//            authenticationMethod()
        } else {
            print("no it is not jailbroken!")
            
//            let alertVC = UIAlertController(title: "Error", message: "탈옥한 기기에서는 앱을 실행할 수 없습니다!", preferredStyle: .alert)
//
//            alertVC.addAction(UIAlertAction(title: "끄기", style: .default, handler: { (action: UIAlertAction!) in
//                print("끄기 눌렀어!!")
//                exit(1)
//            }))
//
//            self.present(alertVC, animated: true, completion: nil)
            
            authenticationMethod()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useTouchIDButtonWasPressed(_ sender: Any) {
        authenticationMethod()
    }
    
    
    func authenticationMethod() {
        let authenticationContext = LAContext()
        var error: NSError?
        
        // .deviceOwnerAuthenticationWithBiometrics  -> 반드시 터치 아이디로만 인증하게 하는 것
        // .deviceOwnerAuthentication -> 터치 아이디 또는 기기 패스워드로 인증하게 하는 것
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Touch ID, navigating to success VC, handling errors
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "앱을 이용하려면 터치 ID로 로그인하세요.", reply: { (success, error) in
                if success {
//                    print("Activated AuthenticationVC")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
//                        print("dismiss AuthenticationVC")
                    }
                } else {
                    
                    if let error = error as NSError? {
                        // Display an error of a specific type
//                        var errorMessage = error.code
                        
                        if error.code == LAError.userCancel.rawValue {
                            // do nothing
                        } else {
                            let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                            self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
                        }
//
//                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
//                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
                    }
                }
            })
        } else {
            showAlertViewForNoBiometrics()
            return
        }
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage(message: String) {
        showAlertWithTitle(title: "Error", message: message)
    }
    
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "애플리케이션에 의해 취소되었습니다."
            
        // 계속해서 잘못된 지문 인식을 할 경우 생기는 에러
        case LAError.authenticationFailed.rawValue:
            message = "유효하지 않는 지문을 인식하였습니다."
            
        case LAError.invalidContext.rawValue:
            message = "The context is invaled"
            
        case LAError.passcodeNotSet.rawValue:
            message = "기기에 암호가 설정되어 있지 않습니다."
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        // 너무 많은 실패 시도
        case LAError.touchIDLockout.rawValue:
            message = "실패한 시도가 너무 많습니다. 잠시 후에 이용하시길 바랍니다."
            
        // 시뮬레이터로 테스트할 시 아래 케이스 주석 처리
        case LAError.touchIDNotAvailable.rawValue:
            message = "해당 기기는 Touch ID를 지원하지 않습니다."
            
        // 암호를 입력하는 초기 창에서 홈버튼 눌렀을때
//        case LAError.userCancel.rawValue:
//            message = "(홈버튼) 취소 눌렀습니다."
            
        // 터치 아이디 실패 후, 암호 입력하는 부분을 선택할 경우 -> 기기 패스워드를 입력할 경우
        case LAError.userFallback.rawValue:
            message = "기기 패스워드를 허용하지 않습니다. 터치 아이디로만 이용 가능합니다."
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
    
    func navigateToAuthenticatedVC() {
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "LoggedInVC") {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(loggedInVC, animated: true)
            }
        }
    }
    
    func navigateToMainVC() {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC") {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }
    
    func navigateToMainNC() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainVC")
        let navigationController = UINavigationController(rootViewController: mainVC!)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func showAlertViewForNoBiometrics() {
        showAlertWithTitle(title: "Error", message: "해당 기기는 Touch ID를 지원하지 않습니다.")
    }
    
    func showAlertWithTitle(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // 탈옥한 기기인지 테스트하는 함수
    func detectJailBreak() -> Bool{
        if TARGET_IPHONE_SIMULATOR != 1
        {
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!)
                // -canOpenURL: failed for URL: "cydia://package/com.example.package" - error: "This app is not allowed to query for scheme cydia"
                // 위 에러는 탈옥하지 않는 기기 또는 시뮬레이터에서 발생하는 에러로, 탈옥한 기기에서는 정상적으로 작동이 됨. 걱정할 필요가 없음.
            {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do
            {
                try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                //Device is jailbroken
                return true
            }catch
            {
                return false
            }
        }else
        {
            return false
        }
    }

}

