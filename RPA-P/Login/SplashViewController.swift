//
//  SplashViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("Splash")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
        self.setPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- SplashViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension SplashViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        
    }
    
    func initializeObjects() {
        ReferenceValues.firstVC = self
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.splashImageView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // splashImageView
        NSLayoutConstraint.activate([
            self.splashImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.splashImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.splashImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.splashImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setPermission() {
        SupportingMethods.shared.requestNotificationPermission {
            print("CallBack")
            DispatchQueue.main.async {
                let mainVC = CustomizedNavigationController(rootViewController: MainViewController())
                
                mainVC.modalTransitionStyle = .crossDissolve
                mainVC.modalPresentationStyle = .fullScreen
                
                self.present(mainVC, animated: true)
                
            }
            
        }
        
    }
}

// MARK: - Extension for methods added
extension SplashViewController {
    
}

// MARK: - Extension for selector methods
extension SplashViewController {
    
}
