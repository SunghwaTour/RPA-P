//
//  ReservationTourTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/31/24.
//

import UIKit
import FirebaseAuth

final class ReservationTourTableViewCell: UITableViewCell {
    
    lazy var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 203, green: 203, blue: 203, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "예약자 정보"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bankTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "*입금 은행"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.asFontColor(targetString: "*", font: .useFont(ofSize: 14, weight: .Regular), color: .red)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bankTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "입금 은행을 입력해주세요.")
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var accountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "*계좌번호"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.asFontColor(targetString: "*", font: .useFont(ofSize: 14, weight: .Regular), color: .red)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accountTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "계좌번호를 입력해주세요.")
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "*입금자명"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.asFontColor(targetString: "*", font: .useFont(ofSize: 14, weight: .Regular), color: .red)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "입금자명을 입력해주세요.")
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var numberAuthenticationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호 인증"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var numberAuthenticationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.numberTextField, self.authenticationTextField, self.alertLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var numberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "*휴대폰 번호"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.asFontColor(targetString: "*", font: .useFont(ofSize: 14, weight: .Regular), color: .red)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "휴대폰 번호를 입력해주세요.")
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var sendAuthenticationButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증번호 보내기", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 2.0
        button.addTarget(self, action: #selector(sendAuthenticationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    lazy var authenticationTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "인증번호를 입력해주세요.")
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var doneAuthenticationButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("인증완료", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 2.0
        button.addTarget(self, action: #selector(doneAuthenticationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "인증번호를 보내드렸어요!"
        label.textColor = .red
        label.font = .useFont(ofSize: 10, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    var isAuthenticated: Bool = false
    var verificationID: String = ""
    
    let mainModel = MainModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCellFoundation()
        self.initializeViews()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: Extension for essential methods
extension ReservationTourTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
    }
    
    // Initialize views
    func initializeViews() {
        
    }
    
    // Set gestures
    func setGestures() {
        
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.topBorderView,
            self.infoTitleLabel,
            self.bankTitleLabel,
            self.bankTextField,
            self.accountTitleLabel,
            self.accountTextField,
            self.nameTitleLabel,
            self.nameTextField,
            self.numberAuthenticationTitleLabel,
            self.numberTitleLabel,
            self.numberAuthenticationStackView,
            self.sendAuthenticationButton,
            self.doneAuthenticationButton,
            self.failedCertificationImageView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // topBorderView
        NSLayoutConstraint.activate([
            self.topBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topBorderView.heightAnchor.constraint(equalToConstant: 5),
        ])
        
        // infoTitleLabel
        NSLayoutConstraint.activate([
            self.infoTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.infoTitleLabel.topAnchor.constraint(equalTo: self.topBorderView.bottomAnchor, constant: 30),
            self.infoTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // bankTitleLabel
        NSLayoutConstraint.activate([
            self.bankTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            self.bankTitleLabel.topAnchor.constraint(equalTo: self.infoTitleLabel.bottomAnchor, constant: 20),
            self.bankTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // bankTextField
        NSLayoutConstraint.activate([
            self.bankTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.bankTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.bankTextField.topAnchor.constraint(equalTo: self.bankTitleLabel.bottomAnchor, constant: 5),
            self.bankTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // accountTitleLabel
        NSLayoutConstraint.activate([
            self.accountTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            self.accountTitleLabel.topAnchor.constraint(equalTo: self.bankTextField.bottomAnchor, constant: 20),
            self.accountTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // accountTextField
        NSLayoutConstraint.activate([
            self.accountTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.accountTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.accountTextField.topAnchor.constraint(equalTo: self.accountTitleLabel.bottomAnchor, constant: 5),
            self.accountTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // nameTitleLabel
        NSLayoutConstraint.activate([
            self.nameTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            self.nameTitleLabel.topAnchor.constraint(equalTo: self.accountTextField.bottomAnchor, constant: 15),
            self.nameTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // nameTextField
        NSLayoutConstraint.activate([
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.nameTextField.topAnchor.constraint(equalTo: self.nameTitleLabel.bottomAnchor, constant: 5),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // numberAuthenticationTitleLabel
        NSLayoutConstraint.activate([
            self.numberAuthenticationTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.numberAuthenticationTitleLabel.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 30),
        ])
        
        // numberTitleLabel
        NSLayoutConstraint.activate([
            self.numberTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            self.numberTitleLabel.topAnchor.constraint(equalTo: self.numberAuthenticationTitleLabel.bottomAnchor, constant: 20),
        ])
        
        // numberAuthenticationStackView
        NSLayoutConstraint.activate([
            self.numberAuthenticationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.numberAuthenticationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.numberAuthenticationStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.numberAuthenticationStackView.topAnchor.constraint(equalTo: self.numberTitleLabel.bottomAnchor, constant: 5),
        ])
        
        // numberTextField
        NSLayoutConstraint.activate([
            self.numberTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // sendAuthenticationButton
        NSLayoutConstraint.activate([
            self.sendAuthenticationButton.trailingAnchor.constraint(equalTo: self.numberTextField.trailingAnchor, constant: -10),
            self.sendAuthenticationButton.centerYAnchor.constraint(equalTo: self.numberTextField.centerYAnchor),
            self.sendAuthenticationButton.widthAnchor.constraint(equalToConstant: 107),
            self.sendAuthenticationButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // authenticationTextField
        NSLayoutConstraint.activate([
            self.authenticationTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // doneAuthenticationButton
        NSLayoutConstraint.activate([
            self.doneAuthenticationButton.trailingAnchor.constraint(equalTo: self.authenticationTextField.trailingAnchor, constant: -10),
            self.doneAuthenticationButton.centerYAnchor.constraint(equalTo: self.authenticationTextField.centerYAnchor),
            self.doneAuthenticationButton.widthAnchor.constraint(equalToConstant: 107),
            self.doneAuthenticationButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // failedCertificationImageView
        NSLayoutConstraint.activate([
            self.failedCertificationImageView.leadingAnchor.constraint(equalTo: self.numberTextField.leadingAnchor, constant: 63),
            self.failedCertificationImageView.topAnchor.constraint(equalTo: self.numberTextField.bottomAnchor, constant: 7),
            self.failedCertificationImageView.widthAnchor.constraint(equalToConstant: 268),
            self.failedCertificationImageView.heightAnchor.constraint(equalToConstant: 38),
        ])
    }
}

// MARK: - Extension for methods added
extension ReservationTourTableViewCell {
    func setCell(myTour: MyTourItem?) {
        guard let myTour = myTour else { return }
        let bank = myTour.bank.split(separator: " ")
        
        self.bankTextField.text = String(bank[0])
        self.accountTextField.text = bank.count >= 2 ? String(bank[1]) : "계좌번호 없음"
        self.nameTextField.text = myTour.name
        self.numberTextField.text = myTour.phone
        
        self.bankTextField.isEnabled = false
        self.bankTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        self.accountTextField.isEnabled = false
        self.accountTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        self.nameTextField.isEnabled = false
        self.nameTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        self.numberTextField.isEnabled = false
        self.numberTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        
        self.failedCertificationImageView.isHidden = true
        
        self.sendAuthenticationButton.isEnabled = false
    }
}

// MARK: - Extension for selector added
extension ReservationTourTableViewCell {
    @objc func sendAuthenticationButton(_ sender: UIButton) {
        guard self.bankTextField.text != "" else {
            SupportingMethods.shared.showAlertNoti(title: "입금 은행을 입력해주세요.")
            return
        }
        guard self.accountTextField.text != "" else {
            SupportingMethods.shared.showAlertNoti(title: "계좌번호를 입력해주세요.")
            return
        }
        guard self.nameTextField.text != "" else {
            SupportingMethods.shared.showAlertNoti(title: "입금자명을 입력해주세요.")
            return
        }
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
                self.sendAuthenticationButton.setTitle("다시 보내기", for: .normal)
                
                self.authenticationTextField.isHidden = false
                self.doneAuthenticationButton.isHidden = false
                self.alertLabel.isHidden = false
                self.failedCertificationImageView.isHidden = true
                
                NotificationCenter.default.post(name: Notification.Name("reloadDataForDesgin"), object: nil)
                
                self.bankTextField.isEnabled = false
                self.bankTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                
                self.accountTextField.isEnabled = false
                self.accountTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                
                self.nameTextField.isEnabled = false
                self.nameTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            }
            
        }
    }
    
    @objc func doneAuthenticationButton(_ sender: UIButton) {
        guard let verificationCode = self.authenticationTextField.text else {
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
                self.numberTextField.isEnabled = false
                
                self.sendAuthenticationButton.isEnabled = false
                
                self.authenticationTextField.isEnabled = false
                self.authenticationTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                self.doneAuthenticationButton.isEnabled = false
                
                self.doneAuthenticationButton.backgroundColor = .useRGB(red: 255, green: 186, blue: 186)
                
                self.isAuthenticated = true
                guard let uid = authResult?.user.uid else { return }
                guard let phoneNumber = authResult?.user.phoneNumber else { return }
                print(uid)
                print(phoneNumber)
                ReferenceValues.uid = uid
                ReferenceValues.phoneNumber = self.numberTextField.text ?? phoneNumber
                ReferenceValues.name = self.nameTextField.text!
                
                self.numberTextField.isEnabled = false
                self.numberTextField.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                
                self.mainModel.registerUserData(uid: uid) {
                    print("PaymentViewController registerUserData Success")
                    var account = ""
                    if self.accountTextField.text!.contains("-") {
                        let tempString = self.accountTextField.text!.split(separator: "-")
                        for temp in tempString {
                            account += temp
                            
                        }
                        
                    } else {
                        account = self.accountTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                    }
                    
                    NotificationCenter.default.post(name: Notification.Name("reservationButtonOn"), object: nil, userInfo: ["bank": "\(self.bankTextField.text!.trimmingCharacters(in: .whitespaces)) \(account)", "name": self.nameTextField.text!])
                    
                } failure: { message in
                    print("error: \(message)")

                }
                
                return
            }
        }

    }
}
