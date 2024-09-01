//
//  AddressTourTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/31/24.
//

import UIKit

final class AddressTourTableViewCell: UITableViewCell {
    
    lazy var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 203, green: 203, blue: 203, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 정보"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("locationImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 - 서울특별시 중구 소공동 세종대로 18길"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.06.19 ( 수 )   06 : 30 AM"
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("locationImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.text = "도착 - 전라북도 정읍시 내장산로 936"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.06.19 ( 수 )   08 : 30 AM"
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 12, weight: .Regular)
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
extension AddressTourTableViewCell {
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
            self.titleLabel,
            self.departureImageView,
            self.departureLabel,
            self.departureTimeLabel,
            self.arrivalImageView,
            self.arrivalLabel,
            self.arrivalTimeLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // topBorderView
        NSLayoutConstraint.activate([
            self.topBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topBorderView.heightAnchor.constraint(equalToConstant: 5),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topBorderView.bottomAnchor, constant: 30),
        ])
        
        // departureImageView
        NSLayoutConstraint.activate([
            self.departureImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.departureImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 18),
            self.departureImageView.widthAnchor.constraint(equalToConstant: 12),
            self.departureImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureImageView.trailingAnchor, constant: 6),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureImageView.centerYAnchor),
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.departureLabel.leadingAnchor),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 2),
        ])
        
        // arrivalImageView
        NSLayoutConstraint.activate([
            self.arrivalImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.arrivalImageView.topAnchor.constraint(equalTo: self.departureImageView.bottomAnchor, constant: 44),
            self.arrivalImageView.widthAnchor.constraint(equalToConstant: 12),
            self.arrivalImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalImageView.trailingAnchor, constant: 6),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.arrivalLabel.centerYAnchor.constraint(equalTo: self.arrivalImageView.centerYAnchor),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalLabel.leadingAnchor),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 2),
            self.arrivalTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
        ])
    }
}

// MARK: - Extension for methods added
extension AddressTourTableViewCell {
    func setCell(tour: Tour) {
        let formattedDepartureDate = SupportingMethods.shared.convertString(intoDate: tour.departureTime, "yyyy-MM-dd HH:mm")
        let departure = SupportingMethods.shared.convertDate(intoString: formattedDepartureDate, "yyyy.MM.dd(EE) HH:mm a")
        
        let formattedArrivalDate = SupportingMethods.shared.convertString(intoDate: tour.arrivalTime, "yyyy-MM-dd HH:mm")
        let arrival = SupportingMethods.shared.convertDate(intoString: formattedArrivalDate, "yyyy.MM.dd(EE) HH:mm a")
        
        self.departureLabel.text = "출발 - \(tour.departureAddress)"
        self.departureTimeLabel.text = "\(departure)"
        
        self.arrivalLabel.text = "도착 - \(tour.arrivalAddress)"
        self.arrivalTimeLabel.text = "\(arrival)"
    }
}

