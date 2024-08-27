//
//  SplashViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit
import Gifu

final class SplashViewController: UIViewController {
    
    lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("Splash")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var gifImageView: GIFImageView = {
        let imageView = GIFImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var guideTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "간편한\n원 터치 견적"
        label.font = .useFont(ofSize: 30, weight: .Bold)
        label.numberOfLines = 2
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.setLineSpacing(spacing: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "원하시는 견적을 옵션별로 바로 비교할 수 있어요.\nRPA-P로 예약하지 않아도 분명 도움이 될 거에요!"
        label.numberOfLines = 0
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.setLineSpacing(spacing: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
            self.splashImageView,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.gifImageView,
            self.guideTitleLabel,
            self.guideLabel,
        ], to: self.baseView)
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
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // gifImageView
        NSLayoutConstraint.activate([
            self.gifImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 140),
            self.gifImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.gifImageView.heightAnchor.constraint(equalToConstant: 300),
            self.gifImageView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        // guideTitleLabel
        NSLayoutConstraint.activate([
            self.guideTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 30),
            self.guideTitleLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.guideTitleLabel.topAnchor.constraint(equalTo: self.gifImageView.bottomAnchor, constant: 100),
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 30),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.guideLabel.topAnchor.constraint(equalTo: self.guideTitleLabel.bottomAnchor, constant: 10),
        ])
        

    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setPermission() {
        SupportingMethods.shared.requestNotificationPermission {
            print("CallBack")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if ReferenceValues.isLaunchedBefore {
                    let mainVC = CustomizedNavigationController(rootViewController: MainViewController())
                    
                    mainVC.modalTransitionStyle = .crossDissolve
                    mainVC.modalPresentationStyle = .fullScreen
                    
                    self.present(mainVC, animated: true)
                    
                } else {
                    self.baseView.isHidden = false
                    self.gifImageView.animate(withGIFNamed: "Splash", loopCount: 1, animationBlock:  {
                        let mainVC = CustomizedNavigationController(rootViewController: MainViewController())
                        
                        mainVC.modalTransitionStyle = .crossDissolve
                        mainVC.modalPresentationStyle = .fullScreen
                        
                        self.present(mainVC, animated: true) {
                            ReferenceValues.isLaunchedBefore = true
                            
                        }
                        
                    })
                    
                }
                
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
