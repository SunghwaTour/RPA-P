//
//  CalendarViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/18/24.
//

import UIKit
import FSCalendar

enum SelectDateWay {
    case depart
    case `return`
}

final class CalendarViewController: UIViewController {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch self.way {
        case .depart:
            label.text = "가는 날짜 선택"
        case .return:
            label.text = "오는 날짜 선택"
        }
        
        return label
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.layer.cornerRadius = 25
        calendar.backgroundColor = .white
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.appearance.titleFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.weekdayFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.headerTitleFont = .useFont(ofSize: 16, weight: .Bold)
        calendar.appearance.selectionColor = .useRGB(red: 184, green: 0, blue: 0)
        
        calendar.allowsMultipleSelection = false
        
        // 오늘 날짜 관련 설정
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .black
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar.appearance.headerTitleColor = .useRGB(red: 66, green: 66, blue: 66)
        
        // 주말 색깔 설정
        calendar.appearance.titleWeekendColor = .useRGB(red: 176, green: 0, blue: 32)
        
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .center
        
        // 헤더 높이 설정
        calendar.headerHeight = 45

        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.isHidden = true
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
//        picker.date = SupportingMethods.shared.convertString(intoDate: self.date, "yyyy-MM-dd HH:mm")
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    lazy var doneBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 153, green: 153, blue: 153)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.useRGB(red: 0, green: 0, blue: 0, alpha: 0.87), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Regular)
        button.addTarget(self, action: #selector(cancelButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var centerBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 153, green: 153, blue: 153)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Medium)
        button.addTarget(self, action: #selector(checkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(way: SelectDateWay, preselectedDate: String, departDate: String? = nil) {
        self.way = way
        self.preselectedDate = SupportingMethods.shared.convertString(intoDate: preselectedDate, "yyyy.MM.dd")
        
        if let departDate = departDate {
            self.departDate = SupportingMethods.shared.convertString(intoDate: departDate, "yyyy.MM.dd")
            
        }
        
        super.init(nibName: nil, bundle: nil)
        self.calendar.select(SupportingMethods.shared.convertString(intoDate: preselectedDate, "yyyy.MM.dd"))
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var way: SelectDateWay = .depart
    var selectedDate: Date = Date(timeIntervalSinceNow: 86400 * 3)
    var preselectedDate: Date
    var departDate: Date?
    
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
        print("----------------------------------- CalendarViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CalendarViewController: EssentialViewMethods {
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
            self.backgroundView,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.calendar,
            self.datePicker,
            self.doneBaseView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.borderView,
            self.cancelButton,
            self.centerBorderView,
            self.checkButton,
        ], to: self.doneBaseView)
    }
    
    func setLayouts() {
//        let safeArea = self.view.safeAreaLayoutGuide
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 17),
            self.baseView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -17),
            self.baseView.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 93),
            self.baseView.heightAnchor.constraint(equalToConstant: 480),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 24),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        // calendar
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 27),
            self.calendar.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -27),
            self.calendar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.calendar.bottomAnchor.constraint(equalTo: self.doneBaseView.bottomAnchor, constant: -48),
        ])
        
        // datePicker
        NSLayoutConstraint.activate([
            self.datePicker.leadingAnchor.constraint(equalTo: self.calendar.leadingAnchor),
            self.datePicker.trailingAnchor.constraint(equalTo: self.calendar.trailingAnchor),
            self.datePicker.topAnchor.constraint(equalTo: self.calendar.topAnchor),
            self.datePicker.bottomAnchor.constraint(equalTo: self.calendar.bottomAnchor),
        ])
        
        // doneBaseView
        NSLayoutConstraint.activate([
            self.doneBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.doneBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.doneBaseView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.doneBaseView.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        // borderView
        NSLayoutConstraint.activate([
            self.borderView.leadingAnchor.constraint(equalTo: self.doneBaseView.leadingAnchor),
            self.borderView.trailingAnchor.constraint(equalTo: self.doneBaseView.trailingAnchor),
            self.borderView.topAnchor.constraint(equalTo: self.doneBaseView.topAnchor),
            self.borderView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        // cancelButton
        NSLayoutConstraint.activate([
            self.cancelButton.leadingAnchor.constraint(equalTo: self.doneBaseView.leadingAnchor),
            self.cancelButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width / 2 ) - 18),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // centerBorderView
        NSLayoutConstraint.activate([
            self.centerBorderView.trailingAnchor.constraint(equalTo: self.checkButton.leadingAnchor),
            self.centerBorderView.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor),
            self.centerBorderView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor),
            self.centerBorderView.bottomAnchor.constraint(equalTo: self.doneBaseView.bottomAnchor),
            self.centerBorderView.widthAnchor.constraint(equalToConstant: 2),
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.leadingAnchor.constraint(equalTo: self.centerBorderView.trailingAnchor),
            self.checkButton.trailingAnchor.constraint(equalTo: self.doneBaseView.trailingAnchor),
            self.checkButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width / 2 ) - 18),
            self.checkButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension CalendarViewController {
    
}

// MARK: - Extension for selector methods
extension CalendarViewController {
    @objc func cancelButton(_ sender: UIButton) {
        
        if self.datePicker.isHidden == false {
            self.calendar.isHidden = false
            self.datePicker.isHidden = true
            
            switch self.way {
            case .depart:
                self.titleLabel.text = "가는 날짜 선택"
                
            case .return:
                self.titleLabel.text = "오는 날짜 선택"
                
            }
            
        } else {
            self.dismiss(animated: true)
            
        }
        
    }
    
    @objc func checkButton(_ sender: UIButton) {
        switch self.way {
        case .depart:
            self.titleLabel.text = "가는 날짜 탑승 시간"
            
        case .return:
            self.titleLabel.text = "오는 날짜 탑승 시간"
            
        }
        
        if self.datePicker.isHidden == false {
            self.dismiss(animated: true) {
                let time = SupportingMethods.shared.convertDate(intoString: self.datePicker.date, "hh:mm a")
                let date = SupportingMethods.shared.convertDate(intoString: self.selectedDate, "yyyy.MM.dd")
                
                print("Selected Date: \(date)")
                print("Selected Time: \(time)")
                print("Way: \(self.way)")
                print("isPeak: \(self.selectedDate.isPeak())")
                print("isWeekday: \(self.selectedDate.isWeekday())")
                
                NotificationCenter.default.post(name: Notification.Name("SelectedDate"), object: nil, userInfo: ["date": date, "time": time, "way": self.way])
            }
        }
        
        self.calendar.isHidden = true
        self.datePicker.isHidden = false
        
    }
}

// MARK: - Extension for FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UIScrollViewDelegate {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentMonth = SupportingMethods.shared.convertDate(intoString: calendar.currentPage, "yyyy-MM")
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if SupportingMethods.shared.determineIfEqualToOrLaterThanTargetDate(self.way == .depart ? Date(timeIntervalSinceNow: 86400 * 3) : self.departDate!, forOneDate: date) {
            return .black
            
        } else {
            return .useRGB(red: 188, green: 188, blue: 188)
            
        }
        
    }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let currentMonth = SupportingMethods.shared.convertDate(intoString: calendar.currentPage, "MM")
//        let selectedMonth = SupportingMethods.shared.convertDate(intoString: date, "MM")
//        if selectedMonth < currentMonth {
//            calendar.select(date, scrollToDate: true)
//            calendar.select(self.preselectedDate)
//            
//        }
        
        if SupportingMethods.shared.determineIfEqualToOrLaterThanTargetDate(self.way == .depart ? Date(timeIntervalSinceNow: 86400 * 3) : self.departDate!, forOneDate: date) {
            self.selectedDate = date
            
        } else {
            SupportingMethods.shared.showAlertNoti(title: "해당 날짜는 선택할 수 없습니다.")
            self.calendar.select(self.preselectedDate)
            self.calendar.reloadData()
            
        }
        
    }
    
}
