//
//  RenewalMainViewController.swift
//  RPA-P
//
//  Created by Awesomepia on 9/1/24.
//

import UIKit

final class RenewalMainViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ImageSlideShowTableViewCell.self, forCellReuseIdentifier: "ImageSlideShowTableViewCell")
        tableView.register(MainContentsTableViewCell.self, forCellReuseIdentifier: "MainContentsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
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
        print("----------------------------------- RenewalMainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalMainViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushView(_:)), name: Notification.Name("PushTourView"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
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
}

// MARK: - Extension for methods added
extension RenewalMainViewController {
    
}

// MARK: - Extension for selector methods
extension RenewalMainViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = ProfileViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushView(_ notification: Notification) {
//        let vc = TourDetailViewController()
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension for ImageSlideshowDelegate
extension RenewalMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSlideShowTableViewCell", for: indexPath) as! ImageSlideShowTableViewCell
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainContentsTableViewCell", for: indexPath) as! MainContentsTableViewCell
            
            return cell
            
        default: return UITableViewCell()
        }
    }
    
}
