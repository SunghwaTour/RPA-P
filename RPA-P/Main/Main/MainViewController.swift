//
//  MainViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit
import Gifu
import ImageSlideshow

//enum SelectTab: Int {
//    case estimate
//    case detail
//}

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
    
    lazy var completedRequestReservationBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 30, weight: .Bold)
        label.numberOfLines = 2
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.setLineSpacing(spacing: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.setLineSpacing(spacing: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var completedRequestReservationGIFImageView: GIFImageView = {
        let imageView = GIFImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var moveReservationListButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("견적 예약 확인하기", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(moveReservationListButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var moveEstimateButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("견적 내러 가기", for: .normal)
        button.setTitleColor(.useRGB(red: 167, green: 167, blue: 167), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.addTarget(self, action: #selector(moveEstimateButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var subControllers: [UIViewController] = []
    var currentIndex: Int = 0
    
    let mainModel = MainModel()
    var tourId: Int = 1
    
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(completedReqeustReservation(_:)), name: Notification.Name("CompletedReqeustReservation"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
//            self.imageSlideShow,
            self.contentView,
            self.collectionView,
            self.completedRequestReservationBaseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.guideTitleLabel,
            self.guideLabel,
            self.completedRequestReservationGIFImageView,
            self.moveReservationListButton,
            self.moveEstimateButton,
        ], to: self.completedRequestReservationBaseView)
        
        addChild(self.pageViewController)
        
        SupportingMethods.shared.addSubviews([
            self.pageViewController.view,
        ], to: self.contentView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // imageSlideShow
//        NSLayoutConstraint.activate([
//            self.imageSlideShow.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            self.imageSlideShow.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            self.imageSlideShow.topAnchor.constraint(equalTo: self.view.topAnchor),
//            self.imageSlideShow.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 329/360),
//        ])
        
        // completedRequestReservationBaseView
        NSLayoutConstraint.activate([
            self.completedRequestReservationBaseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.completedRequestReservationBaseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.completedRequestReservationBaseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.completedRequestReservationBaseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // guideTitleLabel
        NSLayoutConstraint.activate([
            self.guideTitleLabel.leadingAnchor.constraint(equalTo: self.completedRequestReservationBaseView.leadingAnchor, constant: 30),
            self.guideTitleLabel.trailingAnchor.constraint(equalTo: self.completedRequestReservationBaseView.trailingAnchor, constant: -20),
            self.guideTitleLabel.topAnchor.constraint(equalTo: self.completedRequestReservationBaseView.topAnchor, constant: 100),
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.leadingAnchor.constraint(equalTo: self.completedRequestReservationBaseView.leadingAnchor, constant: 30),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.completedRequestReservationBaseView.trailingAnchor, constant: -20),
            self.guideLabel.topAnchor.constraint(equalTo: self.guideTitleLabel.bottomAnchor, constant: 10),
        ])
        
        // completedRequestReservationGIFImageView
        NSLayoutConstraint.activate([
            self.completedRequestReservationGIFImageView.centerYAnchor.constraint(equalTo: self.completedRequestReservationBaseView.centerYAnchor),
            self.completedRequestReservationGIFImageView.centerXAnchor.constraint(equalTo: self.completedRequestReservationBaseView.centerXAnchor),
            self.completedRequestReservationGIFImageView.heightAnchor.constraint(equalToConstant: 300),
            self.completedRequestReservationGIFImageView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        // moveReservationListButton
        NSLayoutConstraint.activate([
            self.moveReservationListButton.bottomAnchor.constraint(equalTo: self.completedRequestReservationBaseView.bottomAnchor, constant: -90),
            self.moveReservationListButton.centerXAnchor.constraint(equalTo: self.completedRequestReservationBaseView.centerXAnchor),
            self.moveReservationListButton.widthAnchor.constraint(equalToConstant: 170),
            self.moveReservationListButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // moveEstimateButton
        NSLayoutConstraint.activate([
            self.moveEstimateButton.centerXAnchor.constraint(equalTo: self.completedRequestReservationBaseView.centerXAnchor),
            self.moveEstimateButton.topAnchor.constraint(equalTo: self.moveReservationListButton.bottomAnchor, constant: 10),
        ])
        
        // contentView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
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
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
        self.getEstimateDataAtOnlyOnce { estimates in
            for estimate in estimates {
                if estimate.isCompletedReservation == false {
                    SupportingMethods.shared.showAlertNoti(title: "진행중인 견적이 있습니다.")
                    break
                    
                }
                
            }
            
        }
    }
    
    
    private func setUpNavigationTitle(isDetail: Bool = true) -> UIImageView {
        let navigationTitleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 107, height: 18))
        navigationTitleImageView.image = UIImage(named: isDetail ? "RedNavigationLogo" : "NavigationLogo")
        navigationTitleImageView.contentMode = .scaleAspectFit
        
        return navigationTitleImageView
    }
    
    func setUpNavigationItem(isDetail: Bool = true) {
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
        
        self.navigationItem.titleView = self.setUpNavigationTitle(isDetail: isDetail)
        
        let leftBarButtonItem = UIBarButtonItem(title: ReferenceValues.name == "null" ? "방문자" : "\(ReferenceValues.name)님", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .foregroundColor: UIColor.black,
            .font: UIFont.useFont(ofSize: 14, weight: .Medium)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: isDetail ? "RedProfile" : "Profile")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
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
    
//    func loadTourDataRequest(success: (([Tour]) -> ())?) {
//        self.mainModel.loadTourDataRequest { tourList in
//            success?(tourList)
//            
//        } failure: { message in
//            print("loadTourDataRequest error: \(message)")
//        }
//
//    }
    
    func getEstimateDataAtOnlyOnce(success: (([Estimate]) -> ())?) {
        self.mainModel.getEstimateDataAtOnlyOnce { estimate in
            success?(estimate)
            
        } failure: { message in
            print("error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
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
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = ProfileViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = TourDetailViewController()
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: 예약 완료 애니메이션
    @objc func completedReqeustReservation(_ notification: Notification) {
        self.guideTitleLabel.text = "견젹 예약이\n완료되었습니다!"
        self.guideLabel.text = "예약 정보를 확인하고 계약을 완료해주세요!"
        
        self.completedRequestReservationBaseView.isHidden = false
        self.moveReservationListButton.isHidden = false
        self.moveEstimateButton.isHidden = false
        self.completedRequestReservationGIFImageView.animate(withGIFNamed: "EstimateRequest", loopCount: 1, animationBlock:  {
            NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
        })
    }
    
    @objc func moveReservationListButton(_ sender: UIButton) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.completedRequestReservationBaseView.isHidden = true
        self.select(index: .detail)
        
    }    
    
    @objc func moveEstimateButton(_ sender: UIButton) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.completedRequestReservationBaseView.isHidden = true
        self.select(index: .estimate)
        
    }
    
    // MARK: 견적 완료 애니메이션
    @objc func completedEstimate(_ notification: Notification) {
        self.guideTitleLabel.text = "운행이 확정되었습니다!"
        self.guideLabel.text = "행복한 시간 되시길 바라겠습니다."
        
        self.completedRequestReservationBaseView.isHidden = false
        self.completedRequestReservationGIFImageView.animate(withGIFNamed: "CompletedReservation", loopCount: 1, animationBlock:  {
            NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)

            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.completedRequestReservationBaseView.isHidden = true
            self.select(index: .detail)
        })
    }
    
//    @objc func imageSlideShow(_ gesture: UITapGestureRecognizer) {
//        self.loadTourDataRequest { tourList in
//            let tour = tourList[self.tourId - 1]
//            self.mainModel.loadMyTourDataRequest(tourId: self.tourId) { MyTour in
//                let vc = TourDetailViewController(tour: tour, myTour: MyTour)
//
//                self.navigationController?.pushViewController(vc, animated: true)
//            } failure: { message in
//                let vc = TourDetailViewController(tour: tour)
//
//                self.navigationController?.pushViewController(vc, animated: true)
//                
//            }
//            
//        }
//        
//    }
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
