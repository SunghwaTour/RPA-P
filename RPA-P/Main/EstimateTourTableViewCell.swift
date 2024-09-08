//
//  EstimateTourTableViewCell.swift
//  RPA-P
//
//  Created by 이주성 on 9/8/24.
//

import UIKit

private enum Index {
    static let itemSize = CGSize(width: 300, height: 360)
    static let itemSpacing = 24.0
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - self.itemSize.width) / 2.0
        
    }
    
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        
    }
}

final class EstimateTourTableViewCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 300, height: 360)
        flowLayout.minimumLineSpacing = 24
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(EstimateTourCollectionViewCell.self, forCellWithReuseIdentifier: "EstimateTourCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = Index.collectionViewContentInset
        collectionView.decelerationRate = .fast

        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    var tourList: [(tour: Tour, status: Bool)] = []
    
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
extension EstimateTourTableViewCell {
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
            self.collectionView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.heightAnchor.constraint(equalToConstant: 380),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension EstimateTourTableViewCell {
    func setCell(tourList: [(tour: Tour, status: Bool)]) {
        self.tourList = tourList
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
    }
}

extension EstimateTourTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tourList.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EstimateTourCollectionViewCell", for: indexPath) as! EstimateTourCollectionViewCell
        let tour = self.tourList[indexPath.row]

        cell.setCell(tour: tour.tour, status: tour.status)

        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == self.collectionView {
            let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
            let cellWidth = Index.itemSize.width + Index.itemSpacing
            let index = round(scrolledOffsetX / cellWidth)
            targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)

            print("index: \(index)")
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            let scrolledOffset = scrollView.contentOffset.x + scrollView.contentInset.left
            let cellWidth = Index.itemSize.width + Index.itemSpacing
            let index = Int(round(scrolledOffset / cellWidth))

        }

    }
}
