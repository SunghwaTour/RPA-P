//
//  GuideTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 8/31/24.
//

import UIKit

final class GuideTableViewCell: UITableViewCell {
    
    lazy var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 203, green: 203, blue: 203, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("guideImage")
        imageView.contentMode = .scaleAspectFit
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
extension GuideTableViewCell {
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
            self.guideImageView,
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
        
        // guideImageView
        NSLayoutConstraint.activate([
            self.guideImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.guideImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.guideImageView.topAnchor.constraint(equalTo: self.topBorderView.bottomAnchor, constant: 20),
            self.guideImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13),
            self.guideImageView.widthAnchor.constraint(equalToConstant: 320),
            self.guideImageView.heightAnchor.constraint(equalToConstant: 191),
        ])
    }
}

// MARK: - Extension for methods added
extension GuideTableViewCell {
    func setCell() {
        
    }
}

