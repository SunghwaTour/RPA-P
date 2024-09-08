//
//  RefactoringMainViewController.swift
//  RPA-P
//
//  Created by Awesomepia on 9/1/24.
//

import UIKit
import Gifu
import ImageSlideshow

enum SelectTab: Int {
    case estimate
    case detail
}

final class RefactoringMainViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .onDrag
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var imageSlideShow: ImageSlideshow = {
        let pageIndicator = LabelPageIndicator()
        
        let imageSlideShow = ImageSlideshow()
        imageSlideShow.contentScaleMode = .scaleToFill
        imageSlideShow.circular = true
        imageSlideShow.scrollView.bounces = false
        imageSlideShow.slideshowInterval = 3
        imageSlideShow.pageIndicator = pageIndicator
        imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 15), vertical: .customBottom(padding: 10))
        imageSlideShow.delegate = self
        imageSlideShow.translatesAutoresizingMaskIntoConstraints = false
        
        var imageResources: [ImageSource] = [
            ImageSource(image: .useCustomImage("Seorak")),
            ImageSource(image: .useCustomImage("Naejangsan")),
            ImageSource(image: .useCustomImage("Mureung")),
        ]
        imageSlideShow.setImageInputs(imageResources)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageSlideShow(_:)))
        imageSlideShow.addGestureRecognizer(gesture)
        
        return imageSlideShow
    }()
    
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
        print("----------------------------------- RefactoringMainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RefactoringMainViewController: EssentialViewMethods {
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
            self.scrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.imageSlideShow,
            self.contentView,
            self.collectionView,
        ], to: self.baseView)
        
        addChild(self.pageViewController)
        
        SupportingMethods.shared.addSubviews([
            self.pageViewController.view,
        ], to: self.contentView)
    }
    
    func setLayouts() {
//        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: 1200)
        ])
        
        // imageSlideShow
        NSLayoutConstraint.activate([
            self.imageSlideShow.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.imageSlideShow.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.imageSlideShow.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.imageSlideShow.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 329/360),
        ])
        
        // contentView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.imageSlideShow.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
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
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavigationTitle() -> UIImageView {
        let navigationTitleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        navigationTitleImageView.image = UIImage(named: "NavigationLogo")
        navigationTitleImageView.contentMode = .scaleAspectFit
        
        return navigationTitleImageView
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 184, green: 0, blue: 0),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.titleView = self.setUpNavigationTitle()
        
        let leftBarButtonItem = UIBarButtonItem(title: ReferenceValues.name == "null" ? "방문자" : "\(ReferenceValues.name)님", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.useFont(ofSize: 14, weight: .Medium)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
    }
    
    func setPageViewController() {
        self.pageViewController.setViewControllers([self.subControllers[self.currentIndex]], direction: .forward, animated: true)
    }
}

// MARK: - Extension for methods added
extension RefactoringMainViewController {
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
extension RefactoringMainViewController {
    @objc func moveEstimateDetail(_ notificatoin: Notification) {
        self.select(index: .detail)
        
    }
    
    @objc func moveEstimate(_ notificatoin: Notification) {
        self.select(index: .estimate)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
//        let vc = ProfileViewController()
//
//        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = TourDetailViewController()
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageSlideShow(_ gesture: UITapGestureRecognizer) {
//        let vc = TourDetailViewController()
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension for UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension RefactoringMainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
extension RefactoringMainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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

// MARK: - Extension for ImageSlideshowDelegate
extension RefactoringMainViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        
    }
    
}
