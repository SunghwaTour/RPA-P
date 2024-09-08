//
//  EstimateTourCollectionViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 9/8/24.
//

import UIKit

final class EstimateTourCollectionViewCell: UICollectionViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.addShadow(offset: CGSize(width: 1, height: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 33, green: 33, blue: 33)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 금액"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension for essential methods
extension EstimateTourCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.tourImageView,
            self.statusLabel,
            self.nameLabel,
            self.departureLabel,
            self.priceTitleLabel,
            self.priceLabel,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // tourImageView
        NSLayoutConstraint.activate([
            self.tourImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.tourImageView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.tourImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.tourImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // statusLabel
        NSLayoutConstraint.activate([
            self.statusLabel.centerXAnchor.constraint(equalTo: self.tourImageView.centerXAnchor),
            self.statusLabel.centerYAnchor.constraint(equalTo: self.tourImageView.centerYAnchor),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 15),
            self.nameLabel.topAnchor.constraint(equalTo: self.tourImageView.bottomAnchor, constant: 15),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 15),
            self.departureLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5),
        ])
        
        // priceTitleLabel
        NSLayoutConstraint.activate([
            self.priceTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 15),
            self.priceTitleLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 15),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 15),
            self.priceLabel.topAnchor.constraint(equalTo: self.priceTitleLabel.bottomAnchor, constant: 5),
        ])
    }
}

// MARK: - Extension for methods added
extension EstimateTourCollectionViewCell {
    func setCell(tour: Tour, status: Bool) {
        switch tour.id {
        case 1,2,3,4:
            self.tourImageView.image = .useCustomImage("Mureung")
        case 5,6:
            self.tourImageView.image = .useCustomImage("Seorak")
        case 7,8:
            self.tourImageView.image = .useCustomImage("Naejangsan")
        default: break
        }
        
        if status {
            // 결제 완료(예약 완료)
            self.statusLabel.text = "예약 완료"
            
        } else {
            // 결제 대기중
            self.statusLabel.text = "결제 대기중"
            
        }
        
        self.nameLabel.text = tour.placeName
        let convertDate = SupportingMethods.shared.convertString(intoDate: tour.departureTime, "yyyy-MM-dd HH:mm")
        let departureTime = SupportingMethods.shared.convertDate(intoString: convertDate, "yyyy.MM.dd(EEE) a HH:mm")
        
        self.departureLabel.text = departureTime
        self.priceLabel.text = "\(Int(tour.individualPrice)!.withCommaString!) 원"
        self.priceLabel.asFontColor(targetString: "원", font: .useFont(ofSize: 14, weight: .Light), color: .useRGB(red: 184, green: 0, blue: 0))
        
    }
}
