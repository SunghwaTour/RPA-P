//
//  CategoryCollectionViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 7/16/24.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    lazy var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 11
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 160, blue: 160).cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 255, green: 160, blue: 160)
        label.font = .useFont(ofSize: 11, weight: .Medium)
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
extension CategoryCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .clear
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.categoryView,
            self.categoryLabel
        ], to: self)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // categoryView
        NSLayoutConstraint.activate([
            self.categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.categoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.categoryView.topAnchor.constraint(equalTo: self.topAnchor),
            self.categoryView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // categoryLabel
        NSLayoutConstraint.activate([
            self.categoryLabel.leadingAnchor.constraint(equalTo: self.categoryView.leadingAnchor, constant: 7),
            self.categoryLabel.trailingAnchor.constraint(equalTo: self.categoryView.trailingAnchor, constant: -7),
            self.categoryLabel.topAnchor.constraint(equalTo: self.categoryView.topAnchor, constant: 3),
            self.categoryLabel.bottomAnchor.constraint(equalTo: self.categoryView.bottomAnchor, constant: -4),
            self.categoryLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}

// MARK: - Extension for methods added
extension CategoryCollectionViewCell {
    func setCell(category: String) {
        self.categoryLabel.text = category
    }
}
