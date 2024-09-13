//
//  PastHistoryViewController.swift
//  RPA-P
//
//  Created by 이주성 on 8/18/24.
//

import UIKit

final class PastHistoryViewController: UIViewController {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy.MM.dd")
        label.textColor = .useRGB(red: 131, green: 131, blue: 131)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var emptyBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pastNoEstimateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("PastNoEstimateImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var emptyButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("신청한 견적이 없습니다.\n견적을 추가해보세요!", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 0
        button.addTarget(self, action: #selector(emptyButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PastHistoryTableViewCell.self, forCellReuseIdentifier: "PastHistoryTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var estimateList: [Estimate] = []
    let mainModel = MainModel()
    
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
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- PastHistoryViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension PastHistoryViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name:  Notification.Name("ReloadDataForMoreInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginDone(_:)), name:  Notification.Name("LoginDone"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.dateLabel,
            self.tableView,
            self.emptyBaseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.pastNoEstimateImageView,
            self.emptyButton,
        ], to: self.emptyBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.dateLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // emptyBaseView
        NSLayoutConstraint.activate([
            self.emptyBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.emptyBaseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // pastNoEstimateImageView
        NSLayoutConstraint.activate([
            self.pastNoEstimateImageView.topAnchor.constraint(equalTo: self.emptyBaseView.topAnchor, constant: 116),
            self.pastNoEstimateImageView.widthAnchor.constraint(equalToConstant: 153),
            self.pastNoEstimateImageView.heightAnchor.constraint(equalToConstant: 142),
            self.pastNoEstimateImageView.centerXAnchor.constraint(equalTo: self.emptyBaseView.centerXAnchor),
        ])
        
        // emptyButton
        NSLayoutConstraint.activate([
            self.emptyButton.topAnchor.constraint(equalTo: self.pastNoEstimateImageView.bottomAnchor, constant: 56),
            self.emptyButton.centerXAnchor.constraint(equalTo: self.pastNoEstimateImageView.centerXAnchor),
            self.emptyButton.widthAnchor.constraint(equalToConstant: 156),
            self.emptyButton.heightAnchor.constraint(equalToConstant: 48),
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
        
        self.navigationItem.title = "지난 견적 내역"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.mainModel.getEstimateData { estimates in
            if estimates.isEmpty {
                self.emptyBaseView.isHidden = false
                self.emptyButton.isEnabled = false
                self.emptyButton.setTitle("신청한 견적이 없습니다.\n견적을 추가해보세요!", for: .normal)
                self.emptyButton.layer.borderWidth = 0.0
                self.pastNoEstimateImageView.image = .useCustomImage("PastNoEstimateImage")
                SupportingMethods.shared.turnCoverView(.off)
                
            } else {
                self.emptyBaseView.isHidden = true
                for estimate in estimates {
                    if estimate.isCompletedReservation {
                        self.estimateList.append(estimate)
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    SupportingMethods.shared.turnCoverView(.off)
                    
                }
                
            }
            
        } failure: { error in
            if error == "noLogin" {
                print("\(error)")
                self.emptyBaseView.isHidden = false
                self.emptyButton.isEnabled = true
                self.emptyButton.setTitle("전화번호 인증이 필요합니다!", for: .normal)
                self.emptyButton.layer.borderWidth = 2.0
                self.pastNoEstimateImageView.image = .useCustomImage("customerServiceLogo")
                
                SupportingMethods.shared.turnCoverView(.off)
                
            } else {
                print("setData Error: \(error)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
}

// MARK: - Extension for methods added
extension PastHistoryViewController {
    
}

// MARK: - Extension for selector methods
extension PastHistoryViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func reload(_ notification: Notification) {
        self.tableView.reloadData()
        
    }
    
    @objc func emptyButton(_ sender: UIButton) {
        let vc = LoginViewController()
        
        self.present(vc, animated: true)
    }
    
    @objc func loginDone(_ notification: Notification) {
        self.setData()
        
    }
    
}

extension PastHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.estimateList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastHistoryTableViewCell", for: indexPath) as! PastHistoryTableViewCell
        let estimate = self.estimateList[indexPath.row]
        
        cell.setCell(estimate: estimate)
        
        return cell
    }
}
