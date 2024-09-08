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
    
    lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = .useCustomImage("customerServiceLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "견적을 신청해보세요!"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.register(EstimateTourTableViewCell.self, forCellReuseIdentifier: "EstimateTourTableViewCell")
        tableView.register(EstimateDetailTableViewCell.self, forCellReuseIdentifier: "EstimateDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let mainModel = MainModel()
    var estimateList: [Estimate] = []
    var tourList: [(tour: Tour, status: Bool)] = []
    var deposit: Double = 0
    
    init() {
        
//        if let estimateList = SupportingMethods.shared.readLocalEstimateData() {
//            self.estimateList = estimateList
//            
//        }
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: Notification.Name("ReloadData"), object: nil)
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
            self.emptyImageView,
            self.emptyLabel,
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
        
        // emptyImageView
        NSLayoutConstraint.activate([
            self.emptyImageView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.emptyImageView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
            self.emptyImageView.widthAnchor.constraint(equalToConstant: 50),
            self.emptyImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // emptyLabel
        NSLayoutConstraint.activate([
            self.emptyLabel.topAnchor.constraint(equalTo: self.emptyImageView.bottomAnchor, constant: 5),
            self.emptyLabel.centerXAnchor.constraint(equalTo: self.emptyImageView.centerXAnchor),
        ])
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.mainModel.getEstimateData { estimates in
            print(estimates)
            if estimates.isEmpty {
                self.emptyImageView.isHidden = false
                self.emptyLabel.isHidden = false
                
            } else {
                self.emptyImageView.isHidden = true
                self.emptyLabel.isHidden = true
                
            }
            
            self.estimateList = estimates
            
            self.loadMyTourListDataRequest {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    SupportingMethods.shared.turnCoverView(.off)
                    
                }
                
            }
            
        } failure: { error in
            print("setData Error: \(error)")
            self.emptyImageView.isHidden = false
            self.emptyLabel.isHidden = false
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension EstimateDetailViewController {
    func getTokenRequest(success: (() -> ())?) {
        self.mainModel.getTokenRequest {
            success?()
            
        } failure: { message in
            print("error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    func loadMyTourListDataRequest(success: (() -> ())?) {
        self.loadTourDataRequest { tourList in
            self.getTokenRequest {
                self.mainModel.loadTourRequest(phone: ReferenceValues.phoneNumber) { myTourList in
                    let tourIdList: [(id: Int, status: Bool)] = myTourList.map({ ($0.tourId, $0.payDatetime == "" ? false : true ) })
                    for tourId in tourIdList {
                        for tour in tourList {
                            if tour.id == tourId.id {
                                self.tourList.append((tour: tour, status: tourId.status))
                                break
                                
                            }
                            
                        }
                        
                    }
                    
                    success?()
                    
                } failure: { message in
                    print("loadMyTourListDataRequest error: \(message)")
                    self.tableView.reloadData()
                    SupportingMethods.shared.turnCoverView(.off)
                    
                }
                
            }
            
        }
        
    }
    
    func loadTourDataRequest(success: (([Tour]) -> ())?) {
        self.mainModel.loadTourDataRequest { tourList in
            success?(tourList)
            
        } failure: { message in
            print("loadTourDataRequest error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        

    }
    
    func sendConfirmReservationRequest(estimateId: String, success: (() -> ())?) {
        self.mainModel.sendConfirmReservationRequest(estimateId: estimateId) {
            success?()
            
        } failure: { message in
            print("error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    func getContractRequest(estimateId: String, success: ((String) -> ())?) {
        self.mainModel.getContractRequest(estimateUid: estimateId) { html in
            success?(html)
            
        } failure: { message in
            print("error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for selector methods
extension EstimateDetailViewController {
    @objc func reloadData(_ notification: Notification) {
        self.setData()
        
    }
    
    @objc func reservationConfirmButton(_ notification: Notification) {
        guard let estimate = notification.userInfo?["estimate"] as? Estimate else { return }
        
        if estimate.isEstimateApproval {
            if estimate.isCompletedReservation {
                // 계약서 보기
                print("계약서 보기")
                SupportingMethods.shared.turnCoverView(.on)
                self.getTokenRequest {
                    self.getContractRequest(estimateId: estimate.documentId) { html in
                        let vc = ContractViewController(html: html)
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        SupportingMethods.shared.turnCoverView(.off)
                    }
                    
                }
                
            } else {
                if !estimate.isConfirmedReservation {
                    // 예약 확정하기
                    SupportingMethods.shared.turnCoverView(.on)
                    self.getTokenRequest {
                        self.sendConfirmReservationRequest(estimateId: estimate.documentId) {
                            self.deposit = Double(estimate.price)! * 0.08
                            let vc = EstimateConfirmationViewController()
                            
                            self.present(vc, animated: true) {
                                SupportingMethods.shared.turnCoverView(.off)
                                
                            }
                            
                        }
                        
                    }
                    
                } else {
                    SupportingMethods.shared.showAlertNoti(title: "계약금을 입금하시면 운행 확정 및 계약서를 확인하실 수 있습니다.")
                    
                }
                
                
            }
            
        }
        
        
    }
    
    @objc func reload(_ notification: Notification) {
        self.tableView.reloadData()
        
    }
    
    @objc func estimateConfirm(_ notificatoin: Notification) {
        print("estimateConfirm")
        let vc = ReservationAnnouncementViewController(deposit: self.deposit)
        
        self.present(vc, animated: true)
    }
    
    @objc func saveEstimateData(_ notification: Notification) {
         guard let data = notification.userInfo?["estimate"] as? PreEstimate else { return }
        
//        self.estimateList.append(data)
//        SupportingMethods.shared.saveLocalEstimateData(estimateList: self.estimateList)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource {
extension EstimateDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
            
        } else {
            return self.estimateList.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EstimateTourTableViewCell", for: indexPath) as! EstimateTourTableViewCell
            
            cell.setCell(tourList: self.tourList)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EstimateDetailTableViewCell", for: indexPath) as! EstimateDetailTableViewCell
            let estimate = self.estimateList[indexPath.row]
            
            cell.setCell(estimate: estimate)
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
