//
//  ViewPagerCollectionViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 7/12/24.
//

import UIKit

final class ViewPagerCollectionViewCell: UICollectionViewCell {
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        view.layer.cornerRadius = 3.5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
extension ViewPagerCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .clear
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.indicatorView)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // indicatorView
        NSLayoutConstraint.activate([
            self.indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.indicatorView.heightAnchor.constraint(equalToConstant: 7),
            self.indicatorView.widthAnchor.constraint(equalToConstant: 7),
        ])
    }
}

// MARK: - Extension for methods added
extension ViewPagerCollectionViewCell {
    func setCell() {
        
    }
}
