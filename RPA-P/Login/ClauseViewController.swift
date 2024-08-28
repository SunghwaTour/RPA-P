//
//  ClauseViewController.swift
//  RPA-P
//
//  Created by Awesomepia on 8/28/24.
//

import UIKit

final class ClauseViewController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("ClauseLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "고객님\n환영합니다!"
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var allAgreeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 247)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var allAgreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("check.no")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var allAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 약관 동의"
        label.textColor = .useRGB(red: 30, green: 30, blue: 30)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var allAgreeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(allAgreeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ClauseTableViewCell.self, forCellReuseIdentifier: "ClauseTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.useRGB(red: 192, green: 192, blue: 192), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 235, green: 235, blue: 235)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    var selectedIndexes: [Int] = []
    var clauseList: [String] = ["이용약관 동의[필수]", "개인정보 수집 및 이용 동의", "E-mail 및 sns 광고성 정보 수신동의[선택]"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
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
        print("----------------------------------- ClauseViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ClauseViewController: EssentialViewMethods {
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
            self.logoImageView,
            self.welcomeLabel,
            self.allAgreeBaseView,
            self.tableView,
            self.nextButton,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.allAgreeImageView,
            self.allAgreeLabel,
            self.allAgreeButton,
        ], to: self.allAgreeBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100),
            self.logoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 90),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 90),
        ])
        
        NSLayoutConstraint.activate([
            self.welcomeLabel.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 10),
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.logoImageView.centerXAnchor),
        ])
        
        // allAgreeBaseView
        NSLayoutConstraint.activate([
            self.allAgreeBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.allAgreeBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.allAgreeBaseView.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        // allAgreeImageView
        NSLayoutConstraint.activate([
            self.allAgreeImageView.leadingAnchor.constraint(equalTo: self.allAgreeBaseView.leadingAnchor, constant: 16),
            self.allAgreeImageView.centerYAnchor.constraint(equalTo: self.allAgreeBaseView.centerYAnchor),
            self.allAgreeImageView.widthAnchor.constraint(equalToConstant: 20),
            self.allAgreeImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // allAgreeLabel
        NSLayoutConstraint.activate([
            self.allAgreeLabel.leadingAnchor.constraint(equalTo: self.allAgreeImageView.trailingAnchor, constant: 8),
            self.allAgreeLabel.centerYAnchor.constraint(equalTo: self.allAgreeImageView.centerYAnchor),
        ])
        
        // allAgreeButton
        NSLayoutConstraint.activate([
            self.allAgreeButton.topAnchor.constraint(equalTo: self.allAgreeBaseView.topAnchor),
            self.allAgreeButton.bottomAnchor.constraint(equalTo: self.allAgreeBaseView.bottomAnchor),
            self.allAgreeButton.leadingAnchor.constraint(equalTo: self.allAgreeBaseView.leadingAnchor),
            self.allAgreeButton.trailingAnchor.constraint(equalTo: self.allAgreeBaseView.trailingAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.heightAnchor.constraint(equalToConstant: 150),
            self.tableView.topAnchor.constraint(equalTo: self.allAgreeBaseView.bottomAnchor, constant: 16),
            self.tableView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -10),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        // nextButton
        NSLayoutConstraint.activate([
            self.nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            self.nextButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.nextButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            self.nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension ClauseViewController {
    
}

// MARK: - Extension for selector methods
extension ClauseViewController {
    @objc func allAgreeButton(_ sender: UIButton) {
        if self.selectedIndexes.count == 3 {
            self.selectedIndexes.removeAll()
            self.allAgreeImageView.image = .useCustomImage("check.no")
            self.nextButton.backgroundColor = .useRGB(red: 235, green: 235, blue: 235)
            self.nextButton.setTitleColor(.useRGB(red: 192, green: 192, blue: 192), for: .normal)
            self.nextButton.isEnabled = false
            
        } else {
            self.selectedIndexes = [0,1,2]
            self.allAgreeImageView.image = .useCustomImage("check.yes")
            self.nextButton.backgroundColor = .useRGB(red: 40, green: 102, blue: 211)
            self.nextButton.setTitleColor(.white, for: .normal)
            self.nextButton.isEnabled = true
            
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
    @objc func nextButton(_ sender: UIButton) {
        if self.selectedIndexes.count >= 2 {
            let mainVC = CustomizedNavigationController(rootViewController: MainViewController())
            
            mainVC.modalTransitionStyle = .crossDissolve
            mainVC.modalPresentationStyle = .fullScreen
            
            self.present(mainVC, animated: true) {
                ReferenceValues.isLaunchedBefore = true
                
            }
            
        } else {
            SupportingMethods.shared.showAlertNoti(title: "약관 동의를 해주셔야 이용이 가능합니다.")
            
        }
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension ClauseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clauseList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClauseTableViewCell", for: indexPath) as! ClauseTableViewCell
        let clause = self.clauseList[indexPath.row]
        
        cell.setCell(clause: clause)
        if self.selectedIndexes.contains(indexPath.row) {
            cell.agreeImageView.image = .useCustomImage("check.yes")
            
        } else {
            cell.agreeImageView.image = .useCustomImage("check.no")
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndexes.contains(indexPath.row) {
            self.selectedIndexes = self.selectedIndexes.filter({ $0 != indexPath.row })
            
        } else {
            self.selectedIndexes.append(indexPath.row)
            
        }
        
        if self.selectedIndexes.contains(0) && self.selectedIndexes.contains(1) {
            if self.selectedIndexes.count == 3 {
                self.allAgreeImageView.image = .useCustomImage("check.yes")
                
            } else {
                self.allAgreeImageView.image = .useCustomImage("check.no")
                
            }
            
            self.nextButton.backgroundColor = .useRGB(red: 40, green: 102, blue: 211)
            self.nextButton.setTitleColor(.white, for: .normal)
            self.nextButton.isEnabled = true
            
        } else {
            self.allAgreeImageView.image = .useCustomImage("check.no")
            
            self.nextButton.backgroundColor = .useRGB(red: 235, green: 235, blue: 235)
            self.nextButton.setTitleColor(.useRGB(red: 192, green: 192, blue: 192), for: .normal)
            self.nextButton.isEnabled = false
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
}

