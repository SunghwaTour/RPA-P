//
//  ClauseTableViewCell.swift
//  RPA-P
//
//  Created by Awesomepia on 8/28/24.
//

import UIKit

final class ClauseTableViewCell: UITableViewCell {
    
    lazy var agreeBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var agreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("check.no")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var agreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 30, green: 30, blue: 30)
        label.font = .useFont(ofSize: 16, weight: .Medium)
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
extension ClauseTableViewCell {
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
            self.agreeBaseView
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.agreeImageView,
            self.agreeLabel,
        ], to: self.agreeBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // agreeBaseView
        NSLayoutConstraint.activate([
            self.agreeBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            self.agreeBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            self.agreeBaseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.agreeBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // agreeImageView
        NSLayoutConstraint.activate([
            self.agreeImageView.leadingAnchor.constraint(equalTo: self.agreeBaseView.leadingAnchor, constant: 18),
            self.agreeImageView.topAnchor.constraint(equalTo: self.agreeBaseView.topAnchor, constant: 2),
            self.agreeImageView.bottomAnchor.constraint(equalTo: self.agreeBaseView.bottomAnchor, constant: -2),
            self.agreeImageView.widthAnchor.constraint(equalToConstant: 20),
            self.agreeImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        // agreeLabel
        NSLayoutConstraint.activate([
            self.agreeLabel.centerYAnchor.constraint(equalTo: self.agreeImageView.centerYAnchor),
            self.agreeLabel.leadingAnchor.constraint(equalTo: self.agreeImageView.trailingAnchor, constant: 10),
        ])
    }
}

// MARK: - Extension for methods added
extension ClauseTableViewCell {
    func setCell(clause: String) {
        self.agreeLabel.text = clause
        
    }
    
}

