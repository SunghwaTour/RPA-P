//
//  ReservationCompletedViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/17/24.
//

import UIKit

final class ReservationCompletedViewController: UIViewController {
    
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
    
    lazy var reservationStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("ReservationStatus")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text =  (self.estimate.virtualEstimate?.price.withCommaString ?? "0") + " 원"
        label.font = .useFont(ofSize: 32, weight: .Bold)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.asFontColor(targetString: "원", font: .useFont(ofSize: 18, weight: .Regular), color: .useRGB(red: 0, green: 0, blue: 0))
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "위 견적은 가견적으로, 추후에 변경될 수 있습니다."
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var estimateBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.basicInfoBaseView, self.moreInfoBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var basicInfoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var kindsOfEstimateButton: UIButton = {
        let button = UIButton()
        button.setTitle(self.estimate.kindsOfEstimate.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 142, blue: 142)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var departureAddressLabel: UILabel = {
        let label = UILabel()
        label.text = self.estimate.departure.name
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.estimate.departureDate.date) \(self.estimate.departureDate.time)"
        label.textColor = .useRGB(red: 255, green: 142, blue: 142)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("AddressArrow")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalAddressLabel: UILabel = {
        let label = UILabel()
        label.text = self.estimate.return.name
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.estimate.returnDate.date) \(self.estimate.returnDate.time)"
        label.textColor = .useRGB(red: 255, green: 142, blue: 142)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if self.estimate.kindsOfEstimate == .oneWay {
            label.isHidden = true
            
        }
        
        return label
    }()
    
    lazy var moreInfoBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(MoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "MoreInfoCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var accountBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 243, blue: 243)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var accountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "성화투어 계좌번호"
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 14, weight: .Medium)
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
    
