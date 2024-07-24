//
//  CheckPaymentViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/17/24.
//

import UIKit

final class CheckPaymentViewController: UIViewController {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "거래 방법 확인 후\n추후 입금자명을 작성해주세요."
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.asColor(targetString: "추후", color: .red)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var signTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 91, green: 91, blue: 91)
        textField.font = .useFont(ofSize: 30, weight: .Medium)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.useRGB(red: 133, green: 133, blue: 133).cgColor
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var doneBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 153, green: 153, blue: 153)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.useRGB(red: 0, green: 0, blue: 0, alpha: 0.87), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Regular)
        button.addTarget(self, action: #selector(cancelButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var centerBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 153, green: 153, blue: 153)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Medium)
        button.addTarget(self, action: #selector(checkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- CheckPaymentViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CheckPaymentViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBackground(_:)))
        self.backgroundView.addGestureRecognizer(backgroundTapGesture)
        self.backgroundView.isUserInteractionEnabled = true
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.backgroundView,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.guideLabel,
            self.signTextField,
            self.doneBaseView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.borderView,
            self.cancelButton,
            self.centerBorderView,
            self.checkButton,
        ], to: self.doneBaseView)
    }
    
    func setLayouts() {
//        let safeArea = self.view.safeAreaLayoutGuide
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 27.5),
            self.baseView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -27.5),
            self.baseView.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 87),
            self.baseView.heightAnchor.constraint(equalToConstant: 317),
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 32.5),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -32.5),
            self.guideLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 44),
        ])
        
        // signTextField
        NSLayoutConstraint.activate([
            self.signTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 35),
            self.signTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -35),
            self.signTextField.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 40),
            self.signTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // doneBaseView
        NSLayoutConstraint.activate([
            self.doneBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.doneBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.doneBaseView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.doneBaseView.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        // borderView
        NSLayoutConstraint.activate([
            self.borderView.leadingAnchor.constraint(equalTo: self.doneBaseView.leadingAnchor),
            self.borderView.trailingAnchor.constraint(equalTo: self.doneBaseView.trailingAnchor),
            self.borderView.topAnchor.constraint(equalTo: self.doneBaseView.topAnchor),
            self.borderView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        // cancelButton
        NSLayoutConstraint.activate([
            self.cancelButton.leadingAnchor.constraint(equalTo: self.doneBaseView.leadingAnchor),
            self.cancelButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width / 2 ) - 28.5),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // centerBorderView
        NSLayoutConstraint.activate([
            self.centerBorderView.trailingAnchor.constraint(equalTo: self.checkButton.leadingAnchor),
            self.centerBorderView.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor),
            self.centerBorderView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor),
            self.centerBorderView.bottomAnchor.constraint(equalTo: self.doneBaseView.bottomAnchor),
            self.centerBorderView.widthAnchor.constraint(equalToConstant: 2),
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.leadingAnchor.constraint(equalTo: self.centerBorderView.trailingAnchor),
            self.checkButton.trailingAnchor.constraint(equalTo: self.doneBaseView.trailingAnchor),
            self.checkButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width / 2 ) - 28.5),
            self.checkButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
        self.signTextField.becomeFirstResponder()
    }
}

// MARK: - Extension for methods added
extension CheckPaymentViewController {
    
}

// MARK: - Extension for selector methods
extension CheckPaymentViewController {
    @objc func tappedBackground(_ gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true)
        
    }
    
    @objc func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    @objc func checkButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("Signed Name: \(self.signTextField.text ?? "")")
            
        }
        
    }
}
