//
//  FAQViewController.swift
//  RPA-P
//
//  Created by 이주성 on 8/18/24.
//

import UIKit

struct FAQ {
    let title: String
    let content: String
}

final class FAQViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FAQTableViewCell.self, forCellReuseIdentifier: "FAQTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var faqList: [FAQ] = [
        FAQ(title: "킹버스 사용방법 안내", content: """
            MAIN 페이지에 나오는 출도착지 및 시간 입력 후 ‘다음’ 버튼을 누르시면 견적을 선택하는 페이지가 나옵니다.\n
            원하시는 견적 금액을 선택 후 ‘예약하기’를 선택해주세요.\n
            마지막으로 본인인증 후 결재 방법을 선택하시면 빠른 시간 안에 버스 회사에서 연락이 오게 됩니다!
            """),
        FAQ(title: "킹버스는 어떤 서비스인가요?", content: "전세버스 서비스를 원하시는 고객님들이 합리적인 가격 선택을 하실 수 있게 도우며, 행복한 운행이 되실 수 있게 해드리는 서비스입니다."),
        FAQ(title: "킹버스 결제는 어떻게 하나요?", content: "정확한 운행비는 예약하신 후 업체에서 따로 전화드려 조율하게 됩니다. 결재는 운행 전 계약금 납입(운행비의 약 8%)과 운행 후 운행비 납입이 있습니다."),
        FAQ(title: "킹버스 계약금이 얼마인가요?", content: "계약금은 운행비의 약 8%입니다."),
        FAQ(title: "킹버스 견적은 어떻게 산정되는 건가요?", content: "운행 KM 및 성수기, 지역별 지형 특성에 따라 금액이 산정됩니다."),
    ]
    
    var selectedIndex: Int? = nil
    
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
        print("----------------------------------- FAQViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension FAQViewController: EssentialViewMethods {
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
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
        
        self.navigationItem.title = "FAQ"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension FAQViewController {
    
}

// MARK: - Extension for selector methods
extension FAQViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
        let faq = self.faqList[indexPath.row]
        
        cell.setCell(faq: faq)
        
        cell.contentBaseView.isHidden = self.selectedIndex == indexPath.row ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndex == indexPath.row {
            self.selectedIndex = nil
            
        } else {
            self.selectedIndex = indexPath.row
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
}
