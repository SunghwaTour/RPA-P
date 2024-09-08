//
//  MainContentsTableViewCell.swift
//  RPA-P
//
//  Created by Awesomepia on 9/1/24.
//

import UIKit

final class MainContentsTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 16, height: 16)
        flowLayout.minimumLineSpacing = 9
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ViewPagerCollectionViewCell.self, forCellWithReuseIdentifier: "ViewPagerCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.view.bounds = self.bounds
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
//        pageVC.didMove(toParent: self)
        
        let estimateVC = EstimateViewController()
//        estimateVC.title = ""
        
        let detailVC = EstimateDetailViewController()
//        detailVC.title = ""
        
        self.subControllers = [estimateVC, detailVC]
        return pageVC
    }()
    
    var subControllers: [UIViewController] = []
    var currentIndex: Int = 0
    
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
extension MainContentsTableViewCell {
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
        NotificationCenter.default.addObserver(self, selector: #selector(moveEstimateDetail(_:)), name: Notification.Name("MoveEstimateDetail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveEstimate(_:)), name: Notification.Name("MoveEstimate"), object: nil)
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.collectionView,
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.pageViewController.view,
        ], to: self.baseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // contentView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 11.5),
            self.collectionView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 16),
            self.collectionView.widthAnchor.constraint(equalToConstant: 41),
        ])
        
        // pageViewController.view
        NSLayoutConstraint.activate([
            self.pageViewController.view.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.pageViewController.view.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.pageViewController.view.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension MainContentsTableViewCell {
    func setPageViewController() {
        self.pageViewController.setViewControllers([self.subControllers[self.currentIndex]], direction: .forward, animated: true)
    }
    
    func select(index: SelectTab) {
        var direction: UIPageViewController.NavigationDirection = .forward
        if index.rawValue > self.currentIndex {
            direction = .forward
            
        } else {
            direction = .reverse
            
        }
        
        self.currentIndex = index.rawValue
        self.pageViewController.setViewControllers([self.subControllers[index.rawValue]], direction: direction, animated: false)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
    }
    
    func setCell() {
        
    }
}

// MARK: Extension for selector added
extension MainContentsTableViewCell {
    @objc func moveEstimateDetail(_ notificatoin: Notification) {
        self.select(index: .detail)
        
    }
    
    @objc func moveEstimate(_ notificatoin: Notification) {
        self.select(index: .estimate)
        
    }
}

// MARK: - Extension for UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension MainContentsTableViewCell: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.subControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return self.subControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.subControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == self.subControllers.count {
            return nil
        }
        return self.subControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let vc = self.pageViewController.viewControllers?.first else {
                self.currentIndex = 0
                return
            }
            self.currentIndex = self.subControllers.firstIndex(of: vc) ?? 0
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension MainContentsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewPagerCollectionViewCell", for: indexPath) as! ViewPagerCollectionViewCell
        
        if indexPath.row == self.currentIndex {
            cell.indicatorView.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        } else {
            cell.indicatorView.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        }
        
        return cell
    }
    
}
