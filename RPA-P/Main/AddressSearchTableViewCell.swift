//
//  AddressSearchTableViewCell.swift
//  RPA-P
//
//  Created by Awesomepia on 7/25/24.
//
import UIKit

final class AddressSearchTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.useRGB(red: 238, green: 238, blue: 238).cgColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.textAlignment = .left
        label.text = "여행지명"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var placeSettingCheckedImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeSettingCheckedImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
extension AddressSearchTableViewCell {
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
            self.baseView
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.placeNameLabel,
            self.addressLabel,
            self.placeSettingCheckedImageView
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: 64),
            self.baseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -4),
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        // placeNameLabel
        NSLayoutConstraint.activate([
            self.placeNameLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 12),
            self.placeNameLabel.heightAnchor.constraint(equalToConstant: 19),
            self.placeNameLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.placeNameLabel.trailingAnchor.constraint(equalTo: self.placeSettingCheckedImageView.leadingAnchor, constant: -16)
        ])
        
        // addressLabel
        NSLayoutConstraint.activate([
            self.addressLabel.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -12),
            self.addressLabel.heightAnchor.constraint(equalToConstant: 19),
            self.addressLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.addressLabel.trailingAnchor.constraint(equalTo: self.placeSettingCheckedImageView.leadingAnchor, constant: -16)
        ])
        
        // placeSettingCheckedImageView
        NSLayoutConstraint.activate([
            self.placeSettingCheckedImageView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.placeSettingCheckedImageView.heightAnchor.constraint(equalToConstant: 24),
            self.placeSettingCheckedImageView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.placeSettingCheckedImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

// MARK: - Extension for methods added
extension AddressSearchTableViewCell {
    func setCell(placeName: String, address: String, isSelected: Bool) {
        self.baseView.layer.borderWidth = isSelected ? 2 : 1
        self.baseView.layer.borderColor = isSelected ? UIColor.useRGB(red: 203, green: 203, blue: 255).cgColor : UIColor.useRGB(red: 238, green: 238, blue: 238).cgColor
        self.placeNameLabel.text = placeName
        self.addressLabel.text = address
        self.placeSettingCheckedImageView.isHidden = !isSelected
    }
}
