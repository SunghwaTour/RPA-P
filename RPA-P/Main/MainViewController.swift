//
//  MainViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit

enum SelectTab: Int {
    case estimate
    case detail
}

final class MainViewController: UIViewController {
    
    lazy var contentView: UIView = {
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
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.didMove(toParent: self)
        
        let estimateVC = EstimateViewController()
//        estimateVC.title = ""
        
        let detailVC = EstimateDetailViewController()
//        detailVC.title = ""
        
        self.subControllers = [estimateVC, detailVC]
        return pageVC
    }()
    
    var subControllers: [UIViewController] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setUpNavigationItem()
        self.setPageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- MainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MainViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveEstimateDetail(_:)), name: Notification.Name("MoveEstimateDetail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveEstimate(_:)), name: Notification.Name("MoveEstimate"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.contentView,
            self.collectionView,
        ], to: self.view)
        
        addChild(self.pageViewController)
        
        SupportingMethods.shared.addSubviews([
            self.pageViewController.view,
        ], to: self.contentView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // contentView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 11.5),
            self.collectionView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 16),
            self.collectionView.widthAnchor.constraint(equalToConstant: 41),
        ])
        
        // pageViewController.view
        NSLayoutConstraint.activate([
            self.pageViewController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.pageViewController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.pageViewController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "킹버스"
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setPageViewController() {
        self.pageViewController.setViewControllers([self.subControllers[self.currentIndex]], direction: .forward, animated: true)
    }
}

// MARK: - Extension for methods added
extension MainViewController {
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
}

// MARK: - Extension for selector methods
extension MainViewController {
    @objc func moveEstimateDetail(_ notificatoin: Notification) {
        self.select(index: .detail)
        
    }
    
    @objc func moveEstimate(_ notificatoin: Notification) {
        self.select(index: .estimate)
        
    }
}

// MARK: - Extension for UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
