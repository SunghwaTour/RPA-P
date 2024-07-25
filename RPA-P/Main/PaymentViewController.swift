//
//  PaymentViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit

final class PaymentViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .onDrag
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "\(estimate.virtualEstimate?.price ?? "0")원"
        label.font = .useFont(ofSize: 32, weight: .Bold)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "고객님의 예상 견적액입니다."
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var addressBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 243, blue: 243)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발"
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureAddressLabel: UILabel = {
        let label = UILabel()
        label.text = self.estimate.departure.name
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.adjustsFontSizeToFitWidth = true
        // label.numberOfLines = 2
        
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        // FIXME: 날짜 부분 로직 넣기
        label.text = "\(self.estimate.departureDate.date) (수)"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.estimate.departureDate.time)"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착"
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalAddressLabel: UILabel = {
        let label = UILabel()
        label.text = self.estimate.return.name
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.adjustsFontSizeToFitWidth = true
        // label.numberOfLines = 2
        
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.estimate.returnDate.date) (수)"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = self.estimate.returnDate.time
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var authenticationGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "예약을 위해 귀하의 정보를 입력해주세요."
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.borderStyle = .none
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var nameButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nameButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        button.addTarget(self, action: #selector(sendAuthenticationNumberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var authenticationNumberButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(authenticationNumberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var paymentMethodTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "향후 결제 방법을 선택해주세요!"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var paymentMethodTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "PaymentMethodTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var nameLabelTopAnchorConstraint: NSLayoutConstraint!
    var numberLabelTopAnchorConstraint: NSLayoutConstraint!
    var authenticationNumberLabelTopAnchorConstraint: NSLayoutConstraint!
    
    var estimate: Estimate
    var paymentMethodList: [String] = ["만나서 현금결제", "만나서 카드결제", "계좌이체"]
    var selectedIndex: Int? = nil
    
    init(estimate: Estimate) {
        self.estimate = estimate
        
        super.init(nibName: nil, bundle: nil)
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
        print("----------------------------------- PaymentViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension PaymentViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.scrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.contentView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.priceLabel,
            self.guideLabel,
            self.addressBaseView,
            self.authenticationGuideLabel,
            self.nameView,
            self.authenticationStackView,
            self.paymentMethodTitleLabel,
            self.paymentMethodTableView,
            self.doneButton,
        ], to: self.contentView)
        
        SupportingMethods.shared.addSubviews([
            self.departureTitleLabel,
            self.departureAddressLabel,
            self.departureDateLabel,
            self.departureTimeLabel,
            
            self.arrivalTitleLabel,
            self.arrivalAddressLabel,
            self.arrivalDateLabel,
            self.arrivalTimeLabel,
            
        ], to: self.addressBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.nameLabel,
            self.nameTextField,
            self.nameButton,
        ], to: self.nameView)
        
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
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
//            self.contentView.heightAnchor.constraint(equalToConstant: 1000),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.priceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 22),
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.centerXAnchor.constraint(equalTo: self.priceLabel.centerXAnchor),
            self.guideLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
        ])
        
        // addressBaseView
        NSLayoutConstraint.activate([
            self.addressBaseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.addressBaseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.addressBaseView.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 30),
//            self.addressBaseView.heightAnchor.constraint(equalToConstant: 112),
        ])
        
        // departureTitleLabel
        NSLayoutConstraint.activate([
            self.departureTitleLabel.leadingAnchor.constraint(equalTo: self.addressBaseView.leadingAnchor, constant: 25),
            self.departureTitleLabel.topAnchor.constraint(equalTo: self.addressBaseView.topAnchor, constant: 10),
        ])
        
        // departureAddressLabel
        NSLayoutConstraint.activate([
            self.departureAddressLabel.leadingAnchor.constraint(equalTo: self.departureTitleLabel.trailingAnchor, constant: 10),
            self.departureAddressLabel.topAnchor.constraint(equalTo: self.addressBaseView.topAnchor, constant: 10),
            self.departureAddressLabel.trailingAnchor.constraint(equalTo: self.addressBaseView.trailingAnchor, constant: -10),
        ])
        
        // departureDateLabel
        NSLayoutConstraint.activate([
            self.departureDateLabel.leadingAnchor.constraint(equalTo: self.departureTitleLabel.trailingAnchor, constant: 10),
            self.departureDateLabel.topAnchor.constraint(equalTo: self.departureAddressLabel.bottomAnchor, constant: 5),
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.departureDateLabel.trailingAnchor, constant: 10),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.departureAddressLabel.bottomAnchor, constant: 5),
        ])
        
        // arrivalTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTitleLabel.leadingAnchor.constraint(equalTo: self.addressBaseView.leadingAnchor, constant: 25),
            self.arrivalTitleLabel.topAnchor.constraint(equalTo: self.departureDateLabel.bottomAnchor, constant: 10),
        ])
        
        // arrivalAddressLabel
        NSLayoutConstraint.activate([
            self.arrivalAddressLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleLabel.trailingAnchor, constant: 10),
            self.arrivalAddressLabel.centerYAnchor.constraint(equalTo: self.arrivalTitleLabel.centerYAnchor),
            self.arrivalAddressLabel.trailingAnchor.constraint(equalTo: self.addressBaseView.trailingAnchor, constant: -10),
        ])
        
        // arrivalDateLabel
        NSLayoutConstraint.activate([
            self.arrivalDateLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleLabel.trailingAnchor, constant: 10),
            self.arrivalDateLabel.topAnchor.constraint(equalTo: self.arrivalAddressLabel.bottomAnchor, constant: 5),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalDateLabel.trailingAnchor, constant: 10),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalAddressLabel.bottomAnchor, constant: 5),
            self.arrivalTimeLabel.bottomAnchor.constraint(equalTo: self.addressBaseView.bottomAnchor, constant: -10),
        ])
        
        // authenticationGuideLabel
        NSLayoutConstraint.activate([
            self.authenticationGuideLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authenticationGuideLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.authenticationGuideLabel.topAnchor.constraint(equalTo: self.addressBaseView.bottomAnchor, constant: 30),
        ])
        
        // nameView
        NSLayoutConstraint.activate([
            self.nameView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.nameView.topAnchor.constraint(equalTo: self.authenticationGuideLabel.bottomAnchor, constant: 10),
            self.nameView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.nameView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // nameLabel
        self.nameLabelTopAnchorConstraint = self.nameLabel.topAnchor.constraint(equalTo: self.nameView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.nameView.leadingAnchor, constant: 15),
            self.nameLabelTopAnchorConstraint
        ])
        
        // nameTextField
        NSLayoutConstraint.activate([
            self.nameTextField.leadingAnchor.constraint(equalTo: self.nameView.leadingAnchor),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.nameView.trailingAnchor),
            self.nameTextField.bottomAnchor.constraint(equalTo: self.nameView.bottomAnchor, constant: -5),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // nameButton
        NSLayoutConstraint.activate([
            self.nameButton.leadingAnchor.constraint(equalTo: self.nameView.leadingAnchor),
            self.nameButton.trailingAnchor.constraint(equalTo: self.nameView.trailingAnchor),
            self.nameButton.bottomAnchor.constraint(equalTo: self.nameView.bottomAnchor),
            self.nameButton.topAnchor.constraint(equalTo: self.nameView.topAnchor),
        ])
        
        // authenticationStackView
        NSLayoutConstraint.activate([
            self.authenticationStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authenticationStackView.topAnchor.constraint(equalTo: self.nameView.bottomAnchor, constant: 10),
            self.authenticationStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
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
        
        // paymentMethodTitleLabel
        NSLayoutConstraint.activate([
            self.paymentMethodTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.paymentMethodTitleLabel.topAnchor.constraint(equalTo: self.authenticationStackView.bottomAnchor, constant: 28),
        ])
        
        // paymentMethodTableView
        NSLayoutConstraint.activate([
            self.paymentMethodTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.paymentMethodTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.paymentMethodTableView.topAnchor.constraint(equalTo: self.paymentMethodTitleLabel.bottomAnchor, constant: 5),
            self.paymentMethodTableView.heightAnchor.constraint(equalToConstant: 169),
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.doneButton.heightAnchor.constraint(equalToConstant: 48),
            self.doneButton.widthAnchor.constraint(equalToConstant: 192),
            self.doneButton.topAnchor.constraint(equalTo: self.paymentMethodTableView.bottomAnchor, constant: 52),
            self.doneButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -64),
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
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 0, green: 0, blue: 0, alpha: 0.87),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "예약하기"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension PaymentViewController {
    
}

// MARK: - Extension for selector methods
extension PaymentViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func nameButton(_ sender: UIButton) {
        self.nameTextField.becomeFirstResponder()
        
    }
    
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
        self.sendAuthenticationNumberButton.setTitle("다시 보내기", for: .normal)
        
        self.authenticationNumberView.isHidden = false
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
            
        } completion: { finished in
            
        }
    }
    
    @objc func authenticationNumberButton(_ sender: UIButton) {
        self.authenticationNumberTextField.becomeFirstResponder()
        
    }
    
    @objc func doneButton(_ sender: UIButton) {
        print("doneButton")
        self.view.endEditing(true)
        let vc = ReservationCompletedViewController(estimate: self.estimate)
        
        self.present(vc, animated: true) {
            guard let viewControllerStack = self.navigationController?.viewControllers else { return }
            for viewController in viewControllerStack {
                if let mainView = viewController as? MainViewController {
                    
                    self.navigationController?.popToViewController(mainView, animated: true)
                }
                
            }
        }
    }
}

