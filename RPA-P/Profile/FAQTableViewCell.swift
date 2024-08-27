//
//  FAQTableViewCell.swift
//  RPA-P
//
//  Created by Awesomepia on 8/27/24.
//

import UIKit

final class FAQTableViewCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleBaseView, self.borderView, self.contentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var titleBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 218, green: 218, blue: 218)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("faq")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomborderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 218, green: 218, blue: 218)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
extension FAQTableViewCell {
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
            self.stackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
        ], to: self.titleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.contentImageView,
            self.contentLabel,
            self.bottomborderView,
        ], to: self.contentBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // stackView
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.titleBaseView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.titleBaseView.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.titleBaseView.topAnchor, constant: 20),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.titleBaseView.bottomAnchor, constant: -20),
        ])
        
        // borderView
        NSLayoutConstraint.activate([
            self.borderView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // contentImageView
        NSLayoutConstraint.activate([
            self.contentImageView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor, constant: 20),
            self.contentImageView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor, constant: 10),
            self.contentImageView.widthAnchor.constraint(equalToConstant: 23),
            self.contentImageView.heightAnchor.constraint(equalToConstant: 23),
        ])
        
        // contentLabel
        NSLayoutConstraint.activate([
            self.contentLabel.leadingAnchor.constraint(equalTo: self.contentImageView.trailingAnchor, constant: 5),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor, constant: -20),
            self.contentLabel.topAnchor.constraint(equalTo: self.contentImageView.topAnchor),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor, constant: -10),
        ])
        
        // bottomborderView
        NSLayoutConstraint.activate([
            self.bottomborderView.heightAnchor.constraint(equalToConstant: 1),
            self.bottomborderView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor),
            self.bottomborderView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor),
            self.bottomborderView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension FAQTableViewCell {
    func setCell(faq: FAQ) {
        self.titleLabel.text = faq.title
        self.contentLabel.text = faq.content
    }
}

// MARK: - Extension for selector added
extension FAQTableViewCell {
    
}

