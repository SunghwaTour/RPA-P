//
//  BusViewController.swift
//  RPA-P
//
//  Created by Awesomepia on 8/28/24.
//

import UIKit

struct Bus {
    let name: String
    let content: String
    let busType: String
    let imageName: String
}

private enum Index {
    static let itemSize = CGSize(width: 240, height: 240)
    static let itemSpacing = 24.0
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - self.itemSize.width) / 2.0
        
    }
    
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        
    }
}

final class BusViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 54, height: 20)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(KindsOfBusCollectionViewCell.self, forCellWithReuseIdentifier: "KindsOfBusCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var kindsOfBusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var busCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 240, height: 300)
        flowLayout.minimumLineSpacing = 24
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(BusImageCollectionViewCell.self, forCellWithReuseIdentifier: "BusImageCollectionViewCell")
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
    
    lazy var busNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 74, green: 74, blue: 74)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let kindsOfBusList: [String] = ["벤", "중형", "대형", "대형 우등", "대형 우등", "프리미엄", "프리미엄"]
    var selectedIndex: Int = 0
    
    let busList: [Bus] = [
        Bus(name: "현대/쏠라티", content: "현대 쏠라티는 넓은 실내 공간과 편안한 좌석으로 장거리 여행에서도 쾌적한 승차감을 제공하며, 에어컨과 USB 입력 등의 현대적인 편의 시설을 갖춰 승객들이 편리하게 이용할 수 있습니다현대 쏠라티는 넓은 실내 공간과 편안한 좌석으로 장거리 여행에서도 쾌적한 승차감을 제공하며, 에어컨과 USB 입력 등의 현대적인 편의 시설을 갖춰 승객들이 편리하게 이용할 수 있습니다", busType: "14인승", imageName: "Solati"),
        Bus(name: "현대/뉴카운티", content: "현대 뉴 카운티는 편안한 좌석과 최적화된 서스펜션으로 쾌적한 승차감을 제공하며, 에어컨과 맞춤형 수납공간 등 다양한 편의 시설로 고객에게 만족스러운 서비스를 선사합니다.", busType: "25~29인승", imageName: "NewCounty"),
        Bus(name: "현대/유니버스", content: "현대 유니버스는 넓고 고급스러운 실내 공간과 공기 서스펜션을 통해 승객에게 편안한 승차감을 제공하며, 통합 에어컨과 조명 시스템으로 쾌적한 환경을 조성해 장거리 여행에 적합합니다​", busType: "41~45인승", imageName: "Universe"),
        Bus(name: "기아/뉴그랜버드", content: "기아 뉴 그랜버드는 넓은 실내 공간과 고급스러운 인테리어로 승객들에게 편안함을 제공하며, 첨단 기술을 기반으로 한 탁월한 주행 성능과 부드러운 승차감을 자랑합니다. 또한, 현대적인 편의 시설을 갖추고 있어 장거리 여행에도 쾌적한 환경을 유지할 수 있습니다​", busType: "45~49인승", imageName: "NewGranbird"),
        Bus(name: "현대/유니버스-프라임", content: "현대 유니버스-프라임은 넓은 좌석과 인체공학적 설계로 최상의 승차감을 제공하며, 에어컨과 멀티미디어 시스템 등 다양한 편의 시설로 고객에게 탁월한 서비스 경험을 선사합니다.", busType: "41~45인승", imageName: "UniversePrime"),
        Bus(name: "현대/유니버스-노블", content: "현대 유니버스 노블은 고급스러운 실내 공간과 현대적인 편의 시설을 통해 승객들에게 뛰어난 서비스 경험을 제공합니다. 이 버스는 에어 서스펜션을 사용하여 부드러운 승차감을 제공하며, 조용한 실내 환경과 통합 공조 시스템으로 쾌적한 여행을 보장합니다", busType: "41~45인승", imageName: "UniverseNoble"),
        Bus(name: "기아/뉴그랜버드-실크로드", content: "기아 뉴 그랜버드 실크로드는 넓고 고급스러운 실내 공간을 제공하며, 승객들에게 편안하고 쾌적한 여행 경험을 선사합니다. 이 버스는 강력한 엔진과 에어 서스펜션을 통해 부드러운 승차감을 제공하며, 최신 편의 시설을 갖추고 있어 장거리 이동에도 최적화되어 있습니다. 또한, 현대적인 디자인과 고급스러운 마감재로 스타일을 중시하는 고객에게 적합합니다​", busType: "45~49인승", imageName: "NewGranbirdSilkRoad"),
    ]
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- BusViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension BusViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        self.kindsOfBusImageView.image = .useCustomImage(self.busList[0].busType)
        self.busNameLabel.text = self.busList[0].name
        self.contentLabel.text = self.busList[0].content
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.collectionView,
            self.kindsOfBusImageView,
            self.busCollectionView,
            self.busNameLabel,
            self.contentLabel,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            self.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            self.collectionView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // kindsOfBusImageView
        NSLayoutConstraint.activate([
            self.kindsOfBusImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.kindsOfBusImageView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 20),
            self.kindsOfBusImageView.widthAnchor.constraint(equalToConstant: 101),
            self.kindsOfBusImageView.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // busCollectionView
        NSLayoutConstraint.activate([
            self.busCollectionView.heightAnchor.constraint(equalToConstant: 300),
            self.busCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.busCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.busCollectionView.topAnchor.constraint(equalTo: self.kindsOfBusImageView.bottomAnchor, constant: 10)
        ])
        
        // busNameLabel
        NSLayoutConstraint.activate([
            self.busNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.busNameLabel.topAnchor.constraint(equalTo: self.busCollectionView.bottomAnchor, constant: 10),
            self.busNameLabel.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        // contentLabel
        NSLayoutConstraint.activate([
            self.contentLabel.topAnchor.constraint(equalTo: self.busNameLabel.bottomAnchor, constant: 15),
            self.contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "버스 종류 안내"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
}

// MARK: - Extension for methods added
extension BusViewController {
    
}

// MARK: - Extension for selector methods
extension BusViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

// MARK: - Extension for methods added
extension BusViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.kindsOfBusList.count
            
        } else {
            return self.busList.count
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KindsOfBusCollectionViewCell", for: indexPath) as! KindsOfBusCollectionViewCell
            let bus = self.kindsOfBusList[indexPath.row]
            
            cell.setCell(busType: bus)
            cell.titleLabel.textColor = self.selectedIndex == indexPath.row ? .useRGB(red: 184, green: 0, blue: 0) : .useRGB(red: 169, green: 169, blue: 169)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusImageCollectionViewCell", for: indexPath) as! BusImageCollectionViewCell
            let bus = self.busList[indexPath.row]
            
            cell.setCell(image: bus.imageName)
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            self.selectedIndex = indexPath.row
            self.busCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.kindsOfBusImageView.image = .useCustomImage(self.busList[indexPath.row].busType)
            self.busNameLabel.text = self.busList[indexPath.row].name
            self.contentLabel.text = self.busList[indexPath.row].content
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == self.busCollectionView {
            let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
            let cellWidth = Index.itemSize.width + Index.itemSpacing
            let index = round(scrolledOffsetX / cellWidth)
            targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
            
            print("index: \(index)")
            self.kindsOfBusImageView.image = .useCustomImage(self.busList[Int(index)].busType)
            self.busNameLabel.text = self.busList[Int(index)].name
            self.contentLabel.text = self.busList[Int(index)].content
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.busCollectionView {
            let scrolledOffset = scrollView.contentOffset.x + scrollView.contentInset.left
            let cellWidth = Index.itemSize.width + Index.itemSpacing
            let index = Int(round(scrolledOffset / cellWidth))
            
            self.selectedIndex = index
            self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
}
