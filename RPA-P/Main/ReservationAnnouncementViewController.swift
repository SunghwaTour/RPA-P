//
//  ReservationAnnouncementViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/18/24.
//

import UIKit

final class ReservationAnnouncementViewController: UIViewController {
    
    lazy var reservationConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "예약이 확정되었습니다"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var timerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var priceAnnouncementBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 248, blue: 248)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.estimate.virtualEstimate?.price.withCommaString ?? "0") 원"
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.asFontColor(targetString: "원", font: .useFont(ofSize: 14, weight: .Regular), color: .useRGB(red: 184, green: 0, blue: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var announcementLabel: UILabel = {
        let label = UILabel()
        label.text = "계약금은 전체 금액의 8%입니다.\n제한 시간 내 입금되어야 운행이 가능합니다."
        label.textColor = .useRGB(red: 115, green: 115, blue: 115)
        label.font = .useFont(ofSize: 11, weight: .Medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.asFontColor(targetString: "제한 시간 내 입금되어야 운행이 가능합니다.", font: .useFont(ofSize: 11, weight: .Regular), color: .useRGB(red: 184, green: 0, blue: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accountView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var accountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "성화투어 계좌번호"
        label.textColor = .useRGB(red: 138, green: 138, blue: 138)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "기업은행 331-011771-01-011"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인했습니다.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(checkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(estimate: Estimate) {
        self.estimate = estimate
        
        super.init(nibName: nil , bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var estimate: Estimate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- ReservationAnnouncementViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ReservationAnnouncementViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        
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
            self.reservationConfirmationLabel,
            self.timerView,
            self.priceAnnouncementBaseView,
            self.checkButton,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
        
        ], to: self.timerView)
        
        SupportingMethods.shared.addSubviews([
            self.priceLabel,
            self.announcementLabel,
            self.accountView,
        ], to: self.priceAnnouncementBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.accountTitleLabel,
            self.accountLabel,
        ], to: self.accountView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // reservationConfirmationLabel
        NSLayoutConstraint.activate([
            self.reservationConfirmationLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.reservationConfirmationLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26),
        ])
        
        // timerView
        NSLayoutConstraint.activate([
            self.timerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.timerView.topAnchor.constraint(equalTo: self.reservationConfirmationLabel.bottomAnchor, constant: 34),
            self.timerView.widthAnchor.constraint(equalToConstant: 112),
            self.timerView.heightAnchor.constraint(equalToConstant: 140),
        ])
        
        // priceAnnouncementBaseView
        NSLayoutConstraint.activate([
            self.priceAnnouncementBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17),
            self.priceAnnouncementBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17),
            self.priceAnnouncementBaseView.topAnchor.constraint(equalTo: self.timerView.bottomAnchor, constant: 34),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.priceAnnouncementBaseView.topAnchor, constant: 33),
            self.priceLabel.centerXAnchor.constraint(equalTo: self.priceAnnouncementBaseView.centerXAnchor),
        ])
        
        // announcementLabel
        NSLayoutConstraint.activate([
            self.announcementLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 5),
            self.announcementLabel.centerXAnchor.constraint(equalTo: self.priceAnnouncementBaseView.centerXAnchor),
        ])
        
        // accountView
        NSLayoutConstraint.activate([
            self.accountView.leadingAnchor.constraint(equalTo: self.priceAnnouncementBaseView.leadingAnchor, constant: 15),
            self.accountView.trailingAnchor.constraint(equalTo: self.priceAnnouncementBaseView.trailingAnchor, constant: -15),
            self.accountView.topAnchor.constraint(equalTo: self.announcementLabel.bottomAnchor, constant: 27),
            self.accountView.bottomAnchor.constraint(equalTo: self.priceAnnouncementBaseView.bottomAnchor, constant: -15),
        ])
        
        // accountTitleLabel
        NSLayoutConstraint.activate([
            self.accountTitleLabel.topAnchor.constraint(equalTo: self.accountView.topAnchor, constant: 17),
            self.accountTitleLabel.centerXAnchor.constraint(equalTo: self.accountView.centerXAnchor),
        ])
        
        // accountLabel
        NSLayoutConstraint.activate([
            self.accountLabel.topAnchor.constraint(equalTo: self.accountTitleLabel.bottomAnchor, constant: 8),
            self.accountLabel.centerXAnchor.constraint(equalTo: self.accountTitleLabel.centerXAnchor),
            self.accountLabel.bottomAnchor.constraint(equalTo: self.accountView.bottomAnchor, constant: -16),
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.widthAnchor.constraint(equalToConstant: 200),
            self.checkButton.heightAnchor.constraint(equalToConstant: 48),
            self.checkButton.topAnchor.constraint(equalTo: self.priceAnnouncementBaseView.bottomAnchor, constant: 50),
            self.checkButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension ReservationAnnouncementViewController {
    
}

// MARK: - Extension for selector methods
extension ReservationAnnouncementViewController {
    @objc func checkButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
}
