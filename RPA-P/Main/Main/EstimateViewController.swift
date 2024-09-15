//
//  EstimateViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/12/24.
//

import UIKit
import CoreLocation
import ImageSlideshow

final class EstimateViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .onDrag
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var imageSlideShow: ImageSlideshow = {
//        let pageIndicator = UIPageControl()
//        pageIndicator.currentPage = 0
//        pageIndicator.currentPageIndicatorTintColor = .useRGB(red: 184, green: 0, blue: 0)
//        pageIndicator.pageIndicatorTintColor = .useRGB(red: 224, green: 224, blue: 224)
//        pageIndicator.hidesForSinglePage = true
//        pageIndicator.numberOfPages = 4
//        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let pageIndicator = LabelPageIndicator()
        pageIndicator.textColor = .white
        pageIndicator.font = .useFont(ofSize: 14, weight: .Regular)
        
        let imageSlideShow = ImageSlideshow()
        imageSlideShow.contentScaleMode = .scaleToFill
        imageSlideShow.circular = true
        imageSlideShow.scrollView.bounces = false
        imageSlideShow.slideshowInterval = 3
//        imageSlideShow.pageIndicator = pageIndicator
//        imageSlideShow.pageIndicatorPosition = .init(vertical: .bottom)
        imageSlideShow.pageIndicator = pageIndicator
        imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 10))
        imageSlideShow.delegate = self
        imageSlideShow.translatesAutoresizingMaskIntoConstraints = false
        
        var imageResources: [ImageSource] = [
            ImageSource(image: .useCustomImage("Mureung_1")),
            ImageSource(image: .useCustomImage("Mureung_2")),
            ImageSource(image: .useCustomImage("Mureung_3")),
            ImageSource(image: .useCustomImage("Mureung_4")),
            ImageSource(image: .useCustomImage("Seorak_5")),
            ImageSource(image: .useCustomImage("Seorak_6")),
            ImageSource(image: .useCustomImage("Naejangsan_7")),
            ImageSource(image: .useCustomImage("Naejangsan_8")),
        ]
        imageSlideShow.setImageInputs(imageResources)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageSlideShow(_:)))
        imageSlideShow.addGestureRecognizer(gesture)
        
        return imageSlideShow
    }()
    
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
    
    lazy var annoucementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = .useCustomImage("announcementBGImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var kindsOfEstimateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.roundTripButton, self.oneWayButton, self.shuttleButton])
        stackView.axis = .horizontal
        stackView.spacing = 28
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var roundTripButton: UIButton = {
        let button = UIButton()
        button.setTitle("왕복", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0, alpha: 0.87), for: .selected)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(roundTripButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var oneWayButton: UIButton = {
        let button = UIButton()
        button.setTitle("편도", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0, alpha: 0.87), for: .selected)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 0.0
        button.addTarget(self, action: #selector(oneWayButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var shuttleButton: UIButton = {
        let button = UIButton()
        button.setTitle("셔틀", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0, alpha: 0.87), for: .selected)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.layer.borderWidth = 0.0
        button.addTarget(self, action: #selector(shuttleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 버튼을 눌러주세요."
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var addressTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AddressSearchTableViewCell.self, forCellReuseIdentifier: "AddressSearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.layer.borderColor = UIColor.useRGB(red: 255, green: 199, blue: 199).cgColor
        tableView.layer.borderWidth = 1.0
        tableView.layer.cornerRadius = 5.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var departureView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지를 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.borderStyle = .none
        textField.returnKeyType = .search
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var departureButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(departureButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지를 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.returnKeyType = .search
        textField.borderStyle = .none
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var arrivalButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(arrivalButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stopoverStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.addStopoverView, self.stopoverView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var addStopoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var addStopoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("addStopover")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var addStopoverLabel: UILabel = {
        let label = UILabel()
        label.text = "경유지 추가"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var addStopoverButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addStopoverButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stopoverView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stopoverLabel: UILabel = {
        let label = UILabel()
        label.text = "경유지를 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stopoverTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.returnKeyType = .search
        textField.borderStyle = .none
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var removeStopoverButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("removeStopover"), for: .normal)
        button.addTarget(self, action: #selector(removeStopoverButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stopoverButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(stopoverButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dateAndTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.departureDateAndTimeView, self.arrivalDateAndTimeView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var departureDateAndTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureDateAndTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가는 날"
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateAndTimeLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.departureDateLabel, self.departureTimeLabel])
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400 * 3), "yyyy.MM.dd")
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "06:30 오전"
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateAndTimeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(departureDateAndTimeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalDateAndTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalDateAndTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오는 날"
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400 * 3), "yyyy.MM.dd")
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "06:30 오후"
        label.textColor = .useRGB(red: 167, green: 167, blue: 167)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateAndTimeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(arrivalDateAndTimeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "인원수를 입력해주세요."
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.addLeftPadding()
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var undecidedButton: UIButton = {
        let button = UIButton()
        button.setTitle("미정", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .useRGB(red: 255, green: 160, blue: 160)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(undecidedButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var numberButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(numberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.useRGB(red: 184, green: 0, blue: 0), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.useRGB(red: 184, green: 0, blue: 0).cgColor
        button.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var estimateDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("EstimateDetailButtonImage"), for: .normal)
        button.setImage(.useCustomImage("TappedEstimateDetailButtonImage"), for: .highlighted)
        button.setImage(.useCustomImage("TappedEstimateDetailButtonImage"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(estimateDetailButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var shuttleContentView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var shuttleBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("HomeShuttleBackground")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var shuttleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("ShuttleMainImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var contentViewTopAnchorConstraint: NSLayoutConstraint!
    var departureLabelTopAnchorConstraint: NSLayoutConstraint!
    var arrivalLabelTopAnchorConstraint: NSLayoutConstraint!
    var stopoverLabelTopAnchorConstraint: NSLayoutConstraint!
    var dateAndTimeStackViewHeightAnchorConstraint: NSLayoutConstraint!
    var numberLabelTopAnchorConstraint: NSLayoutConstraint!
    var addressTableViewTopAnchorConstraint: NSLayoutConstraint!
    
    var undecidedStatus: Bool = false
    var kindsOfEstimate: KindsOfEstimate = .roundTrip
    var estimateAddresses: [String: EstimateAddress] = [
        "departure": EstimateAddress(),
        "return": EstimateAddress(),
        "stopover": EstimateAddress(),
    ]
    
    let mainModel = MainModel()
    var tourId: Int = 1
    var selectedAddressIndex: Int? {
        didSet {
            guard oldValue != self.selectedAddressIndex else {
                return
            }
            
            self.addressTableView.reloadData()
        }
    }
    
    var isEditingView: UIView!
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.addressTableView.isHidden = true
        
    }
    
    deinit {
        print("----------------------------------- EstimateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension EstimateViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applyDate(_:)), name: Notification.Name("SelectedDate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applyDate(_:)), name: Notification.Name("SelectTimeDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(initializeData(_:)), name: Notification.Name("InitializeData"), object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.scrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.contentView,
            self.imageSlideShow,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.annoucementImageView,
            self.indicatorSizeView,
            self.kindsOfEstimateStackView,
            self.departureView,
            self.arrivalView,
            self.stopoverStackView,
            self.dateAndTimeStackView,
            self.numberView,
            self.nextButton,
            self.estimateDetailButton,
            self.shuttleContentView,
            self.addressTableView,
        ], to: self.contentView)
        
        SupportingMethods.shared.addSubviews([
            self.noDataLabel,
        ], to: self.addressTableView)
        
        SupportingMethods.shared.addSubviews([
            self.departureLabel,
            self.departureTextField,
            self.departureButton,
        ], to: self.departureView)
        
        SupportingMethods.shared.addSubviews([
            self.arrivalLabel,
            self.arrivalTextField,
            self.arrivalButton,
        ], to: self.arrivalView)
        
        SupportingMethods.shared.addSubviews([
            self.addStopoverImageView,
            self.addStopoverLabel,
            self.addStopoverButton,
        ], to: self.addStopoverView)
        
        SupportingMethods.shared.addSubviews([
            self.stopoverLabel,
            self.stopoverTextField,
            self.stopoverButton,
            self.removeStopoverButton,
        ], to: self.stopoverView)
        
        SupportingMethods.shared.addSubviews([
            self.departureDateAndTimeTitleLabel,
            self.departureDateAndTimeLabelStackView,
            self.departureDateAndTimeButton,
        ], to: self.departureDateAndTimeView)
        
        SupportingMethods.shared.addSubviews([
            self.arrivalDateAndTimeTitleLabel,
            self.arrivalDateLabel,
            self.arrivalTimeLabel,
            self.arrivalDateAndTimeButton,
        ], to: self.arrivalDateAndTimeView)
        
        SupportingMethods.shared.addSubviews([
            self.numberLabel,
            self.numberTextField,
            self.numberButton,
            self.undecidedButton,
        ], to: self.numberView)
        
        SupportingMethods.shared.addSubviews([
            self.shuttleBackgroundImageView,
            self.shuttleImageView,
        ], to: self.shuttleContentView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: 1000)
        ])
        
        // imageSlideShow
        self.contentViewTopAnchorConstraint = self.imageSlideShow.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: -(self.navigationController?.navigationBar.frame.height)!)
        NSLayoutConstraint.activate([
            self.imageSlideShow.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.imageSlideShow.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.contentViewTopAnchorConstraint,
            self.imageSlideShow.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 329/360),
        ])
        
        // contentView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.imageSlideShow.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
        
        // indicatorSizeView
        NSLayoutConstraint.activate([
            self.indicatorSizeView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.indicatorSizeView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.indicatorSizeView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.indicatorSizeView.heightAnchor.constraint(equalToConstant: 27.5)
        ])
        
        // annoucementImageView
        NSLayoutConstraint.activate([
            
        ])
        
        // kindsOfEstimateStackView
        NSLayoutConstraint.activate([
            self.kindsOfEstimateStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.kindsOfEstimateStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.kindsOfEstimateStackView.topAnchor.constraint(equalTo: self.indicatorSizeView.bottomAnchor, constant: 20),
        ])
        
        // roundTripButton
        NSLayoutConstraint.activate([
            self.roundTripButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // oneWayButton
        NSLayoutConstraint.activate([
            self.oneWayButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // shuttleButton
        NSLayoutConstraint.activate([
            self.shuttleButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // departureView
        NSLayoutConstraint.activate([
            self.departureView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.departureView.topAnchor.constraint(equalTo: self.kindsOfEstimateStackView.bottomAnchor, constant: 20),
            self.departureView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.departureView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // noDataLabel
        NSLayoutConstraint.activate([
            self.noDataLabel.centerXAnchor.constraint(equalTo: self.addressTableView.centerXAnchor),
            self.noDataLabel.centerYAnchor.constraint(equalTo: self.addressTableView.centerYAnchor),
        ])
        
        // addressTableView
        self.addressTableViewTopAnchorConstraint = self.addressTableView.topAnchor.constraint(equalTo: self.departureView.bottomAnchor, constant: 4)
        NSLayoutConstraint.activate([
            self.addressTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.addressTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.addressTableViewTopAnchorConstraint,
            self.addressTableView.heightAnchor.constraint(equalToConstant: 166),
        ])
        
        // departureLabel
        self.departureLabelTopAnchorConstraint = self.departureLabel.topAnchor.constraint(equalTo: self.departureView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureView.leadingAnchor, constant: 15),
            self.departureLabelTopAnchorConstraint
        ])
        
        // departureTextField
        NSLayoutConstraint.activate([
            self.departureTextField.leadingAnchor.constraint(equalTo: self.departureView.leadingAnchor),
            self.departureTextField.trailingAnchor.constraint(equalTo: self.departureView.trailingAnchor),
            self.departureTextField.bottomAnchor.constraint(equalTo: self.departureView.bottomAnchor, constant: -5),
            self.departureTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // departureButton
        NSLayoutConstraint.activate([
            self.departureButton.leadingAnchor.constraint(equalTo: self.departureView.leadingAnchor),
            self.departureButton.trailingAnchor.constraint(equalTo: self.departureView.trailingAnchor),
            self.departureButton.bottomAnchor.constraint(equalTo: self.departureView.bottomAnchor),
            self.departureButton.topAnchor.constraint(equalTo: self.departureView.topAnchor),
        ])
        
        // arrivalView
        NSLayoutConstraint.activate([
            self.arrivalView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.arrivalView.topAnchor.constraint(equalTo: self.departureView.bottomAnchor, constant: 10),
            self.arrivalView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.arrivalView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // arrivalLabel
        self.arrivalLabelTopAnchorConstraint = self.arrivalLabel.topAnchor.constraint(equalTo: self.arrivalView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalView.leadingAnchor, constant: 15),
            self.arrivalLabelTopAnchorConstraint
        ])
        
        // arrivalTextField
        NSLayoutConstraint.activate([
            self.arrivalTextField.leadingAnchor.constraint(equalTo: self.arrivalView.leadingAnchor),
            self.arrivalTextField.trailingAnchor.constraint(equalTo: self.arrivalView.trailingAnchor),
            self.arrivalTextField.bottomAnchor.constraint(equalTo: self.arrivalView.bottomAnchor, constant: -5),
            self.arrivalTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // arrivalButton
        NSLayoutConstraint.activate([
            self.arrivalButton.leadingAnchor.constraint(equalTo: self.arrivalView.leadingAnchor),
            self.arrivalButton.trailingAnchor.constraint(equalTo: self.arrivalView.trailingAnchor),
            self.arrivalButton.bottomAnchor.constraint(equalTo: self.arrivalView.bottomAnchor),
            self.arrivalButton.topAnchor.constraint(equalTo: self.arrivalView.topAnchor),
        ])
        
        // stopoverStackView
        NSLayoutConstraint.activate([
            self.stopoverStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.stopoverStackView.topAnchor.constraint(equalTo: self.arrivalView.bottomAnchor, constant: 10),
            self.stopoverStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),

        ])
        
        // addStopoverImageView
        NSLayoutConstraint.activate([
            self.addStopoverImageView.leadingAnchor.constraint(equalTo: self.addStopoverView.leadingAnchor),
            self.addStopoverImageView.topAnchor.constraint(equalTo: self.addStopoverView.topAnchor),
            self.addStopoverImageView.bottomAnchor.constraint(equalTo: self.addStopoverView.bottomAnchor),
            self.addStopoverImageView.widthAnchor.constraint(equalToConstant: 30),
            self.addStopoverImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // addStopoverLabel
        NSLayoutConstraint.activate([
            self.addStopoverLabel.leadingAnchor.constraint(equalTo: self.addStopoverImageView.trailingAnchor, constant: 10),
            self.addStopoverLabel.centerYAnchor.constraint(equalTo: self.addStopoverImageView.centerYAnchor),
            self.addStopoverLabel.trailingAnchor.constraint(equalTo: self.addStopoverView.trailingAnchor)
        ])
        
        // addStopoverButton
        NSLayoutConstraint.activate([
            self.addStopoverButton.leadingAnchor.constraint(equalTo: self.addStopoverView.leadingAnchor),
            self.addStopoverButton.trailingAnchor.constraint(equalTo: self.addStopoverView.trailingAnchor),
            self.addStopoverButton.topAnchor.constraint(equalTo: self.addStopoverView.topAnchor),
            self.addStopoverButton.bottomAnchor.constraint(equalTo: self.addStopoverView.bottomAnchor),
        ])
        
        // stopoverView
        NSLayoutConstraint.activate([
            self.stopoverView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // stopoverLabel
        self.stopoverLabelTopAnchorConstraint = self.stopoverLabel.topAnchor.constraint(equalTo: self.stopoverView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.stopoverLabel.leadingAnchor.constraint(equalTo: self.stopoverView.leadingAnchor, constant: 15),
            self.stopoverLabelTopAnchorConstraint
        ])
        
        // stopoverTextField
        NSLayoutConstraint.activate([
            self.stopoverTextField.leadingAnchor.constraint(equalTo: self.stopoverView.leadingAnchor),
            self.stopoverTextField.trailingAnchor.constraint(equalTo: self.stopoverView.trailingAnchor),
            self.stopoverTextField.bottomAnchor.constraint(equalTo: self.stopoverView.bottomAnchor, constant: -5),
            self.stopoverTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // removeStopoverButton
        NSLayoutConstraint.activate([
            self.removeStopoverButton.trailingAnchor.constraint(equalTo: self.stopoverView.trailingAnchor, constant: -10),
            self.removeStopoverButton.centerYAnchor.constraint(equalTo: self.stopoverView.centerYAnchor),
            self.removeStopoverButton.widthAnchor.constraint(equalToConstant: 30),
            self.removeStopoverButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // stopoverButton
        NSLayoutConstraint.activate([
            self.stopoverButton.leadingAnchor.constraint(equalTo: self.stopoverView.leadingAnchor),
            self.stopoverButton.trailingAnchor.constraint(equalTo: self.stopoverView.trailingAnchor),
            self.stopoverButton.bottomAnchor.constraint(equalTo: self.stopoverView.bottomAnchor),
            self.stopoverButton.topAnchor.constraint(equalTo: self.stopoverView.topAnchor),
        ])
        
        // dateAndTimeStackView
        self.dateAndTimeStackViewHeightAnchorConstraint = self.dateAndTimeStackView.heightAnchor.constraint(equalToConstant: 78)
        NSLayoutConstraint.activate([
            self.dateAndTimeStackView.topAnchor.constraint(equalTo: self.stopoverStackView.bottomAnchor, constant: 20),
            self.dateAndTimeStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.dateAndTimeStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.dateAndTimeStackViewHeightAnchorConstraint,
        ])
        
        // departureDateAndTimeTitleLabel
        NSLayoutConstraint.activate([
            self.departureDateAndTimeTitleLabel.leadingAnchor.constraint(equalTo: self.departureDateAndTimeView.leadingAnchor, constant: 25),
            self.departureDateAndTimeTitleLabel.topAnchor.constraint(equalTo: self.departureDateAndTimeView.topAnchor, constant: 5),
        ])
        
        // departureDateAndTimeLabelStackView
        NSLayoutConstraint.activate([
            self.departureDateAndTimeLabelStackView.leadingAnchor.constraint(equalTo: self.departureDateAndTimeView.leadingAnchor, constant: 25),
            self.departureDateAndTimeLabelStackView.topAnchor.constraint(equalTo: self.departureDateAndTimeTitleLabel.bottomAnchor, constant: 1),
        ])
        
        // departureDateAndTimeButton
        NSLayoutConstraint.activate([
            self.departureDateAndTimeButton.leadingAnchor.constraint(equalTo: self.departureDateAndTimeView.leadingAnchor),
            self.departureDateAndTimeButton.trailingAnchor.constraint(equalTo: self.departureDateAndTimeView.trailingAnchor),
            self.departureDateAndTimeButton.topAnchor.constraint(equalTo: self.departureDateAndTimeView.topAnchor),
            self.departureDateAndTimeButton.bottomAnchor.constraint(equalTo: self.departureDateAndTimeView.bottomAnchor),
        ])
        
        // arrivalDateAndTimeTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalDateAndTimeTitleLabel.leadingAnchor.constraint(equalTo: self.arrivalDateAndTimeView.leadingAnchor, constant: 25),
            self.arrivalDateAndTimeTitleLabel.topAnchor.constraint(equalTo: self.arrivalDateAndTimeView.topAnchor, constant: 5),
        ])
        
        // arrivalDateLabel
        NSLayoutConstraint.activate([
            self.arrivalDateLabel.leadingAnchor.constraint(equalTo: self.arrivalDateAndTimeView.leadingAnchor, constant: 25),
            self.arrivalDateLabel.topAnchor.constraint(equalTo: self.arrivalDateAndTimeTitleLabel.bottomAnchor, constant: 1),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalDateAndTimeView.leadingAnchor, constant: 25),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalDateLabel.bottomAnchor, constant: 1),
        ])
        
        // arrivalDateAndTimeButton
        NSLayoutConstraint.activate([
            self.arrivalDateAndTimeButton.leadingAnchor.constraint(equalTo: self.arrivalDateAndTimeView.leadingAnchor),
            self.arrivalDateAndTimeButton.trailingAnchor.constraint(equalTo: self.arrivalDateAndTimeView.trailingAnchor),
            self.arrivalDateAndTimeButton.topAnchor.constraint(equalTo: self.arrivalDateAndTimeView.topAnchor),
            self.arrivalDateAndTimeButton.bottomAnchor.constraint(equalTo: self.arrivalDateAndTimeView.bottomAnchor),
        ])
        
        // numberView
        NSLayoutConstraint.activate([
            self.numberView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.numberView.topAnchor.constraint(equalTo: self.dateAndTimeStackView.bottomAnchor, constant: 10),
            self.numberView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.numberView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // numberLabel
        self.numberLabelTopAnchorConstraint = self.numberLabel.topAnchor.constraint(equalTo: self.numberView.topAnchor, constant: 13.5)
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor, constant: 15),
            self.numberLabelTopAnchorConstraint
        ])
        
        // numberTextField
        NSLayoutConstraint.activate([
            self.numberTextField.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor),
            self.numberTextField.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor),
            self.numberTextField.bottomAnchor.constraint(equalTo: self.numberView.bottomAnchor, constant: -10),
            self.numberTextField.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        // undecidedButton
        NSLayoutConstraint.activate([
            self.undecidedButton.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor, constant: -10),
            self.undecidedButton.centerYAnchor.constraint(equalTo: self.numberView.centerYAnchor),
            self.undecidedButton.widthAnchor.constraint(equalToConstant: 50),
            self.undecidedButton.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        // numberButton
        NSLayoutConstraint.activate([
            self.numberButton.leadingAnchor.constraint(equalTo: self.numberView.leadingAnchor),
            self.numberButton.trailingAnchor.constraint(equalTo: self.numberView.trailingAnchor),
            self.numberButton.bottomAnchor.constraint(equalTo: self.numberView.bottomAnchor),
            self.numberButton.topAnchor.constraint(equalTo: self.numberView.topAnchor),
        ])
        
        // nextButton
        NSLayoutConstraint.activate([
            self.nextButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.nextButton.topAnchor.constraint(equalTo: self.numberView.bottomAnchor, constant: 40),
            self.nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // estimateDetailButton
        NSLayoutConstraint.activate([
            self.estimateDetailButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.estimateDetailButton.topAnchor.constraint(equalTo: self.nextButton.bottomAnchor, constant: 13),
            self.estimateDetailButton.heightAnchor.constraint(equalToConstant: 50),
            self.estimateDetailButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        // shuttleContentView
        NSLayoutConstraint.activate([
            self.shuttleContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.shuttleContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.shuttleContentView.topAnchor.constraint(equalTo: self.kindsOfEstimateStackView.bottomAnchor, constant: 20),
            self.shuttleContentView.bottomAnchor.constraint(equalTo: self.estimateDetailButton.topAnchor, constant: -13)
        ])
        
        // shuttleBackgroundImageView
        NSLayoutConstraint.activate([
            self.shuttleBackgroundImageView.leadingAnchor.constraint(equalTo: self.shuttleContentView.leadingAnchor),
            self.shuttleBackgroundImageView.trailingAnchor.constraint(equalTo: self.shuttleContentView.trailingAnchor),
            self.shuttleBackgroundImageView.topAnchor.constraint(equalTo: self.shuttleContentView.topAnchor),
            self.shuttleBackgroundImageView.bottomAnchor.constraint(equalTo: self.shuttleContentView.bottomAnchor),
        ])
        
        // shuttleImageView
        NSLayoutConstraint.activate([
            self.shuttleImageView.centerYAnchor.constraint(equalTo: self.shuttleContentView.centerYAnchor),
            self.shuttleImageView.centerXAnchor.constraint(equalTo: self.shuttleContentView.centerXAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
        
    }
}

// MARK: - Extension for methods added
extension EstimateViewController {
    func setAddressTableView(view: UIView) {
        self.isEditingView = view
        self.mainModel.initializeModel()
        self.noDataLabel.isHidden = false
        self.selectedAddressIndex = nil
        
        self.addressTableView.reloadData()
        
        NSLayoutConstraint.deactivate([
            self.addressTableViewTopAnchorConstraint
        ])
            self.addressTableViewTopAnchorConstraint = self.addressTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 4)
        
        NSLayoutConstraint.activate([
            self.addressTableViewTopAnchorConstraint
        ])
        
//        self.addressTableView.isHidden = false
    }
    
    func initializeData() {
        // 데이터 초기화
        self.estimateAddresses["departure"] = EstimateAddress()
        self.estimateAddresses["return"] = EstimateAddress()
        self.estimateAddresses["stopover"] = EstimateAddress()
        
        // 출발지
        self.departureView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        
        self.departureLabel.font = .useFont(ofSize: 14, weight: .Regular)
        self.departureLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        self.departureLabelTopAnchorConstraint.constant = 13.5
        self.departureTextField.text = ""
        
        // 도착지
        self.arrivalView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        
        self.arrivalLabel.font = .useFont(ofSize: 14, weight: .Regular)
        self.arrivalLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        self.arrivalLabelTopAnchorConstraint.constant = 13.5
        self.arrivalTextField.text = ""
        
        // 경유지
        self.estimateAddresses["stopover"] = EstimateAddress()
        
        self.stopoverView.isHidden = true
        self.stopoverView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
        
        self.stopoverLabel.font = .useFont(ofSize: 14, weight: .Regular)
        self.stopoverLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        self.stopoverLabelTopAnchorConstraint.constant = 13.5
        self.stopoverTextField.text = ""
        
        // 인원수
        self.numberView.backgroundColor = .white
        
        self.numberTextField.text = ""
        self.numberTextField.textColor = .useRGB(red: 38, green: 38, blue: 38)
        
        self.numberTextField.isEnabled = true
        
        self.undecidedButton.setTitleColor(.white, for: .normal)
        self.undecidedButton.backgroundColor = .useRGB(red: 255, green: 160, blue: 160)
        
        self.numberLabel.font = .useFont(ofSize: 14, weight: .Regular)
        self.numberLabel.text = "인원수를 입력해주세요."
        self.numberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        self.numberLabelTopAnchorConstraint.constant = 13.5
        
        // 가는 날 & 오는 날
        self.departureDateLabel.text = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400 * 3), "yyyy.MM.dd")
        self.arrivalDateLabel.text = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400 * 4), "yyyy.MM.dd")
        
        self.departureTimeLabel.text = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400 * 3), "HH:mm a")
        self.arrivalTimeLabel.text = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400 * 4), "HH:mm a")
    }
    
    func searchDurationRequest(origin: EstimateAddress, destination: EstimateAddress, success: ((Int) -> ())?) {
        self.mainModel.searchDurationRequest(origin: origin, destination: destination) { summary in
            success?(summary.duration ?? 0)
            
        } failure: { message in
            print("error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    func loadTourDataRequest(success: (([Tour]) -> ())?) {
        self.mainModel.loadTourDataRequest { tourList in
            success?(tourList)
            
        } failure: { message in
            print("loadTourDataRequest error: \(message)")
        }

    }
    
    func getTokenRequest(success: (() -> ())?) {
        self.mainModel.getTokenRequest {
            success?()
            
        } failure: { message in
            print("error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension EstimateViewController {
    @objc func roundTripButton(_ sender: UIButton) {
        self.kindsOfEstimate = .roundTrip
        self.view.endEditing(true)
        self.addressTableView.isHidden = true
        
        self.shuttleContentView.isHidden = true
        
        self.roundTripButton.layer.borderWidth = 2.0
        self.oneWayButton.layer.borderWidth = 0.0
        self.shuttleButton.layer.borderWidth = 0.0
        
        self.arrivalDateAndTimeView.isHidden = false
        self.dateAndTimeStackViewHeightAnchorConstraint.constant = 78
        
        self.departureDateAndTimeLabelStackView.axis = .vertical
        self.departureDateAndTimeLabelStackView.spacing = 1
        
        UIView.transition(with: self.view, duration: 0.1) {
            self.view.layoutIfNeeded()
            
        }
    }
    
    @objc func oneWayButton(_ sender: UIButton) {
        self.kindsOfEstimate = .oneWay
        self.view.endEditing(true)
        self.addressTableView.isHidden = true
        
        self.shuttleContentView.isHidden = true
        
        self.roundTripButton.layer.borderWidth = 0.0
        self.oneWayButton.layer.borderWidth = 2.0
        self.shuttleButton.layer.borderWidth = 0.0
        
        self.arrivalDateAndTimeView.isHidden = true
        self.dateAndTimeStackViewHeightAnchorConstraint.constant = 48
        
        self.departureDateAndTimeLabelStackView.axis = .horizontal
        self.departureDateAndTimeLabelStackView.spacing = 10
        UIView.transition(with: self.view, duration: 0.1) {
            self.view.layoutIfNeeded()
            
        }
    }
    
    @objc func shuttleButton(_ sender: UIButton) {
        self.kindsOfEstimate = .shuttle
        self.view.endEditing(true)
        self.addressTableView.isHidden = true
        
        self.shuttleContentView.isHidden = false
        
        self.roundTripButton.layer.borderWidth = 0.0
        self.oneWayButton.layer.borderWidth = 0.0
        self.shuttleButton.layer.borderWidth = 2.0
        
    }
    
    @objc func departureButton(_ sender: UIButton) {
        self.departureTextField.becomeFirstResponder()
        
    }
    
    @objc func arrivalButton(_ sender: UIButton) {
        self.arrivalTextField.becomeFirstResponder()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
//                if self.numberTextField.isEditing {
//                    let screenSize = self.view.safeAreaLayoutGuide.layoutFrame.height
//                    let bottomHeight = screenSize - self.numberView.frame.maxY
//                    let height = keyboardSize.height - bottomHeight
//                    
//                    self.contentViewTopAnchorConstraint.constant = height > 0 ? -(height + 5) : 0
//                    
//                }
//                
                self.contentViewTopAnchorConstraint.constant = -keyboardSize.height
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.contentViewTopAnchorConstraint.constant = 0
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func addStopoverButton(_ sender: UIButton) {
        self.view.endEditing(true)
        self.stopoverView.isHidden = false
        
        UIView.transition(with: self.view, duration: 0.1) {
            self.view.layoutIfNeeded()
            
        }
    }
    
    
    @objc func stopoverButton(_ sender: UIButton) {
        self.stopoverTextField.becomeFirstResponder()
        
    }
    
    @objc func removeStopoverButton(_ sender: UIButton) {
        self.estimateAddresses["stopover"] = EstimateAddress()
        self.stopoverView.isHidden = true
        self.addressTableView.isHidden = true
        
        self.stopoverTextField.text = ""
        self.view.endEditing(true)
        
        UIView.transition(with: self.view, duration: 0.1) {
            self.stopoverView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor

            self.stopoverLabel.font = .useFont(ofSize: 14, weight: .Regular)
            self.stopoverLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)

            self.stopoverLabelTopAnchorConstraint.constant = 13.5
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    @objc func departureDateAndTimeButton(_ sender: UIButton) {
        
        let vc = RenewalCalendarViewController(kindsOfEstimate: self.kindsOfEstimate, date: (departDate: self.departureDateLabel.text!, departTime: String(self.departureTimeLabel.text!.split(separator: " ")[indice: 0]!), arrivalDate: nil, arrivalTime: nil))
        
        self.present(vc, animated: true)
//        let vc = CalendarViewController(way: .depart, preselectedDate: self.departureDateLabel.text!)
//        
//        self.present(vc, animated: true)
    }
    
    @objc func arrivalDateAndTimeButton(_ sender: UIButton) {
        
        let vc = RenewalCalendarViewController(kindsOfEstimate: self.kindsOfEstimate, date: (departDate: self.departureDateLabel.text!, departTime: String(self.departureTimeLabel.text!.split(separator: " ")[indice: 0]!), arrivalDate: self.arrivalDateLabel.text!, arrivalTime: String(self.arrivalTimeLabel.text!.split(separator: " ")[indice: 0]!)))
        
        self.present(vc, animated: true)
//        let vc = CalendarViewController(way: .arrival, preselectedDate: self.arrivalDateLabel.text!, departDate: self.departureDateLabel.text!, departTime: self.departureTimeLabel.text!)
//        
//        self.present(vc, animated: true)
    }
    
    @objc func applyDate(_ notification: Notification) {
        guard let kindsOfEstimate = notification.userInfo?["kindsOfEstimate"] as? KindsOfEstimate else { return }
        if kindsOfEstimate == .roundTrip {
            guard let departInfo = notification.userInfo?["depart"] as? (departDate: String, departTime: String) else { return }
            guard let arrivalInfo = notification.userInfo?["arrival"] as? (arrivalDate: String, arrivalTime: String) else { return }
            
            let splitDepartTime = departInfo.departTime.split(separator: ":")
            let splitArrivalTime = arrivalInfo.arrivalTime.split(separator: ":")
            
            let departForExpression = Calendar.current.date(bySettingHour: Int(splitDepartTime[0])!, minute: Int(splitDepartTime[1])!, second: 0, of: SupportingMethods.shared.convertString(intoDate: departInfo.departDate, "yyyy-MM-dd"))!
            let arrivalForExpression = Calendar.current.date(bySettingHour: Int(splitArrivalTime[0])!, minute: Int(splitArrivalTime[1])!, second: 0, of: SupportingMethods.shared.convertString(intoDate: arrivalInfo.arrivalDate, "yyyy-MM-dd"))!
            
            let depart = SupportingMethods.shared.convertDate(intoString: departForExpression, "yyyy.MM.dd HH:mm a").split(separator: " ")
            let arrival = SupportingMethods.shared.convertDate(intoString: arrivalForExpression, "yyyy.MM.dd HH:mm a").split(separator: " ")
            
            self.departureDateLabel.text = "\(depart[0])"
            self.departureTimeLabel.text = "\(depart[1]) \(depart[2])"
            self.arrivalDateLabel.text = "\(arrival[0])"
            self.arrivalTimeLabel.text = "\(arrival[1]) \(arrival[2])"
            
        } else {
            guard let departInfo = notification.userInfo?["depart"] as? (departDate: String, departTime: String) else { return }
            
            let splitDepartTime = departInfo.departTime.split(separator: ":")
            
            let departForExpression = Calendar.current.date(bySettingHour: Int(splitDepartTime[0])!, minute: Int(splitDepartTime[1])!, second: 0, of: SupportingMethods.shared.convertString(intoDate: departInfo.departDate, "yyyy-MM-dd"))!
            
            let depart = SupportingMethods.shared.convertDate(intoString: departForExpression, "yyyy.MM.dd HH:mm a").split(separator: " ")
            
            self.departureDateLabel.text = "\(depart[0])"
            self.departureTimeLabel.text = "\(depart[1]) \(depart[2])"
            
        }
        
    }
    
    @objc func numberButton(_ sender: UIButton) {
        self.numberTextField.becomeFirstResponder()
        
    }
    
    @objc func undecidedButton(_ sender: UIButton) {
        self.undecidedStatus.toggle()
        
        if self.undecidedStatus {
            UIView.transition(with: self.view, duration: 0.1) {
                self.numberView.backgroundColor = .useRGB(red: 255, green: 160, blue: 160)
                
                self.numberTextField.text = "미정"
                self.numberTextField.textColor = .white
                
                self.numberTextField.isEnabled = false
                
                self.undecidedButton.setTitleColor(.useRGB(red: 255, green: 160, blue: 160), for: .normal)
                self.undecidedButton.backgroundColor = .white
                
                self.numberLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.numberLabel.text = "인원수"
                self.numberLabel.textColor = .white
                
                self.numberLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
            
        } else {
            UIView.transition(with: self.view, duration: 0.1) {
                self.numberView.backgroundColor = .white
                
                self.numberTextField.text = ""
                self.numberTextField.textColor = .useRGB(red: 38, green: 38, blue: 38)
                
                self.numberTextField.isEnabled = true
                
                self.undecidedButton.setTitleColor(.white, for: .normal)
                self.undecidedButton.backgroundColor = .useRGB(red: 255, green: 160, blue: 160)
                
                self.numberLabel.font = .useFont(ofSize: 14, weight: .Regular)
                self.numberLabel.text = "인원수를 입력해주세요."
                self.numberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
                
                self.numberLabelTopAnchorConstraint.constant = 13.5
                
                self.view.layoutIfNeeded()
                
            }
            
        }
        
    }
    
    @objc func nextButton(_ sender: UIButton) {
        print("nextButton")
        
        var virtualPrice = 0
        let distance = Int(SupportingMethods.shared.calculateDistance(estimateAddresses: self.estimateAddresses, kindsOfEstimate: self.kindsOfEstimate) / 1000)
        
        let isPeak = SupportingMethods.shared.convertString(intoDate: self.departureDateLabel.text!, "yyyy.MM.dd").isPeak() || SupportingMethods.shared.convertString(intoDate: self.arrivalDateLabel.text!, "yyyy.MM.dd").isPeak()
        
        let isWeekday = SupportingMethods.shared.convertString(intoDate: self.departureDateLabel.text!, "yyyy.MM.dd").isWeekday() || SupportingMethods.shared.convertString(intoDate: self.arrivalDateLabel.text!, "yyyy.MM.dd").isWeekday()
        
        var priceWhenWeekday = isWeekday ? 150000 : 0
        let priceWhenPeak = isPeak ? 200000 : 0
        
        if distance != 0 {
            if self.kindsOfEstimate == .roundTrip {
                let howManyNights = SupportingMethods.shared.calculateHowManyNights(departureDate: self.departureDateLabel.text!, returnDate: self.arrivalDateLabel.text!)
                
                if howManyNights >= 6 {
                    priceWhenWeekday = 150000
                }
                
                virtualPrice = SupportingMethods.shared.caculateVirtualBasicPrice(distance: distance, kindsOfEstimate: self.kindsOfEstimate) + priceWhenPeak + priceWhenWeekday + ReferenceValues.pricePerOneNight * howManyNights
                
            } else {
                virtualPrice = SupportingMethods.shared.caculateVirtualBasicPrice(distance: distance, kindsOfEstimate: self.kindsOfEstimate) + priceWhenPeak + priceWhenWeekday
                
            }
            
            print(self.estimateAddresses)
            
            let departureDateAndTime = EstimateTime(date: self.departureDateLabel.text!, time: self.departureTimeLabel.text!)
            let returnDateAndTime = EstimateTime(date: self.arrivalDateLabel.text!, time: self.arrivalTimeLabel.text!)
            
            SupportingMethods.shared.turnCoverView(.on)
            self.searchDurationRequest(origin: self.estimateAddresses["departure"]!, destination: self.estimateAddresses["return"]!) { duration in
                print("duration: \(duration / 60)")
                
                let peopleCount = self.numberTextField.text
                var busType: BusType?
                var busCount: Int = 0
                if peopleCount == "미정" || peopleCount == "" {
                    busType = nil
                    busCount = 0
                    
                } else if Int(peopleCount!)! <= 25 {
                    busType = .twentyFive
                    busCount = 1
                    
                } else if Int(peopleCount!)! <= 33 {
                    busType = .thirtyThree
                    busCount = 1
                    
                } else if Int(peopleCount!)! <= 43 {
                    busType = .fortyThree
                    busCount = 1
                    
                } else if Int(peopleCount!)! <= 47 {
                    busType = .fortySeven
                    busCount = 1
                    
                } else {
                    busType = .fortySeven
                    if (Int(peopleCount!)! % 47) == 0 {
                        busCount = Int(peopleCount!)! / 47
                        
                    } else {
                        busCount = Int(peopleCount!)! / 47 + 1
                        
                    }
                    
                }
                
                let estimate: PreEstimate =
                PreEstimate(kindsOfEstimate: self.kindsOfEstimate, departure: self.estimateAddresses["departure"]!, return: self.estimateAddresses["return"]!, stopover: self.stopoverTextField.text == "" ? nil : self.estimateAddresses["stopover"]!, departureDate: departureDateAndTime, returnDate: returnDateAndTime, number: self.numberTextField.text == "미정" ? nil: Int(self.numberTextField.text ?? "0") ?? nil, distance: distance, duration: duration / 60, busType: busType, busCount: busCount)
                
                print("distance: \(distance)\nprice: \(SupportingMethods.shared.caculateVirtualBasicPrice(distance: distance, kindsOfEstimate: self.kindsOfEstimate))")
                print("virtualPrice: \(virtualPrice)")
                
                let vc = SelectEstimateViewController(estimate: estimate, virtualPrice: virtualPrice)

                self.navigationController?.pushViewController(vc, animated: true)
                NotificationCenter.default.post(name: Notification.Name("MoveEstimateDetail"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("MoveEstimate"), object: nil)
                SupportingMethods.shared.turnCoverView(.off)
            }
            
        } else {
            SupportingMethods.shared.showAlertNoti(title: "주소를 입력해주세요.")
            
        }
        
    }
    
    @objc func estimateDetailButton(_ sender: UIButton) {
        print("estimateDetailButton")
        NotificationCenter.default.post(name: Notification.Name("MoveEstimateDetail"), object: nil)
        
    }
    
    @objc func initializeData(_ notification: Notification) {
        self.initializeData()
        
        guard let estimate = notification.userInfo?["estimate"] as? PreEstimate else { return }
        print(estimate)
        NotificationCenter.default.post(name: Notification.Name("SaveEstimateData"), object: nil, userInfo: ["estimate": estimate])
        
    }
    
    @objc func imageSlideShow(_ gesture: UITapGestureRecognizer) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadTourDataRequest { tourList in
            let tour = tourList[self.tourId - 1]
            // FIXME: Server에서 받은 mytour로 데이터 넘겨주기
            if ReferenceValues.phoneNumber == "null" {
                let vc = TourDetailViewController(tour: tour)

                self.navigationController?.pushViewController(vc, animated: true)
                SupportingMethods.shared.turnCoverView(.off)
                
            } else {
                self.getTokenRequest {
                    self.mainModel.loadTourRequest(phone: ReferenceValues.phoneNumber) { myTourList in
                        let myTour = myTourList.filter({ Int($0.tourId)! == self.tourId }).first
                        let vc = TourDetailViewController(tour: tour, myTour: myTour)

                        self.navigationController?.pushViewController(vc, animated: true)
                        SupportingMethods.shared.turnCoverView(.off)
                        
                    } failure: { message in
                        print("loadTourRequest error: \(message)")
                        SupportingMethods.shared.turnCoverView(.off)
                        
                    }
                    
                }

            }
            
        }
        
    }
    
}

// MARK: - Extension for UITextFieldDelegate
extension EstimateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            return true
        }
        self.noDataLabel.isHidden = true
        SupportingMethods.shared.turnCoverView(.on)
        self.mainModel.initializeModel()
        
        self.mainModel.searchAddressWithText(text) {
            SupportingMethods.shared.turnCoverView(.off)
            self.addressTableView.reloadData()
            
            if self.mainModel.searchedAddress.address.isEmpty {
                SupportingMethods.shared.showAlertNoti(title: "검색된 데이터가 없습니다.")
                self.addressTableView.isHidden = true
                
            } else {
                self.addressTableView.isHidden = false
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            self.addressTableView.reloadData()
            
            if self.mainModel.searchedAddress.address.isEmpty {
                SupportingMethods.shared.showAlertNoti(title: "검색된 데이터가 없습니다.")
                self.addressTableView.isHidden = true
                
            } else {
                self.addressTableView.isHidden = false
            }
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.departureTextField {
            
            self.setAddressTableView(view: self.departureView)
            
            UIView.transition(with: self.view, duration: 0.1) {
                self.departureView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
                
                self.departureLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.departureLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)
                
                self.departureLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
            
        } else if textField == self.arrivalTextField {
            
            self.setAddressTableView(view: self.arrivalView)
            
            UIView.transition(with: self.view, duration: 0.1) {
                self.arrivalView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
//
                self.arrivalLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.arrivalLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)
//
                self.arrivalLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
            
        } else if textField == self.stopoverTextField {
            
            self.setAddressTableView(view: self.stopoverView)
            
            UIView.transition(with: self.view, duration: 0.1) {
                self.stopoverView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
                
                self.stopoverLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.stopoverLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)
                
                self.stopoverLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
        } else {
            UIView.transition(with: self.view, duration: 0.1) {
                self.numberView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
                
                self.numberLabel.font = .useFont(ofSize: 12, weight: .Regular)
                self.numberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0)
                
                self.numberLabelTopAnchorConstraint.constant = 5
                
                self.view.layoutIfNeeded()
                
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.departureTextField {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.departureView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor
                    
                    self.departureLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.departureLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)
                    
                    self.departureLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        } else if textField == self.arrivalTextField {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.arrivalView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor

                    self.arrivalLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.arrivalLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)

                    self.arrivalLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        } else if textField == self.stopoverTextField {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.stopoverView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor

                    self.stopoverLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.stopoverLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)

                    self.stopoverLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        } else {
            if textField.text == "" {
                UIView.transition(with: self.view, duration: 0.1) {
                    self.numberView.layer.borderColor = UIColor.useRGB(red: 255, green: 232, blue: 232).cgColor

                    self.numberLabel.font = .useFont(ofSize: 14, weight: .Regular)
                    self.numberLabel.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.2)

                    self.numberLabelTopAnchorConstraint.constant = 13.5
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = self.numberTextField.text else { return false }
        let length = text.count
        
        // backspace 허용
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
                
        // 글자수 제한
        if length > 3 {
            return false
        }

        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField != self.numberTextField {
            if textField.text == "" {
                self.addressTableView.isHidden = true
                
            } else {
                self.addressTableView.isHidden = false
                if self.mainModel.searchedAddress.address.isEmpty {
                    self.noDataLabel.isHidden = false
                    
                } else {
                    self.noDataLabel.isHidden = true
                    
                }
                
            }
            
        }
        
    }
}

extension EstimateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainModel.searchedAddress.address.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressSearchTableViewCell", for: indexPath) as! AddressSearchTableViewCell
        
        cell.setCell(placeName: self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음",
                     address: self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음",
                     isSelected: self.selectedAddressIndex == indexPath.row)
        
        if indexPath.row == self.mainModel.searchedAddress.address.count - 1 && !self.mainModel.searchedAddress.isAddressEnd {
            self.mainModel.searchAddressWithText(self.departureTextField.text!) {
                tableView.reloadData()
                
                if self.mainModel.searchedAddress.address.isEmpty {
                    self.addressTableView.isHidden = true
                    
                } else {
                    self.addressTableView.isHidden = false
                }
                
            } failure: { errorMessage in
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAddressIndex = indexPath.row
        
        self.view.endEditing(true)
        self.addressTableView.isHidden = true
        
        if self.isEditingView == self.departureView {
            self.estimateAddresses["departure"]?.index = 0
            self.estimateAddresses["departure"]?.name = self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            self.estimateAddresses["departure"]?.address = self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            self.estimateAddresses["departure"]?.latitude = self.mainModel.searchedAddress.address[indexPath.row].latitude
            self.estimateAddresses["departure"]?.longitude = self.mainModel.searchedAddress.address[indexPath.row].longitude
            self.estimateAddresses["departure"]?.type = "출발지"
            
            self.departureTextField.text = self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            
        } else if self.isEditingView == self.arrivalView {
            self.estimateAddresses["return"]?.index = 1
            self.estimateAddresses["return"]?.name = self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            self.estimateAddresses["return"]?.address = self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            self.estimateAddresses["return"]?.latitude = self.mainModel.searchedAddress.address[indexPath.row].latitude
            self.estimateAddresses["return"]?.longitude = self.mainModel.searchedAddress.address[indexPath.row].longitude
            self.estimateAddresses["return"]?.type = "도착지"
            
            self.arrivalTextField.text = self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            
        } else {
            self.estimateAddresses["stopover"]?.index = 2
            self.estimateAddresses["stopover"]?.name = self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            self.estimateAddresses["stopover"]?.address = self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            self.estimateAddresses["stopover"]?.latitude = self.mainModel.searchedAddress.address[indexPath.row].latitude
            self.estimateAddresses["stopover"]?.longitude = self.mainModel.searchedAddress.address[indexPath.row].longitude
            self.estimateAddresses["stopover"]?.type = "경유지"
            
            self.stopoverTextField.text = self.mainModel.searchedAddress.address[indexPath.row].placeName ?? self.mainModel.searchedAddress.address[indexPath.row].roadAddress ?? self.mainModel.searchedAddress.address[indexPath.row].jibeonAddress ?? "알 수 없음"
            
        }
        
    }
}

// MARK: - Extension for ImageSlideshowDelegate
extension EstimateViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        self.tourId = page + 1
        
    }
    
}
