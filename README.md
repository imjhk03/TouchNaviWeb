# TouchNaviWeb
Touch ID, Navigation Controller, WKWebview를 이용한 간단한 앱

## 기간
2017.10.26 - 2018.01.22

## 구분
기업 참여 프로젝트(앱 개발)

## 구현 목적
㈜thebrains 회사에서 클라이언트 기업용 인하우스 앱 개발에 참여하여 만든 앱을 기업 정보를 빼고 간단하게 구현해서 포트폴리오에 추가

## 기술 설명
- 기업용 관리자 앱으로, 아이패드 프로 12인치에 최적화되어 있습니다.
- 해당 버튼을 누르면 웹뷰를 통해 각각 웹사이트를 보여주는 앱입니다.
- 보안성을 위해 앱을 실행할 때마다 Touch ID를 통해 인증받아서 실행하게 했습니다.
- 앱 실행 시 탈옥한 기기인지 확인하는 작업을 추가했습니다.

## 구현 기술
- Navigation Controller를 이용하여 메인화면과 웹뷰화면 사이의 화면 전환을 구현했습니다.
- prepare 함수를 이용하여 segue의 identifier 값에 따라 보여줄 웹사이트 주소를 다르게 하여, 웹뷰 화면에서 해당하는 웹주소를 보여주도록 기능을 구현했습니다.
- LocalAuthentication을 import하고 canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics ...)를 이용해서 Touch ID를 인식하는 소스 구현했습니다.
- detectJailBreak() 함수를 추가하여 탈옥한 기기인지 확인해서 맞으면 앱을 종료하게끔 기능을 구현했습니다.
- in House 앱으로 빌드하여 웹페이지를 통해서 설치할 수 있도록 개발하였습니다. Ad Hoc 방식으로 앱 배포하는 과정은 개인 블로그에 정리했습니다.
(http://imjhk03.blog.me/221146943986)

## 스크린샷
![ScreenShot](https://user-images.githubusercontent.com/28954046/35428132-cc06570c-02b0-11e8-8408-b5994912c882.png)
