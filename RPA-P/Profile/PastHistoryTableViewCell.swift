//
//  PastHistoryTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/18/24.
//

import UIKit

final class PastHistoryTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
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
    
    lazy var departureCircleDesignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("CircleDesign")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var designLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 232, blue: 232)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalCircleDesignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("CircleDesign")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 255, green: 142, blue: 142)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 255, green: 142, blue: 142)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var kindsOfEstimateButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 142, blue: 142)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var infoControlButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(infoControlButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var infoControlImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
        collectionView.register(PastHistoryMoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "PastHistoryMoreInfoCollectionViewCell")
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
    
    var moreInfoList: [String] = []
    var estimate: Estimate?
    
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
extension PastHistoryTableViewCell {
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.infoStackView,
            self.infoControlButton,
            self.infoControlImageView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.departureCircleDesignImageView,
            self.designLineView,
            self.arrivalCircleDesignImageView,
            self.departureLabel,
            self.departureDateAndTimeLabel,
            self.arrivalLabel,
            self.arrivalDateAndTimeLabel,
            self.kindsOfEstimateButton,
        ], to: self.basicInfoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.collectionView,
            self.accountBaseView,
        ], to: self.moreInfoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.accountTitleLabel,
            self.accountLabel,
            self.accountCopyButton,
        ], to: self.accountBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
        
        // infoStackView
        NSLayoutConstraint.activate([
            self.infoStackView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.infoStackView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
        ])
        
        // infoControlButton
        NSLayoutConstraint.activate([
            self.infoControlButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor),
            self.infoControlButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -6),
            self.infoControlButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.infoControlButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.infoControlButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // infoControlImageView
        NSLayoutConstraint.activate([
            self.infoControlImageView.leadingAnchor.constraint(equalTo: self.infoControlButton.trailingAnchor, constant: 3),
            self.infoControlImageView.centerYAnchor.constraint(equalTo: self.infoControlButton.centerYAnchor),
            self.infoControlImageView.widthAnchor.constraint(equalToConstant: 10),
            self.infoControlImageView.heightAnchor.constraint(equalToConstant: 8),
        ])
        
        // departureCircleDesignImageView
        NSLayoutConstraint.activate([
            self.departureCircleDesignImageView.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 20),
            self.departureCircleDesignImageView.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 18),
            self.departureCircleDesignImageView.widthAnchor.constraint(equalToConstant: 15),
            self.departureCircleDesignImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        // designLineView
        NSLayoutConstraint.activate([
            self.designLineView.centerXAnchor.constraint(equalTo: self.departureCircleDesignImageView.centerXAnchor),
            self.designLineView.topAnchor.constraint(equalTo: self.departureCircleDesignImageView.bottomAnchor),
            self.designLineView.heightAnchor.constraint(equalToConstant: 50),
            self.designLineView.widthAnchor.constraint(equalToConstant: 2),
        ])
        
        // arrivalCircleDesignImageView
        NSLayoutConstraint.activate([
            self.arrivalCircleDesignImageView.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 20),
            self.arrivalCircleDesignImageView.topAnchor.constraint(equalTo: self.designLineView.bottomAnchor),
            self.arrivalCircleDesignImageView.widthAnchor.constraint(equalToConstant: 15),
            self.arrivalCircleDesignImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureCircleDesignImageView.centerYAnchor),
            self.departureLabel.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 15),
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureCircleDesignImageView.trailingAnchor, constant: 15),
        ])
        
        // departureDateAndTimeLabel
        NSLayoutConstraint.activate([
            self.departureDateAndTimeLabel.leadingAnchor.constraint(equalTo: self.departureLabel.leadingAnchor),
            self.departureDateAndTimeLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 2),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.centerYAnchor.constraint(equalTo: self.arrivalCircleDesignImageView.centerYAnchor),
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalCircleDesignImageView.trailingAnchor, constant: 15),
        ])
        
        // arrivalDateAndTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalDateAndTimeLabel.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 2),
            self.arrivalDateAndTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalLabel.leadingAnchor),
            self.arrivalDateAndTimeLabel.bottomAnchor.constraint(equalTo: self.basicInfoBaseView.bottomAnchor, constant: -15),
        ])
        
        // kindsOfEstimateButton
        NSLayoutConstraint.activate([
            self.kindsOfEstimateButton.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -16),
            self.kindsOfEstimateButton.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 10),
            self.kindsOfEstimateButton.widthAnchor.constraint(equalToConstant: 64),
            self.kindsOfEstimateButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // moreInfoBaseView
        NSLayoutConstraint.activate([
//            self.moreInfoBaseView.heightAnchor.constraint(equalToConstant: 150),
            
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor, constant: 16),
            self.collectionView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor, constant: -16),
            self.collectionView.topAnchor.constraint(equalTo: self.moreInfoBaseView.topAnchor, constant: 10),
            self.collectionView.heightAnchor.constraint(equalToConstant: 65),
        ])
        
        // accountBaseView
        NSLayoutConstraint.activate([
            self.accountBaseView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor, constant: 16),
            self.accountBaseView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor, constant: -16),
            self.accountBaseView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10),
            self.accountBaseView.bottomAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: -10),
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
            self.accountLabel.bottomAnchor.constraint(equalTo: self.accountBaseView.bottomAnchor, constant: -15),
        ])
        
        // accountCopyButton
        NSLayoutConstraint.activate([
            self.accountCopyButton.leadingAnchor.constraint(equalTo: self.accountLabel.trailingAnchor, constant: 4),
            self.accountCopyButton.centerYAnchor.constraint(equalTo: self.accountLabel.centerYAnchor),
            self.accountCopyButton.heightAnchor.constraint(equalToConstant: 16),
            self.accountCopyButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}

// MARK: - Extension for methods added
extension PastHistoryTableViewCell {
    func setCell(estimate: Estimate) {
        self.estimate = estimate
        
        self.departureLabel.text = estimate.departure
        self.departureDateAndTimeLabel.text = estimate.departureDate
        
        self.arrivalLabel.text = estimate.arrival
        self.arrivalDateAndTimeLabel.text = estimate.arrivalDate
        
        self.kindsOfEstimateButton.setTitle(estimate.kindsOfEstimate, for: .normal)
        
        self.moreInfoList = []
        self.moreInfoList.append("\(estimate.busCount)대")
        self.moreInfoList.append("\(estimate.busType)")
        self.moreInfoList.append(estimate.number == "미정" ? "미정" : "\(estimate.number)명")
        self.moreInfoList.append("\(estimate.operationType)")
        self.moreInfoList.append("\(estimate.payWay)")
        
        self.moreInfoList.sort(by: { $0.count < $1.count })
        
        if self.estimate!.isHiddenCategory {
            self.moreInfoBaseView.isHidden = true
            self.infoControlButton.setImage(.useCustomImage("moreImage"), for: .normal)
            
        } else {
            self.moreInfoBaseView.isHidden = false
            self.infoControlButton.setImage(.useCustomImage("closeImage"), for: .normal)
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
}

// MARK: - Extension for selector added
extension PastHistoryTableViewCell {
    @objc func infoControlButton(_ sender: UIButton) {
        print("infoControlButton")
        self.estimate?.isHiddenCategory.toggle()
        NotificationCenter.default.post(name: Notification.Name("ReloadDataForMoreInfo"), object: nil)
        
    }
    
    @objc func accountCopyButton(_ sender: UIButton) {
        UIPasteboard.general.string = self.accountLabel.text
        
        guard let storedString = UIPasteboard.general.string else { return }
        SupportingMethods.shared.showAlertNoti(title: "\(storedString) 복사되었습니다.")
    }
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension PastHistoryTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moreInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastHistoryMoreInfoCollectionViewCell", for: indexPath) as! PastHistoryMoreInfoCollectionViewCell
        let info = self.moreInfoList[indexPath.row]
        
        cell.setCell(info: "# \(info)")
        
        return cell
    }
}
