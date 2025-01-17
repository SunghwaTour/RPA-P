//
//  ReservationButtonTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/31/24.
//

import UIKit

final class ReservationButtonTableViewCell: UITableViewCell {
    
    lazy var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 203, green: 203, blue: 203, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var requestButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("예약하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        button.addTarget(self, action: #selector(requestButton(_:)), for: .touchUpInside)
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
extension ReservationButtonTableViewCell {
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
            self.requestButton,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // topBorderView
        NSLayoutConstraint.activate([
            self.topBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topBorderView.heightAnchor.constraint(equalToConstant: 5),
        ])
        
        // requestButton
        NSLayoutConstraint.activate([
            self.requestButton.topAnchor.constraint(equalTo: self.topBorderView.bottomAnchor, constant: 18),
            self.requestButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.requestButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            self.requestButton.widthAnchor.constraint(equalToConstant: 180),
            self.requestButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: - Extension for methods added
extension ReservationButtonTableViewCell {
    func setCell(status: String) {
        if status == "on" {
            self.requestButton.isEnabled = true
            self.requestButton.backgroundColor = .white
            self.requestButton.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
            self.requestButton.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
            self.requestButton.layer.borderWidth = 1.0
            
        } else {
            self.requestButton.isEnabled = false
            self.requestButton.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
            self.requestButton.setTitleColor(.white, for: .normal)
            self.requestButton.layer.borderWidth = 0.0
            
        }
        
    }
    
}

// MARK: Extension for selector added
extension ReservationButtonTableViewCell {
    @objc func requestButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("SendTourData"), object: nil)
        
    }
}

