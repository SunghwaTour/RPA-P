//
//  ProfileDetailInfoTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/18/24.
//

import UIKit

final class ProfileDetailInfoTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("nextButton")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
extension ProfileDetailInfoTableViewCell {
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
            self.titleLabel,
            self.nextImageView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
        
        // nextImageView
        NSLayoutConstraint.activate([
            self.nextImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.nextImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.nextImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.nextImageView.heightAnchor.constraint(equalToConstant: 18),
            self.nextImageView.widthAnchor.constraint(equalToConstant: 12.6),
        ])
    }
}

// MARK: - Extension for methods added
extension ProfileDetailInfoTableViewCell {
    func setCell(title: String) {
        self.titleLabel.text = title
        
    }
    
}
