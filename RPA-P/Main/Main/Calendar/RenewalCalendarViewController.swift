//
//  RenewalCalendarViewController.swift
//  RPA-P
//
//  Created by Awesomepia on 8/29/24.
//

import UIKit
import FSCalendar

enum SelectDateWay {
    case depart
    case arrival
}

final class RenewalCalendarViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "가는 날짜 선택"
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.allowsMultipleSelection = self.current == .depart ? false : true
        calendar.register(SelectDatesCustomCalendarCell.self, forCellReuseIdentifier: SelectDatesCustomCalendarCell.description())
        calendar.today = nil
        
        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.weekdayFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleWeekendColor = .useRGB(red: 176, green: 0, blue: 32)
        
        calendar.appearance.headerTitleFont = .useFont(ofSize: 16, weight: .Bold)
        calendar.headerHeight = 45
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerTitleColor = .useRGB(red: 66, green: 66, blue: 66)
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.isHidden = true
        picker.backgroundColor = .white
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Regular)
        button.layer.borderColor = UIColor.useRGB(red: 203, green: 203, blue: 203).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(cancelButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Regular)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(checkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var firstDate: Date?    // 배열 중 첫번째 날짜
    private var lastDate: Date?        // 배열 중 마지막 날짜
    private var datesRange: [Date] = []    // 선택된 날짜 배열
    
    var departDate: String = ""
    var departTime: String = ""
    var arrivalDate: String = ""
    var arrivalTime: String = ""
    
    var current: SelectDateWay = .depart
    var kindsOfEstimate: KindsOfEstimate = .roundTrip
    
    init(kindsOfEstimate: KindsOfEstimate, date: (departDate: String, departTime: String, arrivalDate: String?, arrivalTime: String?)) {
        self.kindsOfEstimate = kindsOfEstimate
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        
        
        if let arrivalDate = date.arrivalDate {
            self.current = .arrival
            self.titleLabel.text = "오는 날짜 선택"
            
            let arrivalTime = date.arrivalTime!.split(separator: ":")
            self.datePicker.date = Calendar.current.date(bySettingHour: Int(arrivalTime[0])!, minute: Int(arrivalTime[1])!, second: 0, of: SupportingMethods.shared.convertString(intoDate: arrivalDate, "yyyy.MM.dd"))!
            
            self.firstDate = SupportingMethods.shared.convertString(intoDate: date.departDate, "yyyy.MM.dd")
            self.departDate = SupportingMethods.shared.convertDate(intoString: self.firstDate!, "yyyy-MM-dd")
            self.departTime = date.departTime
            self.datesRange = [self.firstDate!]
            self.calendar.reloadData()
            
            var range: [Date] = []
            
            var currentDate = self.firstDate!
            while currentDate <= SupportingMethods.shared.convertString(intoDate: arrivalDate, "yyyy.MM.dd") {
                range.append(currentDate)
                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            }
            
            for day in range {
                self.calendar.select(day)
            }
                
            self.lastDate = range.last
            self.datesRange = range
                
            self.calendar.reloadData()
            
        } else {
            self.calendar.select(SupportingMethods.shared.convertString(intoDate: date.departDate, "yyyy.MM.dd"))
            let time = date.departTime.split(separator: ":")
            self.datePicker.date = Calendar.current.date(bySettingHour: Int(time[0])!, minute: Int(time[1])!, second: 0, of: SupportingMethods.shared.convertString(intoDate: date.departDate, "yyyy.MM.dd"))!
            
        }
        
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
        print("----------------------------------- RenewalCalendarViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalCalendarViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
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
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.calendar,
            self.datePicker,
            self.cancelButton,
            self.checkButton,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.baseView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: 500),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        // calendar
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.calendar.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.calendar.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.calendar.bottomAnchor.constraint(equalTo: self.cancelButton.topAnchor, constant: -30),
        ])
        
        // datePicker
        NSLayoutConstraint.activate([
            self.datePicker.leadingAnchor.constraint(equalTo: self.calendar.leadingAnchor),
            self.datePicker.trailingAnchor.constraint(equalTo: self.calendar.trailingAnchor),
            self.datePicker.topAnchor.constraint(equalTo: self.calendar.topAnchor),
            self.datePicker.bottomAnchor.constraint(equalTo: self.calendar.bottomAnchor),
        ])
        
        // cancelButton
        NSLayoutConstraint.activate([
            self.cancelButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 13),
            self.cancelButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -14),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor, constant: 12),
            self.checkButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -13),
            self.checkButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -14),
            self.checkButton.heightAnchor.constraint(equalToConstant: 48),
            self.checkButton.widthAnchor.constraint(equalTo: self.cancelButton.widthAnchor, multiplier: 1.0),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension RenewalCalendarViewController {
    
}

