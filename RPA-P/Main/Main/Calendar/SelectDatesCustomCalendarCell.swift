//
//  SelectDatesCustomCalendarCell.swift
//  RPA-P
//
//  Created by Awesomepia on 8/29/24.
//

import UIKit
import FSCalendar

enum SelectedDateType {
    case singleDate    // 날짜 하나만 선택된 경우 (원 모양 배경)
    case firstDate    // 여러 날짜 선택 시 맨 처음 날짜
    case middleDate // 여러 날짜 선택 시 맨 처음, 마지막을 제외한 중간 날짜
    case lastDate   // 여러 날짜 선택시 맨 마지막 날짜
    case notSelectd // 선택되지 않은 날짜
}

class SelectDatesCustomCalendarCell: FSCalendarCell {
    
    lazy var circleBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftRectBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var rightRectBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
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
extension SelectDatesCustomCalendarCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.contentView.insertSubview(self.circleBackImageView, at: 0)
        self.contentView.insertSubview(self.leftRectBackImageView, at: 0)
        self.contentView.insertSubview(self.rightRectBackImageView, at: 0)
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
          self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
          self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
          self.leftRectBackImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
          self.leftRectBackImageView.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
          self.leftRectBackImageView.heightAnchor.constraint(equalToConstant: 40),
          self.leftRectBackImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
          self.circleBackImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
          self.circleBackImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
          self.circleBackImageView.widthAnchor.constraint(equalToConstant: 40),
          self.circleBackImageView.heightAnchor.constraint(equalToConstant: 40),
          self.circleBackImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
          self.rightRectBackImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
          self.rightRectBackImageView.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor),
          self.rightRectBackImageView.heightAnchor.constraint(equalToConstant: 40),
          self.rightRectBackImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
        
    }
}

// MARK: - Extension for methods added
extension SelectDatesCustomCalendarCell {
    func setCell() {
        
    }
    
    func updateBackImage(_ dateType: SelectedDateType) {
        switch dateType {
        case .singleDate:
            // left right hidden true
            // circle hidden false
            self.leftRectBackImageView.isHidden = true
            self.rightRectBackImageView.isHidden = true
            self.circleBackImageView.isHidden = false

        case .firstDate:
            // leftRect hidden true
            // circle, right hidden false
            self.leftRectBackImageView.isHidden = true
            self.circleBackImageView.isHidden = false
            self.rightRectBackImageView.isHidden = false

        case .middleDate:
            // circle hidden true
            // left, right hidden false
            self.circleBackImageView.isHidden = true
            self.leftRectBackImageView.isHidden = false
            self.rightRectBackImageView.isHidden = false

        case .lastDate:
            // rightRect hidden true
            // circle, left hidden false
            self.rightRectBackImageView.isHidden = true
            self.circleBackImageView.isHidden = false
            self.leftRectBackImageView.isHidden = false
        case .notSelectd:
            // all hidden
            self.circleBackImageView.isHidden = true
            self.leftRectBackImageView.isHidden = true
            self.rightRectBackImageView.isHidden = true
        }

    }

}

