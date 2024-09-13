//
//  LoginViewController.swift
//  RPA-P
//
//  Created by 이주성 on 9/13/24.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    lazy var authenticationGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호"
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var authenticationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.numberView, self.authenticationNumberView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "연락처를 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var sendAuthenticationNumberButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("인증번호 보내기", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.backgroundColor = .useRGB(red: 255, green: 232, blue: 232)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sendAuthenticationNumberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var numberButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(numberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var failedCertificationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = false
        imageView.image = .useCustomImage("failedCertification")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var authenticationNumberView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var authenticationNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호를 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var authenticationNumberTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var completeAuthenticationButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("인증 완료", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.backgroundColor = .useRGB(red: 255, green: 232, blue: 232)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(completeAuthenticationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var authenticationNumberButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(authenticationNumberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var nameLabelTopAnchorConstraint: NSLayoutConstraint!
    var numberLabelTopAnchorConstraint: NSLayoutConstraint!
    var authenticationNumberLabelTopAnchorConstraint: NSLayoutConstraint!
    
    var isAuthenticated: Bool = false
    var verificationID: String = ""
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.numberTextField.resignFirstResponder()
        self.authenticationNumberTextField.resignFirstResponder()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- LoginViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension LoginViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        self.numberTextField.becomeFirstResponder()
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
            self.authenticationGuideLabel,
            self.authenticationStackView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.numberLabel,
            self.numberTextField,
            self.numberButton,
            self.sendAuthenticationNumberButton,
        ], to: self.numberView)
        
        SupportingMethods.shared.addSubviews([
            self.authenticationNumberLabel,
            self.authenticationNumberTextField,
            self.authenticationNumberButton,
            self.completeAuthenticationButton,
        ], to: self.authenticationNumberView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // authenticationGuideLabel
        NSLayoutConstraint.activate([
            self.authenticationGuideLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.authenticationGuideLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
        ])
        
        // authenticationStackView
        NSLayoutConstraint.activate([
            self.authenticationStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.authenticationStackView.topAnchor.constraint(equalTo: self.authenticationGuideLabel.bottomAnchor, constant: 10),
            self.authenticationStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
        ])
        
        // numberView
        NSLayoutConstraint.activate([
            self.numberView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // numberLabel
        self.numberLabelTopAnchorConstraint = self.numberLabel.topAnchor.constraint(equalTo: self.numberView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor, constant: 15),
            self.numberLabelTopAnchorConstraint
        ])
        
        // numberTextField
        NSLayoutConstraint.activate([
            self.numberTextField.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor),
            self.numberTextField.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor),
            self.numberTextField.bottomAnchor.constraint(equalTo: self.numberView.bottomAnchor, constant: -5),
            self.numberTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // sendAuthenticationNumberButton
        NSLayoutConstraint.activate([
            self.sendAuthenticationNumberButton.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor, constant: -10),
            self.sendAuthenticationNumberButton.centerYAnchor.constraint(equalTo: self.numberView.centerYAnchor),
            self.sendAuthenticationNumberButton.widthAnchor.constraint(equalToConstant: 109),
            self.sendAuthenticationNumberButton.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        // numberButton
        NSLayoutConstraint.activate([
            self.numberButton.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor),
            self.numberButton.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor),
            self.numberButton.bottomAnchor.constraint(equalTo: self.numberView.bottomAnchor),
            self.numberButton.topAnchor.constraint(equalTo: self.numberView.topAnchor),
        ])
        
        // authenticationNumberView
        NSLayoutConstraint.activate([
            self.authenticationNumberView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // authenticationNumberLabel
        self.authenticationNumberLabelTopAnchorConstraint = self.authenticationNumberLabel.topAnchor.constraint(equalTo: self.authenticationNumberView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.authenticationNumberLabel.leadingAnchor.constraint(equalTo: self.authenticationNumberView.leadingAnchor, constant: 15),
            self.authenticationNumberLabelTopAnchorConstraint,
        ])
        
        // authenticationNumberTextField
        NSLayoutConstraint.activate([
            self.authenticationNumberTextField.leadingAnchor.constraint(equalTo: self.authenticationNumberView.leadingAnchor),
            self.authenticationNumberTextField.trailingAnchor.constraint(equalTo: self.authenticationNumberView.trailingAnchor),
            self.authenticationNumberTextField.bottomAnchor.constraint(equalTo: self.authenticationNumberView.bottomAnchor, constant: -5),
            self.authenticationNumberTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // completeAuthenticationButton
        NSLayoutConstraint.activate([
            self.completeAuthenticationButton.trailingAnchor.constraint(equalTo: self.authenticationNumberView.trailingAnchor, constant: -10),
            self.completeAuthenticationButton.centerYAnchor.constraint(equalTo: self.authenticationNumberView.centerYAnchor),
            self.completeAuthenticationButton.widthAnchor.constraint(equalToConstant: 78),
            self.completeAuthenticationButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // authenticationNumberButton
        NSLayoutConstraint.activate([
            self.authenticationNumberButton.leadingAnchor.constraint(equalTo: self.authenticationNumberView.leadingAnchor),
            self.authenticationNumberButton.trailingAnchor.constraint(equalTo: self.authenticationNumberView.trailingAnchor),
            self.authenticationNumberButton.bottomAnchor.constraint(equalTo: self.authenticationNumberView.bottomAnchor),
            self.authenticationNumberButton.topAnchor.constraint(equalTo: self.authenticationNumberView.topAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension LoginViewController {
    
}

// MARK: - Extension for selector methods
extension LoginViewController {
    @objc func numberButton(_ sender: UIButton) {
        self.numberTextField.becomeFirstResponder()
        
    }
    
    @objc func hideKeyboard(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
//            self.logoImageViewTopAnchorConstraint.constant = 0
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
//            self.logoImageViewTopAnchorConstraint.constant = 80
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func sendAuthenticationNumberButton(_ sender: UIButton) {
        guard let phoneNumber = self.numberTextField.text else {
            SupportingMethods.shared.showAlertNoti(title: "핸드폰 번호를 입력해주세요.")
            return
        }
        SupportingMethods.shared.turnCoverView(.on)
        PhoneAuthProvider.provider().verifyPhoneNumber("+82 \(phoneNumber)", uiDelegate: nil)
        { verificationID, error in
            if let error = error {
                print(error.localizedDescription)
                SupportingMethods.shared.turnCoverView(.off)
                return
                
            } else {
                print("verificationID: \(verificationID ?? "")")
                self.verificationID = verificationID ?? ""
                SupportingMethods.shared.turnCoverView(.off)
                self.sendAuthenticationNumberButton.setTitle("다시 보내기", for: .normal)
                
                self.failedCertificationImageView.isHidden = true
                self.authenticationNumberView.isHidden = false
                
            }
            
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
            
        } completion: { finished in
            
        }
    }
    
    @objc func authenticationNumberButton(_ sender: UIButton) {
        self.authenticationNumberTextField.becomeFirstResponder()
        
    }
    
    @objc func completeAuthenticationButton(_ sender: UIButton) {
        guard let verificationCode = self.authenticationNumberTextField.text else {
            SupportingMethods.shared.showAlertNoti(title: "인증번호를 입력해 주세요.")
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationID, verificationCode: verificationCode)
        
        SupportingMethods.shared.turnCoverView(.on)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                SupportingMethods.shared.turnCoverView(.off)
                SupportingMethods.shared.showAlertNoti(title: "인증번호가 틀렸습니다.")
                print("Auth Error: \(error.localizedDescription)")
                return
                
            } else {
                SupportingMethods.shared.turnCoverView(.off)
                self.numberButton.isEnabled = false
                self.numberTextField.isEnabled = false
                
                self.sendAuthenticationNumberButton.isEnabled = false
                
                self.authenticationNumberTextField.isEnabled = false
                self.completeAuthenticationButton.isEnabled = false
                
                self.completeAuthenticationButton.backgroundColor = .useRGB(red: 231, green: 231, blue: 231)
                self.completeAuthenticationButton.setTitleColor(.white, for: .normal)
                
                self.isAuthenticated = true
                guard let uid = authResult?.user.uid else { return }
                guard let phoneNumber = authResult?.user.phoneNumber else { return }
                print(uid)
                print(phoneNumber)
                ReferenceValues.uid = uid
                ReferenceValues.phoneNumber = self.numberTextField.text ?? phoneNumber
                
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: Notification.Name("LoginDone"), object: nil)
                }
                
                return
            }
        }
    }
}

// MARK: - Extension for UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.numberTextField {
            UIView.transition(with: self.view, duration: 0.1) {
                self.numberView.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor

                self.numberLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.numberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)

                self.numberLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
            
        } else {
            UIView.transition(with: self.view, duration: 0.1) {
                self.authenticationNumberView.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor

                self.authenticationNumberLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.authenticationNumberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)

                self.authenticationNumberLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
            
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.numberTextField {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.numberView.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor

                    self.numberLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.numberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)

                    self.numberLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        } else {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.authenticationNumberView.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor

                    self.authenticationNumberLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.authenticationNumberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)

                    self.authenticationNumberLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = self.authenticationNumberTextField.text else { return false }
        let length = text.count
        
        // backspace 허용
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
                
        // 글자수 제한
        if length > 5 {
            return false
        }

        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.numberTextField.text != "" {
            self.sendAuthenticationNumberButton.isHidden = false
            
            if self.authenticationNumberTextField.text != "" {
                self.completeAuthenticationButton.isHidden = false
                
            } else {
                self.completeAuthenticationButton.isHidden = true
                
            }
            
        } else {
            self.sendAuthenticationNumberButton.isHidden = true
            
        }
        
    }
}
