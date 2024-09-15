//
//  PastHistoryTourTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 9/16/24.
//

import UIKit

final class PastHistoryTourTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 171, green: 171, blue: 171)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contractButton: UIButton = {
        let button = UIButton()
        button.setTitle("계약서 보기", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(contractButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var tourUid: Int?
    
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
extension PastHistoryTourTableViewCell {
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
            self.tourImageView,
            self.nameLabel,
            self.tagLabel,
            self.contractButton,
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
        
        // tourImageView
        NSLayoutConstraint.activate([
            self.tourImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10),
            self.tourImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 10),
            self.tourImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -10),
            self.tourImageView.heightAnchor.constraint(equalToConstant: 80),
            self.tourImageView.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.tourImageView.trailingAnchor, constant: 10),
            self.nameLabel.topAnchor.constraint(equalTo: self.tourImageView.topAnchor),
        ])
        
        // tagLabel
        NSLayoutConstraint.activate([
            self.tagLabel.leadingAnchor.constraint(equalTo: self.tourImageView.trailingAnchor, constant: 10),
            self.tagLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5),
        ])
        
        // contractButton
        NSLayoutConstraint.activate([
            self.contractButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -10),
            self.contractButton.bottomAnchor.constraint(equalTo: self.tourImageView.bottomAnchor),
            self.contractButton.widthAnchor.constraint(equalToConstant: 100),
            self.contractButton.heightAnchor.constraint(equalToConstant: 38),
        ])
    }
}

// MARK: - Extension for methods added
extension PastHistoryTourTableViewCell {
    func setCell(tour: Tour) {
        self.tourUid = tour.id
        
        switch tour.id {
        case 1,2,3,4:
            self.tourImageView.image = .useCustomImage("Mureung")
        case 5,6:
            self.tourImageView.image = .useCustomImage("Seorak")
        case 7,8:
            self.tourImageView.image = .useCustomImage("Naejangsan")
        default: break
        }
        
        self.nameLabel.text = tour.placeName
        
        let tags = tour.tag.split(separator: ",")
        var newTags: String = ""
        for tag in tags {
            newTags += "#\(tag) "
        }
        
        self.tagLabel.text = newTags

    }
    
}

// MARK: - Extension for selector added
extension PastHistoryTourTableViewCell {
    @objc func contractButton(_ sender: UIButton) {
        guard let tourUid = self.tourUid else {
            SupportingMethods.shared.showAlertNoti(title: "1522-9821로 전화해주세요.")
            return
        }
        NotificationCenter.default.post(name: Notification.Name("SeeContract"), object: nil, userInfo: ["tourUid": tourUid])
    }
    
}
