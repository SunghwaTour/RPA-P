//
//  SelectEstimateViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/13/24.
//

import UIKit

final class SelectEstimateViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy.MM.dd")
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var addressBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 243, blue: 243)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발"
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지 주소"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.adjustsFontSizeToFitWidth = true
        // label.numberOfLines = 2
        
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.06.19 (수)"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "06:30 AM"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착"
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지 주소"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.adjustsFontSizeToFitWidth = true
        // label.numberOfLines = 2
        
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.06.19 (수)"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if self.kindsOfEstimate == .oneWay {
            label.isHidden = true
            
        } else {
            label.isHidden = false
            
        }
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "06:30 PM"
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.textColor = .useRGB(red: 91, green: 91, blue: 91)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if self.kindsOfEstimate == .oneWay {
            label.isHidden = true
            
        } else {
            label.isHidden = false
            
        }
        
        return label
    }()
    
    lazy var estimateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다양한 견적을 비교해보세요!\n출발일 기준 일주일을 기준으로 견적이 추천됩니다."
        label.numberOfLines = 2
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.asFontColor(targetString: "출발일 기준 일주일을 기준으로 견적이 추천됩니다.", font: .useFont(ofSize: 14, weight: .Medium), color: .useRGB(red: 91, green: 91, blue: 91))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reservationBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var reservationContentLabel: UILabel = {
        let label = UILabel()
        label.text = "보는 눈이 있으시군요!"
        label.textColor = .useRGB(red: 115, green: 115, blue: 115)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("예약하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(reservationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        collectionView.backgroundColor = .white
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
//        tableView.bounces = false
        tableView.register(SelectEstimateTableViewCell.self, forCellReuseIdentifier: "SelectEstimateTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var estimate: Estimate
    var virtualEstimate: VirtualEstimate?
//    var virtualPrice: Int
    var kindsOfEstimate: KindsOfEstimate
    var allCategoryList: [Category] = [.general, .honor, .full, .partial]
    var virtualEstimateList: [VirtualEstimate] = []
    
    var selectedCategoryList: [Category] = []
    var selectedIndexForTableView: Int?
    
    var fullData: [VirtualEstimate] = [
        VirtualEstimate(no: 1, category: [.full, .honor], price: 0),
        VirtualEstimate(no: 2, category: [.full, .general], price: 0),
        VirtualEstimate(no: 3, category: [.partial, .honor], price: 0),
        VirtualEstimate(no: 4, category: [.partial, .general], price: 0),
    ]
    
    init(estimate: Estimate, virtualPrice: Int) {
        self.estimate = estimate
        self.kindsOfEstimate = estimate.kindsOfEstimate
//        self.virtualPrice = virtualPrice
        
        for index in 0..<self.fullData.count {
            var totalPrice = virtualPrice
            for category in self.fullData[index].category {
                totalPrice += category.price
                
            }
            self.fullData[index].price = totalPrice
            
        }
        print(self.fullData)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.setInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- SelectEstimateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension SelectEstimateViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        self.departureAddressLabel.text = self.estimate.departure.name
        self.departureDateLabel.text = self.estimate.departureDate.date
        self.departureTimeLabel.text = self.estimate.departureDate.time
        
        self.arrivalAddressLabel.text = self.estimate.return.name
        self.arrivalDateLabel.text = self.estimate.returnDate.date
        self.arrivalTimeLabel.text = self.estimate.returnDate.time
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.contentView,
        ], to: self.view)
        SupportingMethods.shared.addSubviews([
            self.dateLabel,
            self.addressBaseView,
            self.estimateTitleLabel,
            self.reservationBaseView,
            self.collectionView,
            self.tableView,
        ], to: self.contentView)
        
        SupportingMethods.shared.addSubviews([
            self.departureTitleLabel,
            self.departureAddressLabel,
            self.departureDateLabel,
            self.departureTimeLabel,
            
            self.arrivalTitleLabel,
            self.arrivalAddressLabel,
            self.arrivalDateLabel,
            self.arrivalTimeLabel,
            
        ], to: self.addressBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.reservationContentLabel,
            self.reservationButton,
        ], to: self.reservationBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // contentView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
        ])
        
        // addressBaseView
        NSLayoutConstraint.activate([
            self.addressBaseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.addressBaseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.addressBaseView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10),
        ])
        
        // departureTitleLabel
        NSLayoutConstraint.activate([
            self.departureTitleLabel.leadingAnchor.constraint(equalTo: self.addressBaseView.leadingAnchor, constant: 25),
            self.departureTitleLabel.topAnchor.constraint(equalTo: self.addressBaseView.topAnchor, constant: 10),
        ])
        
        // departureAddressLabel
        NSLayoutConstraint.activate([
            self.departureAddressLabel.leadingAnchor.constraint(equalTo: self.departureTitleLabel.trailingAnchor, constant: 10),
            self.departureAddressLabel.topAnchor.constraint(equalTo: self.addressBaseView.topAnchor, constant: 10),
            self.departureAddressLabel.trailingAnchor.constraint(equalTo: self.addressBaseView.trailingAnchor, constant: -10),
        ])
        
        // departureDateLabel
        NSLayoutConstraint.activate([
            self.departureDateLabel.leadingAnchor.constraint(equalTo: self.departureTitleLabel.trailingAnchor, constant: 10),
            self.departureDateLabel.topAnchor.constraint(equalTo: self.departureAddressLabel.bottomAnchor, constant: 5),
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.departureDateLabel.trailingAnchor, constant: 10),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.departureAddressLabel.bottomAnchor, constant: 5),
        ])
        
        // arrivalTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTitleLabel.leadingAnchor.constraint(equalTo: self.addressBaseView.leadingAnchor, constant: 25),
            self.arrivalTitleLabel.topAnchor.constraint(equalTo: self.departureDateLabel.bottomAnchor, constant: 10),
        ])
        
        // arrivalAddressLabel
        NSLayoutConstraint.activate([
            self.arrivalAddressLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleLabel.trailingAnchor, constant: 10),
            self.arrivalAddressLabel.centerYAnchor.constraint(equalTo: self.arrivalTitleLabel.centerYAnchor),
            self.arrivalAddressLabel.trailingAnchor.constraint(equalTo: self.addressBaseView.trailingAnchor, constant: -10),
        ])
        
        // arrivalDateLabel
        NSLayoutConstraint.activate([
            self.arrivalDateLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleLabel.trailingAnchor, constant: 10),
            self.arrivalDateLabel.topAnchor.constraint(equalTo: self.arrivalAddressLabel.bottomAnchor, constant: 5),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalDateLabel.trailingAnchor, constant: 10),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalAddressLabel.bottomAnchor, constant: 5),
            self.arrivalTimeLabel.bottomAnchor.constraint(equalTo: self.addressBaseView.bottomAnchor, constant: -10),
        ])
        
        // estimateTitleLabel
        NSLayoutConstraint.activate([
            self.estimateTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            self.estimateTitleLabel.topAnchor.constraint(equalTo: self.addressBaseView.bottomAnchor, constant: 30)
        ])
        
        // reservationBaseView
        NSLayoutConstraint.activate([
            self.reservationBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.reservationBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.reservationBaseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.reservationBaseView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        // reservationContentLabel
        NSLayoutConstraint.activate([
            self.reservationContentLabel.leadingAnchor.constraint(equalTo: self.reservationBaseView.leadingAnchor, constant: 20),
            self.reservationContentLabel.topAnchor.constraint(equalTo: self.reservationBaseView.topAnchor, constant: 14),
        ])
        
        // reservationButton
        NSLayoutConstraint.activate([
            self.reservationButton.trailingAnchor.constraint(equalTo: self.reservationBaseView.trailingAnchor, constant: -36),
            self.reservationButton.topAnchor.constraint(equalTo: self.reservationBaseView.topAnchor, constant: 16),
            self.reservationButton.heightAnchor.constraint(equalToConstant: 48),
            self.reservationButton.widthAnchor.constraint(equalToConstant: 128),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.collectionView.topAnchor.constraint(equalTo: self.estimateTitleLabel.bottomAnchor, constant: 10),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 5),
            self.tableView.bottomAnchor.constraint(equalTo: self.reservationBaseView.topAnchor, constant: -5),
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
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 0, green: 0, blue: 0, alpha: 0.87),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "원하는 조건에 맞게 골라보세요."
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setInitialData() {
        self.virtualEstimateList = self.fullData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
}

// MARK: - Extension for methods added
extension SelectEstimateViewController {
    
}

// MARK: - Extension for selector methods
extension SelectEstimateViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func reservationButton(_ sender: UIButton) {
        guard let selectedIndexForTableView = self.selectedIndexForTableView else {
            SupportingMethods.shared.showAlertNoti(title: "견적을 선택해주세요.")
            return
        }
        self.estimate.virtualEstimate = self.virtualEstimate
        
        let vc = PaymentViewController(estimate: self.estimate)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension SelectEstimateViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let category = self.allCategoryList[indexPath.row]
        
        cell.setCell(category: category.rawValue)
        
        if self.selectedCategoryList.contains(category) {
            cell.categoryView.backgroundColor = .useRGB(red: 255, green: 160, blue: 160)
            cell.categoryLabel.textColor = .white
            
        } else {
            cell.categoryView.backgroundColor = .white
            cell.categoryLabel.textColor = .useRGB(red: 255, green: 160, blue: 160)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexForTableView = nil
        
        let category = self.allCategoryList[indexPath.row]
        
        if self.selectedCategoryList.contains(category) {
            for index in 0..<self.selectedCategoryList.count {
                if self.selectedCategoryList[index] == category {
                    self.selectedCategoryList.remove(at: index)
                    break
                    
                }
                
            }
            
        } else {
            if self.selectedCategoryList.isEmpty {
                self.selectedCategoryList.append(category)
                
            } else {
                for index in 0..<self.selectedCategoryList.count {
                    if self.selectedCategoryList[index].kindsNumber == category.kindsNumber {
                        self.selectedCategoryList.remove(at: index)
                        self.selectedCategoryList.append(category)
                        break
                        
                    } else {
                        self.selectedCategoryList.append(category)
                        break
                        
                    }
                    
                }
                
            }
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
        self.virtualEstimateList = []
        if self.selectedCategoryList.isEmpty {
            self.virtualEstimateList = self.fullData
            
        } else {
            for data in self.fullData {
                if data.category.contains(category) {
                    if self.virtualEstimateList.isEmpty {
                        self.virtualEstimateList.append(data)
                        
                    } else {
                        for item in self.virtualEstimateList {
                            if data.no != item.no {
                                self.virtualEstimateList.append(data)
                                break
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource {
extension SelectEstimateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.virtualEstimateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectEstimateTableViewCell", for: indexPath) as! SelectEstimateTableViewCell
        let virtualEstimate = self.virtualEstimateList[indexPath.row]
        
        cell.setCell(virtualEstimate: virtualEstimate)
        
        cell.estimateBaseView.backgroundColor = self.selectedIndexForTableView == indexPath.row ? .useRGB(red: 255, green: 248, blue: 248) : .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexForTableView = self.selectedIndexForTableView == indexPath.row ? nil : indexPath.row
        self.virtualEstimate = self.virtualEstimateList[indexPath.row]
        
        self.tableView.reloadData()
        
    }
}
