//
//  CustomerServiceViewController.swift
//  RPA-P
//
//  Created by 이주성 on 8/18/24.
//

import UIKit

final class CustomerServiceViewController: UIViewController {
    
    lazy var customerServiceLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("customerServiceLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var companyNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1522-9821"
        label.textColor = .black
        label.font = .useFont(ofSize: 30, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var openTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "운영 시간 : 평일09:00 ~ 18:00 (토/일, 공휴일 휴무)"
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var lunchTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "점심 시간 : 평일12:00 ~ 13:00"
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton()
        button.setTitle("전화 걸기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(callButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var faqButton: UIButton = {
        let button = UIButton()
        button.setTitle("FAQ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .useRGB(red: 218, green: 218, blue: 218)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(faqButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setUpNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- CustomerServiceViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CustomerServiceViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.customerServiceLogoImageView,
            self.companyNumberLabel,
            self.openTimeLabel,
            self.lunchTimeLabel,
            self.callButton,
            self.faqButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // customerServiceLogoImageView
        NSLayoutConstraint.activate([
            self.customerServiceLogoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            self.customerServiceLogoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.customerServiceLogoImageView.heightAnchor.constraint(equalToConstant: 86),
            self.customerServiceLogoImageView.widthAnchor.constraint(equalToConstant: 86),
        ])
        
        // companyNumberLabel
        NSLayoutConstraint.activate([
            self.companyNumberLabel.topAnchor.constraint(equalTo: self.customerServiceLogoImageView.bottomAnchor, constant: 20),
            self.companyNumberLabel.centerXAnchor.constraint(equalTo: self.customerServiceLogoImageView.centerXAnchor)
        ])
        
        // openTimeLabel
        NSLayoutConstraint.activate([
            self.openTimeLabel.topAnchor.constraint(equalTo: self.companyNumberLabel.bottomAnchor, constant: 30),
            self.openTimeLabel.centerXAnchor.constraint(equalTo: self.companyNumberLabel.centerXAnchor),
        ])
        
        // lunchTimeLabel
        NSLayoutConstraint.activate([
            self.lunchTimeLabel.topAnchor.constraint(equalTo: self.openTimeLabel.bottomAnchor, constant: 5),
            self.lunchTimeLabel.centerXAnchor.constraint(equalTo: self.openTimeLabel.centerXAnchor),
        ])
        
        // callButton
        NSLayoutConstraint.activate([
            self.callButton.heightAnchor.constraint(equalToConstant: 50),
            self.callButton.widthAnchor.constraint(equalToConstant: 175),
            self.callButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
        
        // faqButton
        NSLayoutConstraint.activate([
            self.faqButton.heightAnchor.constraint(equalToConstant: 50),
            self.faqButton.widthAnchor.constraint(equalToConstant: 175),
            self.faqButton.topAnchor.constraint(equalTo: self.callButton.bottomAnchor, constant: 10),
            self.faqButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -25),
            self.faqButton.centerXAnchor.constraint(equalTo: self.callButton.centerXAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "고객센터"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension CustomerServiceViewController {
    
}

// MARK: - Extension for selector methods
extension CustomerServiceViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func callButton(_ sender: UIButton) {
        let url = "tel://1522-9821"
        
        if let openApp = URL(string: url), UIApplication.shared.canOpenURL(openApp) {
            // 버전별 처리
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(openApp)
                
            }
        }
        
        //외부앱 실행이 불가능한 경우
        else {
            print("[외부 앱 열기 실패]")
            print("주소 : \(url)")
            
        }
    }
    
    @objc func faqButton(_ sender: UIButton) {
        let vc = FAQViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
