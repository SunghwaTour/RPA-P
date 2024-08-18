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
            self.departureCircleDesignImageView,
            self.designLineView,
            self.arrivalCircleDesignImageView,
            self.departureLabel,
            self.departureDateAndTimeLabel,
            self.arrivalLabel,
            self.arrivalDateAndTimeLabel,
        ], to: self.baseView)
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
        
        // departureCircleDesignImageView
        NSLayoutConstraint.activate([
            self.departureCircleDesignImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.departureCircleDesignImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 18),
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
            self.arrivalCircleDesignImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.arrivalCircleDesignImageView.topAnchor.constraint(equalTo: self.designLineView.bottomAnchor),
            self.arrivalCircleDesignImageView.widthAnchor.constraint(equalToConstant: 15),
            self.arrivalCircleDesignImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureCircleDesignImageView.centerYAnchor),
            self.departureLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 15),
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
            self.arrivalDateAndTimeLabel.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -15),
        ])
    }
}

// MARK: - Extension for methods added
extension PastHistoryTableViewCell {
    func setCell(estimate: Estimate) {
        self.departureLabel.text = estimate.departure
        self.departureDateAndTimeLabel.text = estimate.departureDate
        
        self.arrivalLabel.text = estimate.arrival
        self.arrivalDateAndTimeLabel.text = estimate.arrivalDate
    }
}
