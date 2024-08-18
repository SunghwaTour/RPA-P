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
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.dateLabel,
            self.tableView,
        ], to: self.view)
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
            for estimate in estimates {
                if estimate.isCompletedReservation {
                    self.estimateList.append(estimate)
                    
                }
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        } failure: { error in
            print("setData Error: \(error)")
            SupportingMethods.shared.turnCoverView(.off)
            
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
