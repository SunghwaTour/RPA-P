//
//  BasicInfoTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/31/24.
//

import UIKit

final class BasicInfoTableViewCell: UITableViewCell {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "모집중 - 참여자 20명 이상부터 확정"
        label.textColor = .white
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var durationDateLabel:  UILabel = {
        let label = UILabel()
        label.text = "2024.11.15 ~ 2024.12.15"
        label.textColor = .white
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var areaButton: UIButton = {
        let button = UIButton()
        button.setTitle("전라북도", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.layer.cornerRadius = 12.5
        button.backgroundColor = .useRGB(red: 255, green: 255, blue: 255, alpha: 0.8)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "50,000"
        label.textColor = .white
        label.font = .useFont(ofSize: 32, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reservationStatusButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Regular)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .useRGB(red: 255, green: 255, blue: 255, alpha: 0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "내장산국립공원"
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "전라북도 정읍시 내장산로 936"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("복사", for: .normal)
        button.setTitleColor(.useRGB(red: 159, green: 159, blue: 159), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.addTarget(self, action: #selector(copyButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "#단풍놀이 #가을여행 #힐링 #케이블카"
        label.textColor = .useRGB(red: 171, green: 171, blue: 171)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
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
extension BasicInfoTableViewCell {
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
            self.backgroundImageView,
            self.statusLabel,
            self.durationDateLabel,
            self.areaButton,
            self.priceLabel,
            self.reservationStatusButton,
            self.nameLabel,
            self.addressLabel,
            self.copyButton,
            self.tagLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
        // backgroundImageView
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImageView.heightAnchor.constraint(equalToConstant: 185),
        ])
        
        // statusLabel
        NSLayoutConstraint.activate([
            self.statusLabel.leadingAnchor.constraint(equalTo: self.backgroundImageView.leadingAnchor, constant: 20),
            self.statusLabel.topAnchor.constraint(equalTo: self.backgroundImageView.topAnchor, constant: 16),
        ])
        
        // durationDateLabel
        NSLayoutConstraint.activate([
            self.durationDateLabel.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor),
            self.durationDateLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 5),
        ])
        
        // areaButton
        NSLayoutConstraint.activate([
            self.areaButton.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: -20),
            self.areaButton.topAnchor.constraint(equalTo: self.backgroundImageView.topAnchor, constant: 16),
            self.areaButton.widthAnchor.constraint(equalToConstant: 57),
            self.areaButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.leadingAnchor.constraint(equalTo: self.backgroundImageView.leadingAnchor, constant: 20),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: -17),
        ])
        
        // reservationStatusButton
        NSLayoutConstraint.activate([
            self.reservationStatusButton.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: -18),
            self.reservationStatusButton.bottomAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: -24),
            self.reservationStatusButton.widthAnchor.constraint(equalToConstant: 82),
            self.reservationStatusButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nameLabel.topAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: 30),
        ])
        
        // addressLabel
        NSLayoutConstraint.activate([
            self.addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.addressLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 3),
        ])
        
        // copyButton
        NSLayoutConstraint.activate([
            self.copyButton.leadingAnchor.constraint(equalTo: self.addressLabel.trailingAnchor, constant: 5),
            self.copyButton.centerYAnchor.constraint(equalTo: self.addressLabel.centerYAnchor),
            self.copyButton.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // tagLabel
        NSLayoutConstraint.activate([
            self.tagLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.tagLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 20),
            self.tagLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
        ])
    }
}

// MARK: - Extension for methods added
extension BasicInfoTableViewCell {
    func setCell(tour: Tour, myTour: MyTour?) {
        self.backgroundImageView.image = .useCustomImage(tour.imageName)
        self.statusLabel.text = "\(tour.status == "0" ? "모집중" : "모집 완료") - 참여자 \(tour.min)명 이상부터 확정"
        self.durationDateLabel.text = "\(tour.startTime.split(separator: " ")[0]) ~ \(tour.endTime.split(separator: " ")[0])"
        self.priceLabel.text = "\(Int(tour.individualPrice)!.withCommaString ?? "0")원"
        self.areaButton.setTitle("\(tour.arrivalAddress.split(separator: " ")[0])", for: .normal)
        
        self.nameLabel.text = "\(tour.placeName)"
        self.addressLabel.text = "\(tour.departureAddress)"
        
        let tags = tour.tag.split(separator: ",")
        var newTags: String = ""
        for tag in tags {
            newTags += "#\(tag) "
        }
        
        self.tagLabel.text = newTags
        
        guard let myTour = myTour else {
            self.reservationStatusButton.isHidden = true
            return
        }
        self.reservationStatusButton.isHidden = false
        if myTour.isCompletedDeposit {
            self.reservationStatusButton.setTitle("예약완료", for: .normal)
            
        } else {
            self.reservationStatusButton.setTitle("예약확인중", for: .normal)
            
        }
        
    }
}

// MARK: - Extension for selector added
extension BasicInfoTableViewCell {
    @objc func copyButton(_ sender: UIButton) {
        UIPasteboard.general.string = self.addressLabel.text
        
        guard let storedString = UIPasteboard.general.string else { return }
        SupportingMethods.shared.showAlertNoti(title: "\(storedString) 복사되었습니다.")
    }
}
