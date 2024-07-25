//
//  SelectEstimateTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 7/16/24.
//

import UIKit

final class SelectEstimateTableViewCell: UITableViewCell {
    
    lazy var estimateBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 160, blue: 160).cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "900,000 원"
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var allCategoryList: [Category] = []
    
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
extension SelectEstimateTableViewCell {
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
            self.estimateBaseView,
            self.priceLabel,
            self.collectionView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // estimateBaseView
        NSLayoutConstraint.activate([
            self.estimateBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.estimateBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.estimateBaseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.estimateBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.estimateBaseView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.trailingAnchor.constraint(equalTo: self.estimateBaseView.trailingAnchor, constant: -38),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.estimateBaseView.bottomAnchor, constant: -10),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.estimateBaseView.leadingAnchor, constant: 16),
            self.collectionView.trailingAnchor.constraint(equalTo: self.estimateBaseView.trailingAnchor, constant: -16),
            self.collectionView.topAnchor.constraint(equalTo: self.estimateBaseView.topAnchor, constant: 16),
            self.collectionView.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}

// MARK: - Extension for methods added
extension SelectEstimateTableViewCell {
    func setCell(virtualEstimate: VirtualEstimate) {
        self.priceLabel.text = "\(virtualEstimate.price) 원"
        self.priceLabel.asFontColor(targetString: "원", font: .useFont(ofSize: 14, weight: .Medium), color: .useRGB(red: 115, green: 115, blue: 115))
        
        self.allCategoryList = virtualEstimate.category
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
    }
}

extension SelectEstimateTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let category = self.allCategoryList[indexPath.row]
        
        cell.setCell(category: category.rawValue)
        
        cell.categoryView.backgroundColor = .useRGB(red: 255, green: 232, blue: 232)
        cell.categoryView.layer.borderWidth = 0.0
        
        cell.categoryLabel.textColor = .useRGB(red: 255, green: 142, blue: 142)
        
        return cell
    }
    
}
