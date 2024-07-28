//
//  EstimateDetailViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/12/24.
//

import UIKit

final class EstimateDetailViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var indicatorSizeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.register(EstimateDetailTableViewCell.self, forCellReuseIdentifier: "EstimateDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var estimateList: [Estimate] = []
    var tempEstimate: Estimate?
    
    init() {
        
        if let estimateList = SupportingMethods.shared.readLocalEstimateData() {
            self.estimateList = estimateList
            
        }
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- EstimateDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension EstimateDetailViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(reservationConfirmButton(_:)), name: Notification.Name("RservationConfirmation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name:  Notification.Name("ReloadDataForMoreInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(estimateConfirm(_:)), name:  Notification.Name("EstimateConfirmation"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveEstimateData(_:)), name:  Notification.Name("SaveEstimateData"), object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.contentView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.indicatorSizeView,
            self.tableView,
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
        
        // indicatorSizeView
        NSLayoutConstraint.activate([
            self.indicatorSizeView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.indicatorSizeView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.indicatorSizeView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.indicatorSizeView.heightAnchor.constraint(equalToConstant: 27.5)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.indicatorSizeView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension EstimateDetailViewController {
    
}

// MARK: - Extension for selector methods
extension EstimateDetailViewController {    
    @objc func reservationConfirmButton(_ notification: Notification) {
        guard let estimate = notification.userInfo?["estimate"] as? Estimate else { return }
        self.tempEstimate = estimate
        let vc = EstimateConfirmationViewController()
        
        self.present(vc, animated: true)
        
    }
    
    @objc func reload(_ notification: Notification) {
        self.tableView.reloadData()
        
    }
    
    @objc func estimateConfirm(_ notificatoin: Notification) {
        print("estimateConfirm")
        let vc = ReservationAnnouncementViewController(estimate: self.tempEstimate!)
        
        self.present(vc, animated: true)
    }
    
    @objc func saveEstimateData(_ notification: Notification) {
         guard let data = notification.userInfo?["estimate"] as? Estimate else { return }
        
        self.estimateList.append(data)
        SupportingMethods.shared.saveLocalEstimateData(estimateList: self.estimateList)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource {
extension EstimateDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.estimateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EstimateDetailTableViewCell", for: indexPath) as! EstimateDetailTableViewCell
        let estimate = self.estimateList[indexPath.row]
        
        cell.setCell(estimate: estimate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
