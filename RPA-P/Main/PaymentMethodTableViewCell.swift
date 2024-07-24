//
//  PaymentMethodTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 7/17/24.
//

import UIKit

final class PaymentMethodTableViewCell: UITableViewCell {
    
    lazy var methodButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.isEnabled = false
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Regular)
        button.backgroundColor = .useRGB(red: 255, green: 232, blue: 232)
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
extension PaymentMethodTableViewCell {
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
        self.addSubview(self.methodButton)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // methodButton
        NSLayoutConstraint.activate([
            self.methodButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.methodButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.methodButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.methodButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.methodButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

// MARK: - Extension for methods added
extension PaymentMethodTableViewCell {
    func setCell(title: String) {
        self.methodButton.setTitle(title, for: .normal)
        
    }
}
