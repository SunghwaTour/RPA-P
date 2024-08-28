//
//  ProfileViewController.swift
//  RPA-P
//
//  Created by 이주성 on 8/18/24.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    lazy var useCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(location: .bottom, color: .useRGB(red: 255, green: 149, blue: 149, alpha: 0.25))
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var useCountGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "현재까지\n사용하신 킹버스 횟수입니다."
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var useCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ReferenceValues.useCount)"
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reservationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "예약 현황"
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProfileDetailInfoTableViewCell.self, forCellReuseIdentifier: "ProfileDetailInfoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let titles: [String] = ["지난 예약 내역", "버스 종류 안내", "고객센터"]
    
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
        print("----------------------------------- ProfileViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ProfileViewController: EssentialViewMethods {
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
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.useCountView,
            self.reservationTitleLabel,
            self.tableView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.useCountGuideLabel,
            self.useCountLabel
        ], to: self.useCountView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // useCountView
        NSLayoutConstraint.activate([
            self.useCountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.useCountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.useCountView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            self.useCountView.heightAnchor.constraint(equalToConstant: 64),
        ])
        
        // useCountGuideLabel
        NSLayoutConstraint.activate([
            self.useCountGuideLabel.leadingAnchor.constraint(equalTo: self.useCountView.leadingAnchor, constant: 15),
            self.useCountGuideLabel.centerYAnchor.constraint(equalTo: self.useCountView.centerYAnchor),
        ])
        
        // useCountLabel
        NSLayoutConstraint.activate([
            self.useCountLabel.trailingAnchor.constraint(equalTo: self.useCountView.trailingAnchor, constant: -30),
            self.useCountLabel.centerYAnchor.constraint(equalTo: self.useCountView.centerYAnchor),
        ])
        
        // reservationTitleLabel
        NSLayoutConstraint.activate([
            self.reservationTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.reservationTitleLabel.topAnchor.constraint(equalTo: self.useCountView.bottomAnchor, constant: 20),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.tableView.topAnchor.constraint(equalTo: self.reservationTitleLabel.bottomAnchor, constant: 10),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.tableView.heightAnchor.constraint(equalToConstant: 142),
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
        
        self.navigationItem.title = "내 정보"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension ProfileViewController {
    
}

// MARK: - Extension for selector methods
extension ProfileViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

// MARK: - Extension for
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailInfoTableViewCell", for: indexPath) as! ProfileDetailInfoTableViewCell
        let title = self.titles[indexPath.row]
        
        cell.setCell(title: title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.titles[indexPath.row])
        switch indexPath.row {
        case 0:
            let vc = PastHistoryViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = BusViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CustomerServiceViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
    
}
