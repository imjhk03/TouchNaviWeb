//
//  MainVC.swift
//  Touchy
//
//  Created by Joo Hee Kim on 2018. 1. 15..
//  Copyright © 2018년 Joo Hee Kim. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let previousVC = AuthenticationVC.instantiate()
        
        self.present(previousVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        // segue 변수의 값(또는 태그 값)이 아래와 같으면,
        // webViewController 에 있는 변수 webSite 에 아래의 웹주소를 저장해줘!
        if segue.identifier == "ShowOperaWebView" {
            let webViewController = segue.destination
                as! WebViewVC
//            webViewController.webSite = "http://www.opera.com/ko"
            webViewController.webSite = "http://www.opera.com/ko"
        }
        if segue.identifier == "ShowGoogleWebView" {
            let webViewController = segue.destination
                as! WebViewVC
//            webViewController.webSite = "http://www.google.com"
            webViewController.webSite = "http://www.google.com"
        }
        if segue.identifier == "ShowiDBWebView" {
            let webViewController = segue.destination
                as! WebViewVC
//            webViewController.webSite = "http://www.idownloadblog.com"
            webViewController.webSite = "http://www.idownloadblog.com"
        }
        if segue.identifier == "ShowNaverWebView" {
            let webViewController = segue.destination
                as! WebViewVC
//            webViewController.webSite = "http://www.naver.com"
            webViewController.webSite = "http://www.naver.com"
        }
        if segue.identifier == "ShowDaumWebView" {
            let webViewController = segue.destination
                as! WebViewVC
//            webViewController.webSite = "https://www.daum.net/"
            webViewController.webSite = "https://www.daum.net"
        }
    }

}