    lazy var accountCopyButton: UIButton = {
        let button = UIButton()
        button.setTitle("복사", for: .normal)
        button.setTitleColor(.useRGB(red: 167, green: 167, blue: 167), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Regular)
        button.addTarget(self, action: #selector(accountCopyButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var companyNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호 1522-9821"
        label.textColor = .useRGB(red: 68, green: 68, blue: 68)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var infoControlButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.black , for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.addTarget(self, action: #selector(infoControlButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var findOtherEstimateButton: UIButton = {
        let button = UIButton()
        button.setTitle("다른 견적 보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(findOtherEstimateButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var heightAnchorContraint: NSLayoutConstraint!
    
    var estimate: PreEstimate
    var moreInfoList: [String] = []
    
    init(estimate: PreEstimate) {
        self.estimate = estimate
        
        self.moreInfoList.append(estimate.pay?.payWay?.rawValue ?? "")
        if let virtualEstimate = estimate.virtualEstimate {
            for category in virtualEstimate.category {
                self.moreInfoList.append(category.rawValue)
                
            }
            
        }
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
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
        print("----------------------------------- ReservationCompletedViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ReservationCompletedViewController: EssentialViewMethods {
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
            self.scrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.contentView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.reservationStatusImageView,
            self.priceLabel,
            self.priceGuideLabel,
            self.estimateBaseView,
            self.findOtherEstimateButton,
        ], to: self.contentView)
        
        SupportingMethods.shared.addSubviews([
            self.infoStackView,
            self.infoControlButton,
        ], to: self.estimateBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.kindsOfEstimateButton,
            self.departureAddressLabel,
            self.departureDateAndTimeLabel,
            self.arrowImageView,
            self.arrivalAddressLabel,
            self.arrivalDateAndTimeLabel,
        ], to: self.basicInfoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.collectionView,
            self.accountBaseView,
        ], to: self.moreInfoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.accountTitleLabel,
            self.accountLabel,
            self.accountCopyButton,
            self.companyNumberLabel,
        ], to: self.accountBaseView)
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
        
        // reservationStatusImageView
        NSLayoutConstraint.activate([
            self.reservationStatusImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.reservationStatusImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17),
            self.reservationStatusImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.reservationStatusImageView.heightAnchor.constraint(equalToConstant: 67),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.reservationStatusImageView.bottomAnchor, constant: 12),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17),
            self.priceLabel.heightAnchor.constraint(equalToConstant: 46),
        ])
        
        // priceGuideLabel
        NSLayoutConstraint.activate([
            self.priceGuideLabel.centerXAnchor.constraint(equalTo: self.priceLabel.centerXAnchor),
            self.priceGuideLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            self.priceGuideLabel.widthAnchor.constraint(equalToConstant: 235),
        ])
        
        // estimateBaseView
        NSLayoutConstraint.activate([
            self.estimateBaseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.estimateBaseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17),
            self.estimateBaseView.topAnchor.constraint(equalTo: self.priceGuideLabel.bottomAnchor, constant: 30),
        ])
        
        // infoStackView
        NSLayoutConstraint.activate([
            self.infoStackView.leadingAnchor.constraint(equalTo: self.estimateBaseView.leadingAnchor),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.estimateBaseView.trailingAnchor),
            self.infoStackView.topAnchor.constraint(equalTo: self.estimateBaseView.topAnchor),
        ])
        
        // kindsOfEstimateButton
        NSLayoutConstraint.activate([
            self.kindsOfEstimateButton.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 14),
            self.kindsOfEstimateButton.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 14),
            self.kindsOfEstimateButton.heightAnchor.constraint(equalToConstant: 30),
            self.kindsOfEstimateButton.widthAnchor.constraint(equalToConstant: 64),
        ])
        
        // departureAddressLabel
        NSLayoutConstraint.activate([
            self.departureAddressLabel.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 16),
            self.departureAddressLabel.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -16),
            self.departureAddressLabel.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 45),
        ])
        
        // departureDateAndTimeLabel
        NSLayoutConstraint.activate([
            self.departureDateAndTimeLabel.centerXAnchor.constraint(equalTo: self.departureAddressLabel.centerXAnchor),
            self.departureDateAndTimeLabel.topAnchor.constraint(equalTo: self.departureAddressLabel.bottomAnchor, constant: 1),
            self.departureDateAndTimeLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
        
        // arrowImageView
        NSLayoutConstraint.activate([
            self.arrowImageView.centerXAnchor.constraint(equalTo: self.departureAddressLabel.centerXAnchor),
            self.arrowImageView.topAnchor.constraint(equalTo: self.departureDateAndTimeLabel.bottomAnchor, constant: 12),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 12),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 25),
        ])
        
        // arrivalAddressLabel
        NSLayoutConstraint.activate([
            self.arrivalAddressLabel.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 16),
            self.arrivalAddressLabel.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -16),
            self.arrivalAddressLabel.topAnchor.constraint(equalTo: self.arrowImageView.bottomAnchor, constant: 14),
        ])
        
        // arrivalDateAndTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalDateAndTimeLabel.centerXAnchor.constraint(equalTo: self.arrivalAddressLabel.centerXAnchor),
            self.arrivalDateAndTimeLabel.topAnchor.constraint(equalTo: self.arrivalAddressLabel.bottomAnchor, constant: 1),
            self.arrivalDateAndTimeLabel.heightAnchor.constraint(equalToConstant: 18),
            self.arrivalDateAndTimeLabel.bottomAnchor.constraint(equalTo: self.basicInfoBaseView.bottomAnchor, constant: -27)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor, constant: 16),
            self.collectionView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor, constant: -33),
            self.collectionView.topAnchor.constraint(equalTo: self.moreInfoBaseView.topAnchor, constant: 27),
            self.collectionView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        // accountBaseView
        NSLayoutConstraint.activate([
            self.accountBaseView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor, constant: 16),
            self.accountBaseView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor, constant: -16),
            self.accountBaseView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 18),
            self.accountBaseView.bottomAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: -18),
