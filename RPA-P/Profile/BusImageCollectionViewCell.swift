//
//  BusImageCollectionViewCell.swift
//  RPA-P
//
//  Created by Awesomepia on 8/28/24.
//

import UIKit

final class BusImageCollectionViewCell: UICollectionViewCell {
    
    lazy var busImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
extension BusImageCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .clear
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.busImageView,
        ], to: self)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // busImageView
        NSLayoutConstraint.activate([
            self.busImageView.widthAnchor.constraint(equalToConstant: 240),
            self.busImageView.heightAnchor.constraint(equalToConstant: 300),
            self.busImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.busImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.busImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.busImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension BusImageCollectionViewCell {
    func setCell(image: String) {
        self.busImageView.image = .useCustomImage(image)
        
    }
    
}

