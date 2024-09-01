//
//  TourDetailViewController.swift
//  RPA-P
//
//  Created by 이주성 on 8/31/24.
//

import UIKit

final class TourDetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BasicInfoTableViewCell.self, forCellReuseIdentifier: "BasicInfoTableViewCell")
        tableView.register(AddressTourTableViewCell.self, forCellReuseIdentifier: "AddressTourTableViewCell")
        tableView.register(ReservationTourTableViewCell.self, forCellReuseIdentifier: "ReservationTourTableViewCell")
        tableView.register(GuideTableViewCell.self, forCellReuseIdentifier: "GuideTableViewCell")
        tableView.register(ReservationButtonTableViewCell.self, forCellReuseIdentifier: "ReservationButtonTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var guideBackgroudView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전화 예약하기"
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var guideTourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("tourRequestGuide")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Regular)
        button.backgroundColor = .useRGB(red: 255, green: 238, blue: 238)
        button.addTarget(self, action: #selector(cancelButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Regular)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.addTarget(self, action: #selector(callButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let mainModel = MainModel()
    var tour: Tour
    var myTour: MyTour?
    var status: String = "off"
    
    var bankInfo: (bank: String, name: String) = ("", "")
    
    init(tour: Tour, myTour: MyTour? = nil) {
        self.tour = tour
        self.myTour = myTour
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- TourDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension TourDetailViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: Notification.Name("reloadDataForDesgin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(buttonOn(_:)), name: Notification.Name("reservationButtonOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendTourData(_:)), name: Notification.Name("SendTourData"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
            self.guideBackgroudView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.guideBaseView,
        ], to: self.guideBackgroudView)
        
        SupportingMethods.shared.addSubviews([
            self.guideTitleLabel,
            self.guideTourImageView,
            self.cancelButton,
            self.callButton,
        ], to: self.guideBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // guideBackgroudView
        NSLayoutConstraint.activate([
            self.guideBackgroudView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.guideBackgroudView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.guideBackgroudView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.guideBackgroudView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // guideBaseView
        NSLayoutConstraint.activate([
            self.guideBaseView.centerXAnchor.constraint(equalTo: self.guideBackgroudView.centerXAnchor),
            self.guideBaseView.centerYAnchor.constraint(equalTo: self.guideBackgroudView.centerYAnchor),
            self.guideBaseView.widthAnchor.constraint(equalToConstant: 290),
            self.guideBaseView.heightAnchor.constraint(equalToConstant: 285),
        ])
        
        // guideTitleLabel
        NSLayoutConstraint.activate([
            self.guideTitleLabel.centerXAnchor.constraint(equalTo: self.guideBaseView.centerXAnchor),
            self.guideTitleLabel.topAnchor.constraint(equalTo: self.guideBaseView.topAnchor, constant: 26),
        ])
        
        // guideTourImageView
        NSLayoutConstraint.activate([
            self.guideTourImageView.widthAnchor.constraint(equalToConstant: 246),
            self.guideTourImageView.heightAnchor.constraint(equalToConstant: 114),
            self.guideTourImageView.topAnchor.constraint(equalTo: self.guideTitleLabel.bottomAnchor, constant: 22),
            self.guideTourImageView.centerXAnchor.constraint(equalTo: self.guideBaseView.centerXAnchor),
        ])
        
        // cancelButton
        NSLayoutConstraint.activate([
            self.cancelButton.leadingAnchor.constraint(equalTo: self.guideBaseView.leadingAnchor),
            self.cancelButton.bottomAnchor.constraint(equalTo: self.guideBaseView.bottomAnchor),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 145),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // callButton
        NSLayoutConstraint.activate([
            self.callButton.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor),
            self.callButton.trailingAnchor.constraint(equalTo: self.guideBaseView.trailingAnchor),
            self.callButton.bottomAnchor.constraint(equalTo: self.guideBaseView.bottomAnchor),
            self.callButton.widthAnchor.constraint(equalTo: self.cancelButton.widthAnchor, multiplier: 1.0),
            self.callButton.heightAnchor.constraint(equalTo: self.cancelButton.heightAnchor, multiplier: 1.0),
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
        
        self.navigationItem.title = "예약하기"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension TourDetailViewController {
    func getTokenRequest(success: (() -> ())?) {
        self.mainModel.getTokenRequest {
            success?()
            
        } failure: { message in
            print("TourDetailViewController getTokenRequest error: \(message)")
            
        }

    }
    
    func sendTourRequest(tourId: String, name: String, phone: String, bank: String, success: (() -> ())?) {
        self.getTokenRequest {
            self.mainModel.sendTourRequest(tourId: tourId, name: name, phone: phone, bank: bank) {
                success?()
                
            } failure: { message in
                print("TourDetailViewController sendTourRequest error: \(message)")
                let url = "tel://1522-9821"
                
                if let openApp = URL(string: url), UIApplication.shared.canOpenURL(openApp) {
                    // 버전별 처리
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
                        
                    } else {
                        UIApplication.shared.openURL(openApp)
                        
                    }
                }
                
                //외부앱 실행이 불가능한 경우
                else {
                    print("[외부 앱 열기 실패]")
                    print("주소 : \(url)")
                    
                }
            }

        }
    }
}

// MARK: - Extension for selector methods
extension TourDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func reloadData(_ notification: Notification) {
        self.tableView.reloadData()
        
    }
    
    @objc func buttonOn(_ notification: Notification) {
        guard let bank = notification.userInfo?["bank"] as? String else { return }
        guard let name = notification.userInfo?["name"] as? String else { return }
        
        self.bankInfo.bank = bank
        self.bankInfo.name = name
        self.status = "on"
        self.tableView.reloadData()
        
    }
    
    @objc func sendTourData(_ notification: Notification) {
        self.mainModel.registerTourData(tourId: self.tour.id, name: self.bankInfo.name, bank: self.bankInfo.bank, placeName: tour.placeName) {
            self.guideBackgroudView.isHidden = false
            
        } failure: { message in
            print("sendTourData registerTourData: \(message)")
            
        }
        
    }
    
    @objc func cancelButton(_ sender: UIButton) {
        self.guideBackgroudView.isHidden = true
        
    }
    
    @objc func callButton(_ sender: UIButton) {
        self.sendTourRequest(tourId: "\(self.tour.id)", name: self.bankInfo.name, phone: ReferenceValues.phoneNumber, bank: self.bankInfo.bank) {
            print("success sendTourData")
            let url = "tel://1522-9821"
            
            if let openApp = URL(string: url), UIApplication.shared.canOpenURL(openApp) {
                // 버전별 처리
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
                    
                } else {
                    UIApplication.shared.openURL(openApp)
                    
                }
            }
            
            //외부앱 실행이 불가능한 경우
            else {
                print("[외부 앱 열기 실패]")
                print("주소 : \(url)")
                
            }
        }
        
    }
}

extension TourDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInfoTableViewCell", for: indexPath) as! BasicInfoTableViewCell
            
            cell.setCell(tour: self.tour, myTour: self.myTour)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTourTableViewCell", for: indexPath) as! AddressTourTableViewCell
            
            cell.setCell(tour: self.tour)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationTourTableViewCell", for: indexPath) as! ReservationTourTableViewCell
            
            cell.setCell(myTour: self.myTour)
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GuideTableViewCell", for: indexPath) as! GuideTableViewCell
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationButtonTableViewCell", for: indexPath) as! ReservationButtonTableViewCell
            
            cell.setCell(status: self.status)
            
            return cell
        default: return UITableViewCell()
            
        }
    }
        
}
