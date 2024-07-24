//
//  EstimateDetailTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 7/18/24.
//

import UIKit

final class EstimateDetailTableViewCell: UITableViewCell {
    
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
        button.setTitle("편도", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 199, blue: 199)
        button.layer.cornerRadius = 12.5
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var departureAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지 주소"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.numberOfLines = 2
//        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var displayView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 199, blue: 199)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var distanceButton: UIButton = {
        let button = UIButton()
        button.setTitle("501KM", for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 199, blue: 199), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        button.layer.borderColor = UIColor.useRGB(red: 255, green: 206, blue: 206).cgColor
        button.layer.borderWidth = 1.0
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지 주소"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.numberOfLines = 2
//        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateAndTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발"
        label.textColor = .useRGB(red: 133, green: 133, blue: 133)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.06.19(수) 06:30 AM"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateAndTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착"
        label.textColor = .useRGB(red: 133, green: 133, blue: 133)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.06.19(수) 06:30 PM"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 금액"
        label.textColor = .useRGB(red: 255, green: 144, blue: 144)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1,150,000 원"
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.asFontColor(targetString: "원", font: .useFont(ofSize: 14, weight: .Regular), color: .useRGB(red: 184, green: 0, blue: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reservationConfirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("예약 확정하기", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(reservationConfirmButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var moreInfoBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dottedLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("DottedLine")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
    
    lazy var infoControlButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.black , for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.addTarget(self, action: #selector(infoControlButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var moreInfoList: [String] = ["25명", "현금", "기사 전체 동행", "28인승", "1대", "우등"]
    
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
extension EstimateDetailTableViewCell {
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
            self.estimateBaseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.infoStackView,
            self.infoControlButton,
        ], to: self.estimateBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.kindsOfEstimateButton,
            self.departureAddressLabel,
            self.displayView,
            self.distanceButton,
            self.arrivalAddressLabel,
            
            self.departureDateAndTimeTitleLabel,
            self.departureDateAndTimeLabel,
            self.arrivalDateAndTimeTitleLabel,
            self.arrivalDateAndTimeLabel,
            
            self.priceTitleLabel,
            self.priceLabel,
            
            self.reservationConfirmButton,
        ], to: self.basicInfoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.dottedLineImageView,
            self.collectionView,
        ], to: self.moreInfoBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // estimateBaseView
        NSLayoutConstraint.activate([
            self.estimateBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            self.estimateBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            self.estimateBaseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.estimateBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // infoStackView
        NSLayoutConstraint.activate([
            self.infoStackView.leadingAnchor.constraint(equalTo: self.estimateBaseView.leadingAnchor),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.estimateBaseView.trailingAnchor),
            self.infoStackView.topAnchor.constraint(equalTo: self.estimateBaseView.topAnchor),
        ])
        
        // kindsOfEstimateButton
        NSLayoutConstraint.activate([
            self.kindsOfEstimateButton.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 16),
            self.kindsOfEstimateButton.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 20),
            self.kindsOfEstimateButton.heightAnchor.constraint(equalToConstant: 25),
            self.kindsOfEstimateButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        // departureAddressLabel
        NSLayoutConstraint.activate([
            self.departureAddressLabel.leadingAnchor.constraint(equalTo: self.kindsOfEstimateButton.trailingAnchor, constant: 8),
            self.departureAddressLabel.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -8),
            self.departureAddressLabel.centerYAnchor.constraint(equalTo: self.kindsOfEstimateButton.centerYAnchor),
        ])
        
        // displayView
        NSLayoutConstraint.activate([
            self.displayView.centerXAnchor.constraint(equalTo: self.kindsOfEstimateButton.centerXAnchor),
            self.displayView.topAnchor.constraint(equalTo: self.kindsOfEstimateButton.bottomAnchor),
            self.displayView.widthAnchor.constraint(equalToConstant: 1),
            self.displayView.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        // distanceButton
        NSLayoutConstraint.activate([
            self.distanceButton.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 16),
            self.distanceButton.topAnchor.constraint(equalTo: self.displayView.bottomAnchor),
            self.distanceButton.heightAnchor.constraint(equalToConstant: 25),
            self.distanceButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        // arrivalAddressLabel
        NSLayoutConstraint.activate([
            self.arrivalAddressLabel.leadingAnchor.constraint(equalTo: self.distanceButton.trailingAnchor, constant: 8),
            self.arrivalAddressLabel.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -8),
            self.arrivalAddressLabel.centerYAnchor.constraint(equalTo: self.distanceButton.centerYAnchor),
        ])
        
        // departureDateAndTimeTitleLabel
        NSLayoutConstraint.activate([
            self.departureDateAndTimeTitleLabel.topAnchor.constraint(equalTo: self.distanceButton.bottomAnchor, constant: 18),
            self.departureDateAndTimeTitleLabel.centerXAnchor.constraint(equalTo: self.distanceButton.centerXAnchor),
        ])
        
        // departureDateAndTimeLabel
        NSLayoutConstraint.activate([
            self.departureDateAndTimeLabel.centerYAnchor.constraint(equalTo: self.departureDateAndTimeTitleLabel.centerYAnchor),
            self.departureDateAndTimeLabel.leadingAnchor.constraint(equalTo: self.departureDateAndTimeTitleLabel.trailingAnchor, constant: 20),
            self.departureDateAndTimeLabel.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -8),
        ])
        
        // arrivalDateAndTimeTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalDateAndTimeTitleLabel.topAnchor.constraint(equalTo: self.departureDateAndTimeTitleLabel.bottomAnchor, constant: 12),
            self.arrivalDateAndTimeTitleLabel.centerXAnchor.constraint(equalTo: self.departureDateAndTimeTitleLabel.centerXAnchor),
        ])
        
        // arrivalDateAndTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalDateAndTimeLabel.centerYAnchor.constraint(equalTo: self.arrivalDateAndTimeTitleLabel.centerYAnchor),
            self.arrivalDateAndTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalDateAndTimeTitleLabel.trailingAnchor, constant: 20),
            self.arrivalDateAndTimeLabel.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -8),
        ])
        
        // priceTitleLabel
        NSLayoutConstraint.activate([
            self.priceTitleLabel.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 30),
            self.priceTitleLabel.topAnchor.constraint(equalTo: self.arrivalDateAndTimeTitleLabel.bottomAnchor, constant: 30),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.leadingAnchor.constraint(equalTo: self.priceTitleLabel.leadingAnchor, constant: 2),
            self.priceLabel.topAnchor.constraint(equalTo: self.priceTitleLabel.bottomAnchor, constant: 5),
        ])
        
        // reservationConfirmButton
        NSLayoutConstraint.activate([
            self.reservationConfirmButton.trailingAnchor.constraint(equalTo: self.basicInfoBaseView.trailingAnchor, constant: -16),
            self.reservationConfirmButton.topAnchor.constraint(equalTo: self.priceTitleLabel.topAnchor, constant: 13),
            self.reservationConfirmButton.bottomAnchor.constraint(equalTo: self.basicInfoBaseView.bottomAnchor, constant: -20),
            self.reservationConfirmButton.heightAnchor.constraint(equalToConstant: 48),
            self.reservationConfirmButton.widthAnchor.constraint(equalToConstant: 128),
        ])
        
        // moreInfoBaseView
        NSLayoutConstraint.activate([
            self.moreInfoBaseView.heightAnchor.constraint(equalToConstant: 150),
            
        ])
        
        // dottedLineImageView
        NSLayoutConstraint.activate([
            self.dottedLineImageView.topAnchor.constraint(equalTo: self.moreInfoBaseView.topAnchor),
            self.dottedLineImageView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor),
            self.dottedLineImageView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor),
            self.dottedLineImageView.heightAnchor.constraint(equalToConstant: 2),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor, constant: 16),
            self.collectionView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor, constant: -16),
            self.collectionView.topAnchor.constraint(equalTo: self.dottedLineImageView.bottomAnchor, constant: 20),
            self.collectionView.bottomAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: -5),
        ])
        
        // infoControlButton
        NSLayoutConstraint.activate([
            self.infoControlButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor),
            self.infoControlButton.bottomAnchor.constraint(equalTo: self.estimateBaseView.bottomAnchor, constant: -6),
            self.infoControlButton.leadingAnchor.constraint(equalTo: self.estimateBaseView.leadingAnchor),
            self.infoControlButton.trailingAnchor.constraint(equalTo: self.estimateBaseView.trailingAnchor),
            self.infoControlButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

// MARK: - Extension for methods added
extension EstimateDetailTableViewCell {
    func setCell() {
        
    }
}

// MARK: - Extension for selector added
extension EstimateDetailTableViewCell {
    @objc func infoControlButton(_ sender: UIButton) {
        print("infoControlButton")
        NotificationCenter.default.post(name: Notification.Name("ReloadDataForMoreInfo"), object: nil)
        
        if self.moreInfoBaseView.isHidden {
            self.moreInfoBaseView.isHidden = false
            self.infoControlButton.setTitle("닫기", for: .normal)
            
        } else {
            self.moreInfoBaseView.isHidden = true
            self.infoControlButton.setTitle("더보기", for: .normal)
            
        }
        
    }
    
    @objc func reservationConfirmButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("RservationConfirmation"), object: nil)
        
    }
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension EstimateDetailTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moreInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreInfoCollectionViewCell", for: indexPath) as! MoreInfoCollectionViewCell
        let info = self.moreInfoList[indexPath.row]
        
        cell.setCell(info: "# \(info)")
        
        return cell
    }
}