// MARK: - Extension for UITextFieldDelegate
extension PaymentViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            UIView.transition(with: self.view, duration: 0.1) {
                self.nameView.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
                
                self.nameLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.nameLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)
                
                self.nameLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
            
        } else if textField == self.numberTextField {
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
        if textField == self.nameTextField {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.nameView.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
                    
                    self.nameLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.nameLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
                    
                    self.nameLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        } else if textField == self.numberTextField {
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.nameTextField.text != "" && self.numberTextField.text != "" {
            self.sendAuthenticationNumberButton.isHidden = false
            
            if self.authenticationNumberTextField.text != "" {
                self.completeAuthenticationButton.isHidden = false
                
            } else {
                self.completeAuthenticationButton.isHidden = true
                
            }
            
        } else {
            self.sendAuthenticationNumberButton.isHidden = true
            
        }
        
//        if self.idTextField.text != "" && self.passwordTextField.text != "" {
//            self.loginButton.isEnabled = true
//            
//        } else {
//            self.loginButton.isEnabled = false
//            
//        }
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
        let title = self.paymentMethodList[indexPath.row]
        
        cell.setCell(title: title)
        
        if self.selectedIndex == indexPath.row {
            cell.methodButton.layer.borderWidth = 2.0
            
        } else {
            cell.methodButton.layer.borderWidth = 0.0
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = self.selectedIndex == indexPath.row ? nil : indexPath.row
        
        self.paymentMethodTableView.reloadData()
        
        if self.selectedIndex != nil {
            let vc = CheckPaymentViewController()
            
            self.present(vc, animated: true)
            
        }
        
    }
    
}