//            self.accountBaseView.heightAnchor.constraint(equalToConstant: 97),
        ])
        
        // accountTitleLabel
        NSLayoutConstraint.activate([
            self.accountTitleLabel.leadingAnchor.constraint(equalTo: self.accountBaseView.leadingAnchor, constant: 16),
            self.accountTitleLabel.topAnchor.constraint(equalTo: self.accountBaseView.topAnchor, constant: 12),
        ])
        
        // accountLabel
        NSLayoutConstraint.activate([
            self.accountLabel.leadingAnchor.constraint(equalTo: self.accountBaseView.leadingAnchor, constant: 16),
            self.accountLabel.topAnchor.constraint(equalTo: self.accountTitleLabel.bottomAnchor, constant: 3),
        ])
        
        // accountCopyButton
        NSLayoutConstraint.activate([
            self.accountCopyButton.leadingAnchor.constraint(equalTo: self.accountLabel.trailingAnchor, constant: 4),
            self.accountCopyButton.centerYAnchor.constraint(equalTo: self.accountLabel.centerYAnchor),
            self.accountCopyButton.heightAnchor.constraint(equalToConstant: 16),
            self.accountCopyButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        // companyNumberLabel
        NSLayoutConstraint.activate([
            self.companyNumberLabel.leadingAnchor.constraint(equalTo: self.accountBaseView.leadingAnchor, constant: 16),
            self.companyNumberLabel.topAnchor.constraint(equalTo: self.accountLabel.bottomAnchor, constant: 5),
            self.companyNumberLabel.bottomAnchor.constraint(equalTo: self.accountBaseView.bottomAnchor, constant: -15),
        ])
        
        // infoControlButton
        NSLayoutConstraint.activate([
            self.infoControlButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor),
            self.infoControlButton.bottomAnchor.constraint(equalTo: self.estimateBaseView.bottomAnchor, constant: -6),
            self.infoControlButton.leadingAnchor.constraint(equalTo: self.estimateBaseView.leadingAnchor),
            self.infoControlButton.trailingAnchor.constraint(equalTo: self.estimateBaseView.trailingAnchor),
            self.infoControlButton.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        // findOtherEstimateButton
        NSLayoutConstraint.activate([
            self.findOtherEstimateButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.findOtherEstimateButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -27),
            self.findOtherEstimateButton.topAnchor.constraint(equalTo: self.estimateBaseView.bottomAnchor, constant: 47),
            self.findOtherEstimateButton.heightAnchor.constraint(equalToConstant: 48),
            self.findOtherEstimateButton.widthAnchor.constraint(equalToConstant: 192),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        self.navigationItem.title = "예약 완료"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension ReservationCompletedViewController {
    
}

// MARK: - Extension for selector methods
extension ReservationCompletedViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func infoControlButton(_ sender: UIButton) {
        print("infoControlButton")
        if self.moreInfoBaseView.isHidden {
            self.moreInfoBaseView.isHidden = false
            self.infoControlButton.setTitle("닫기", for: .normal)
            
        } else {
            self.moreInfoBaseView.isHidden = true
            self.infoControlButton.setTitle("더보기", for: .normal)
            
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    @objc func findOtherEstimateButton(_ sender: UIButton) {
        print("findOtherEstimateButton")
        
        self.dismiss(animated: true)
        
    }
    
    @objc func accountCopyButton(_ sender: UIButton) {
        print("accountCopyButton")
        UIPasteboard.general.string = self.accountLabel.text
        
        guard let storedString = UIPasteboard.general.string else { return }
        SupportingMethods.shared.showAlertNoti(title: "\(storedString) 복사되었습니다.")
    }
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension ReservationCompletedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moreInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreInfoCollectionViewCell", for: indexPath) as! MoreInfoCollectionViewCell
        let info = self.moreInfoList[indexPath.row]
        
        cell.setCell(info: "# \(info)", isCompletedReservation: false)
        
        return cell
    }
}