// MARK: - Extension for selector methods
extension RenewalCalendarViewController {
    @objc func checkButton(_ sender: UIButton) {
        if self.current == .depart {
            if self.departDate == "" {
                // 출발 날짜 선택 완료
                guard let selectedDate = self.calendar.selectedDate else {
                    SupportingMethods.shared.showAlertNoti(title: "가는 날짜를 선택해주세요.")
                    return
                }
                
                if self.firstDate == nil {
                    self.firstDate = selectedDate
                    self.datesRange = [self.firstDate!]
                    
                    self.calendar.reloadData()
                }
                
                self.datePicker.isHidden = false
                self.calendar.isHidden = true
                
                self.departDate = SupportingMethods.shared.convertDate(intoString: self.firstDate!, "yyyy-MM-dd")
                print("selected first date: \(SupportingMethods.shared.convertDate(intoString: self.firstDate!, "yyyy-MM-dd"))")
                
            } else {
                // 출발 시간 선택 완료
                let time = self.datePicker.date
                self.departTime = SupportingMethods.shared.convertDate(intoString: time, "HH:mm")
                
                if self.kindsOfEstimate == .roundTrip {
                    // 왕복일 경우
                    self.datePicker.isHidden = true
                    self.calendar.isHidden = false
                    self.calendar.allowsMultipleSelection = true
                    self.current = .arrival
                    self.calendar.reloadData()
                    self.titleLabel.text = "오는 날짜 선택"
                    
                } else {
                    // 편도일 경우
                    self.dismiss(animated: true) {
                        NotificationCenter.default.post(name: Notification.Name("SelectTimeDone"), object: nil, userInfo: ["depart": (departDate: self.departDate, departTime: self.departTime), "kindsOfEstimate": self.kindsOfEstimate])
                        
                    }
                    
                }
                
            }
            
        } else {
            if self.arrivalDate == "" {
                // 오는 날짜 선택 완료
//                guard let lastDate = self.lastDate else {
//                    SupportingMethods.shared.showAlertNoti(title: "오는 날짜를 선택해주세요.")
//                    return
//                }
                
                if self.lastDate == nil {
                    self.lastDate = self.firstDate
                    
                }
                
                
                let time = self.departTime.split(separator: ":")
                if self.firstDate == self.lastDate {
                    self.datePicker.minimumDate = Calendar.current.date(bySettingHour: Int(time[0])!, minute: Int(time[1])!, second: 0, of: self.lastDate!)
                    
                } else {
                    self.datePicker.minimumDate = nil
                    
                }
                
                self.datePicker.isHidden = false
                self.calendar.isHidden = true
                
                self.arrivalDate = SupportingMethods.shared.convertDate(intoString: self.lastDate!, "yyyy-MM-dd")
                print("selected last date: \(SupportingMethods.shared.convertDate(intoString: self.lastDate!, "yyyy-MM-dd"))")
                
            } else {
                // 오는 시간 선택 완료
                let time = self.datePicker.date
                self.arrivalTime = SupportingMethods.shared.convertDate(intoString: time, "HH:mm")
                
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: Notification.Name("SelectTimeDone"), object: nil, userInfo: ["depart": (departDate: self.departDate, departTime: self.departTime), "arrival": (arrivalDate: self.arrivalDate, arrivalTime: self.arrivalTime), "kindsOfEstimate": self.kindsOfEstimate])
                    
                }
                
            }
            
        }
        
    }
    
    @objc func cancelButton(_ sender: UIButton) {
        if self.current == .depart {
            if self.departDate == "" {
                // 가는 날짜 선택 화면에서 취소버튼 누름
                self.dismiss(animated: true)
                
            } else {
                // 가는 시간 선택 화면에서 취소버튼 누름
                self.departDate = ""
                self.firstDate = nil
                self.datesRange = []
                
                self.datePicker.isHidden = true
                self.calendar.isHidden = false
            }
            
        } else {
            if self.arrivalDate == "" {
                // 오는 날짜 선택 화면에서 취소버튼 누름
                self.current = .depart
                self.titleLabel.text = "가는 날짜 선택"
                
                let time = self.departTime.split(separator: ":")
                self.datePicker.date = Calendar.current.date(bySettingHour: Int(time[0])!, minute: Int(time[1])!, second: 0, of: self.firstDate!)!
                self.datePicker.isHidden = false
                self.calendar.isHidden = true
                
                self.calendar.allowsMultipleSelection = false
                self.lastDate = nil
                for day in self.datesRange {
                    self.calendar.deselect(day)
                    
                }
                self.datesRange = [self.firstDate!]
                self.calendar.select(self.firstDate)
                
                self.calendar.reloadData()
                
            } else {
                // 오는 시간 선택 화면에서 취소버튼 누름
                self.arrivalDate = ""
                
                self.datePicker.isHidden = true
                self.calendar.isHidden = false
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for FSCalendarDataSource
extension RenewalCalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        if let selectedDate = calendar.selectedDate {
            if self.firstDate == nil {
                self.firstDate = selectedDate
                self.datesRange = [firstDate!]
                    
                self.calendar.reloadData() // (매번 reload)
                
            }
            
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if SupportingMethods.shared.determineIfEqualToOrLaterThanTargetDate(self.current == .depart ? Date(timeIntervalSinceNow: 86400 * 3) : SupportingMethods.shared.convertString(intoDate: self.departDate, "yyyy-MM-dd"), forOneDate: date) {
            if date == self.firstDate {
                return .white
            } else {
                return .black
            }
            
        } else {
            return .useRGB(red: 188, green: 188, blue: 188)
            
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        if SupportingMethods.shared.determineIfEqualToOrLaterThanTargetDate(self.current == .depart ? Date(timeIntervalSinceNow: 86400 * 3) : SupportingMethods.shared.convertString(intoDate: self.departDate, "yyyy-MM-dd"), forOneDate: date) {
            return .white
            
        } else {
            return .useRGB(red: 188, green: 188, blue: 188)
            
        }
        
    }
    
    // 매개변수로 들어온 date의 타입을 반환한다
    func typeOfDate(_ date: Date) -> SelectedDateType {
        
        let arr = self.datesRange
        
        if !arr.contains(date) {
            if self.calendar.selectedDate == date {
                return .singleDate
                
            } else {
                return .notSelectd    // 배열이 비어있으면 무조건 notSelected
                
            }
            
        } else {
            // 배열의 count가 1이고, firstDate라면 singleDate
            if arr.count == 1 && date == self.firstDate { return .singleDate }
            
            // 배열의 count가 2 이상일 때, 각각 타입 반환
            if date == self.firstDate { return .firstDate }
            if date == self.lastDate { return .lastDate }
            
            else { return .middleDate }
        }
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        guard let cell = calendar.dequeueReusableCell(withIdentifier: SelectDatesCustomCalendarCell.description(), for: date, at: position) as? SelectDatesCustomCalendarCell else { return FSCalendarCell() }

        // 현재 그리는 셀의 date의 타입에 기반해서 셀 디자인
        cell.updateBackImage(self.typeOfDate(date))

        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if SupportingMethods.shared.determineIfEqualToOrLaterThanTargetDate(self.current == .depart ? Date(timeIntervalSinceNow: 86400 * 3) : SupportingMethods.shared.convertString(intoDate: self.departDate, "yyyy-MM-dd"), forOneDate: date) {
            // case 1. 현재 아무것도 선택되지 않은 경우
            // 선택 date -> firstDate 설정
            if self.firstDate == nil {
                self.firstDate = date
                self.datesRange = [firstDate!]
                    
                self.calendar.reloadData() // (매번 reload)
                return
            }
                
            // case 2. 현재 firstDate 하나만 선택된 경우
            if self.firstDate != nil && self.lastDate == nil {
                // case 2 - 1. firstDate 이전 날짜 선택 -> firstDate 변경
                if date < self.firstDate! {
                    calendar.deselect(self.firstDate!)
                    self.firstDate = date
                    self.datesRange = [self.firstDate!]
                        
                    self.calendar.reloadData()    // (매번 reload)
                    return
                }
                    
                // case 2 - 2. firstDate 이후 날짜 선택 -> 범위 선택
                else {
                    var range: [Date] = []
                    
                    var currentDate = self.firstDate!
                    while currentDate <= date {
                        range.append(currentDate)
                        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                    }
                    
                    for day in range {
                        calendar.select(day)
                    }
                        
                    self.lastDate = range.last
                    self.datesRange = range
                        
                    self.calendar.reloadData()    // (매번 reload)
                    return
                }
            }
            
            // case 3. 두 개가 모두 선택되어 있는 상태 -> 현재 선택된 날짜 모두 해제 후 선택 날짜를 firstDate로 설정
            if self.firstDate != nil && self.lastDate != nil {

                for day in calendar.selectedDates {
                    calendar.deselect(day)
                }
                
                self.lastDate = nil
                
                calendar.select(self.firstDate)
                self.datesRange = [self.firstDate!]
                    
                self.calendar.reloadData()    // (매번 reload)
                return
            }
            
        } else {
            SupportingMethods.shared.showAlertNoti(title: "해당 날짜는 선택할 수 없습니다.")
            if self.current == .depart {
                // 가는 날짜 선택중
                self.calendar.deselect(date)
                
            } else {
                // 오는 날짜 선택중
                self.calendar.deselect(date)
                self.calendar.select(self.firstDate)
                
            }
            
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("didDeselect")
        let arr = self.datesRange
        if !arr.isEmpty {
            for day in arr {
                calendar.deselect(day)
            }
        }
        
        if self.departDate != "" {
            self.firstDate = SupportingMethods.shared.convertString(intoDate: self.departDate, "yyyy-MM-dd")
            self.lastDate = nil
            calendar.select(self.firstDate)
            self.datesRange = [self.firstDate!]
            if self.current == .arrival {
                self.lastDate = self.firstDate
                
            } else {
                
                
            }
            
            
        } else {
            self.firstDate = nil
            self.lastDate = nil
            self.datesRange = []
            
        }
        
        
        self.calendar.reloadData()    // (매번 reload)
    }
    
}
