//
//  SupportingMethods.swift
//  RPA-P
//
//  Created by 이주성 on 7/10/24.
//

import UIKit
import PhotosUI
import Alamofire
import AppTrackingTransparency
import AdSupport

enum PickerType {
    case image
    case video
}

enum CoverViewState {
    case on
    case off
}

enum ReceivedContentType {
    case feed
    case place
    case path
    case live
}

enum PushContentType: Int { // FIXME: temp
    case newChat = 1
    //case newFeed = 2
    case newFollower = 3
    //case placeComment = 4
    case placeRecomment = 5
    //case pathComment = 6
    case pathRecomment = 7
    case feedLike = 8
    case feedComment = 9
    case feedRecomment = 10
    case announcement = 11
    case checkup = 12
    case event = 13
    //case inviteInGame = 14
    //case joined = 15
    //case reported = 16
    //case completeQuest = 17
    case title = 18
    //case avatarPedometerReward = 19
    //case commerceRecomment = 20
    case missionCompleted = 21
}

struct PushContent: Codable {
    let commentNo: Int
    let contentsKindsNo: Int
    let contentsNo: Int
    let uuid: String
}

enum ProfileSticker: Int {
    case snowman = 1
    case sock = 2
    case bell = 3
    case ring = 4
    case tree = 5
    
    var stickerImageName: String {
        switch self {
        case .snowman:
            return "profileSticker1"
            
        case .sock:
            return "profileSticker2"
            
        case .bell:
            return "profileSticker3"
            
        case .ring:
            return "profileSticker4"
            
        case .tree:
            return "profileSticker5"
        }
    }
}

enum Languages: String {
    case korean = "korean"
    case english = "english"
    
    var code: String {
        switch self {
        case .korean:
            return "ko"
            
        case .english:
            return "en"
            
        }
    }
}

enum PricePerKM: Int {
    case lessThan400 = 3460
    case moreThan400 = 2590
}

enum WaitingTimePrice: Int {
    case lessThan200 = 150000
    case lessThan300 = 90000
    case lessThan400 = 30000
}

class SupportingMethods {
    
    private lazy var coverView: UIView = {
        // Cover View
        let coverView = UIView()
        coverView.backgroundColor = UIColor.useRGB(red: 0, green: 0, blue: 0, alpha: 0.1)
        coverView.isHidden = true
        coverView.translatesAutoresizingMaskIntoConstraints = false
        
        // Activity Indicator View
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        coverView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            // Activity Indicator
            activityIndicator.centerYAnchor.constraint(equalTo: coverView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: coverView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
        
        return coverView
    }()
    
    static let shared = SupportingMethods()
    
    // MARK: Add Subviews
    func addSubviews(_ views: [UIView], to: UIView) {
        for view in views {
            to.addSubview(view)
        }
    }
    
    // MARK: Cover view
    func turnCoverView(_ state: CoverViewState) {
        ReferenceValues.keyWindow.bringSubviewToFront(self.coverView)
        
        switch state {
        case .on:
            self.coverView.isHidden = false
            
        case .off:
            self.coverView.isHidden = true
        }
    }
    
    // MARK: Get Top ViewController
    func getTopVC(_ windowRootVC: UIViewController?) -> UIViewController? {
        var topVC = windowRootVC
        while true {
            if let top = topVC?.presentedViewController {
                topVC = top
                
            } else if let base = topVC as? UINavigationController, let top = base.visibleViewController {
                topVC = top
                
            } else if let base = topVC as? UITabBarController, let top = base.selectedViewController {
                topVC = top
                
            } else {
                break
            }
        }
        
        return topVC
    }
    
    private(set) var receivedContent: (contentType: ReceivedContentType, contentNumber: Int)?
    private(set) var savedPush: (type: PushContentType, content: PushContent)?
    
    private var notiAnimator: UIViewPropertyAnimator?
    private var notiViewBottomAnchor: NSLayoutConstraint!
    private var notiTitleLabelTrailingAnchor: NSLayoutConstraint!
    private var notiButtonAction: (() -> ())?
    private(set) var versionCheckRequest: DataRequest?
    
    private lazy var notiBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var notiView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.useSketchShadow(color: .black, alpha: 0.15, x: 0, y: 4, blur: 8, spread: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var notiImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "notiImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var notiTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Noti Title"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var notiButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.useRGB(red: 131, green: 164, blue: 245), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.addTarget(self, action: #selector(notiButton(_:)), for: .touchUpInside)
        button.setTitle("Button Title", for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private init() {
        self.initializeAlertNoti()
        self.initializeCoverView()
    }
}

// MARK: - Extension for methods added
extension SupportingMethods {
    // MARK: Initial views
    // alert noti view
    func initializeAlertNoti() {
        let window: UIWindow! = ReferenceValues.keyWindow
        
        self.addSubviews([
            self.notiBaseView
        ], to: window)
        
        self.addSubviews([
            self.notiView
        ], to: self.notiBaseView)
        
        self.addSubviews([
            self.notiImageView,
            self.notiTitleLabel,
            self.notiButton
        ], to: self.notiView)
        
        // notiBaseView
        NSLayoutConstraint.activate([
            self.notiBaseView.topAnchor.constraint(equalTo: window.topAnchor),
            self.notiBaseView.heightAnchor.constraint(equalToConstant: 150),
            self.notiBaseView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            self.notiBaseView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
        ])
        
        // notiView
        self.notiViewBottomAnchor = self.notiView.bottomAnchor.constraint(equalTo: self.notiBaseView.topAnchor)
        NSLayoutConstraint.activate([
            self.notiViewBottomAnchor,
            self.notiView.heightAnchor.constraint(greaterThanOrEqualToConstant: 56),
            self.notiView.leadingAnchor.constraint(equalTo: self.notiBaseView.leadingAnchor, constant: 16),
            self.notiView.trailingAnchor.constraint(equalTo: self.notiBaseView.trailingAnchor, constant: -16)
        ])
        
        // notiImageView
        NSLayoutConstraint.activate([
            self.notiImageView.centerYAnchor.constraint(equalTo: self.notiView.centerYAnchor),
            self.notiImageView.heightAnchor.constraint(equalToConstant: 24),
            self.notiImageView.leadingAnchor.constraint(equalTo: self.notiView.leadingAnchor, constant: 16),
            self.notiImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        // notiTitleLabel
        self.notiTitleLabelTrailingAnchor = self.notiTitleLabel.trailingAnchor.constraint(equalTo: self.notiView.trailingAnchor, constant: -16)
        NSLayoutConstraint.activate([
            self.notiTitleLabel.topAnchor.constraint(equalTo: self.notiView.topAnchor, constant: 18.5),
            self.notiTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 19),
            self.notiTitleLabel.bottomAnchor.constraint(equalTo: self.notiView.bottomAnchor, constant: -18.5),
            self.notiTitleLabel.leadingAnchor.constraint(equalTo: self.notiImageView.trailingAnchor, constant: 8),
            self.notiTitleLabelTrailingAnchor
        ])
        
        // notiButton
        NSLayoutConstraint.activate([
            self.notiButton.centerYAnchor.constraint(equalTo: self.notiView.centerYAnchor),
            self.notiButton.trailingAnchor.constraint(equalTo: self.notiView.trailingAnchor, constant: -16),
        ])
    }
    
    // cover view
    func initializeCoverView() {
        let window: UIWindow! = ReferenceValues.keyWindow
        
        self.addSubviews([
            self.coverView
        ], to: window)
        
        // coverView
        NSLayoutConstraint.activate([
            self.coverView.topAnchor.constraint(equalTo: window.topAnchor),
            self.coverView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            self.coverView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            self.coverView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
        ])
    }
    
    // MARK: Show alert noti
    func showAlertNoti(title: String, button: (title: String, notiButtonAction:(() -> ())?)? = nil) {
        ReferenceValues.keyWindow.bringSubviewToFront(self.notiBaseView)
        
        // Set noti label and button
        self.notiTitleLabel.text = title
        self.notiButton.setTitle(button?.title, for: .normal)
        if let notiButtonAction = button?.notiButtonAction {
            self.notiButtonAction = notiButtonAction
            self.notiButton.isHidden = false
            
            NSLayoutConstraint.deactivate([
                self.notiTitleLabelTrailingAnchor
            ])
            self.notiTitleLabelTrailingAnchor = self.notiTitleLabel.trailingAnchor.constraint(equalTo: self.notiButton.leadingAnchor, constant: -4)
            NSLayoutConstraint.activate([
                self.notiTitleLabelTrailingAnchor
            ])
            
        } else {
            self.notiButtonAction = nil
            self.notiButton.isHidden = true
            
            NSLayoutConstraint.deactivate([
                self.notiTitleLabelTrailingAnchor
            ])
            self.notiTitleLabelTrailingAnchor = self.notiTitleLabel.trailingAnchor.constraint(equalTo: self.notiView.trailingAnchor, constant: -16)
            NSLayoutConstraint.activate([
                self.notiTitleLabelTrailingAnchor
            ])
        }
        self.notiBaseView.layoutIfNeeded()
        
        // Animating
        self.notiAnimator?.stopAnimation(false)
        self.notiAnimator?.finishAnimation(at: .end)
        
        if self.notiAnimator == nil || self.notiAnimator?.state == .inactive {
            self.notiBaseView.isHidden = false
            
            self.notiAnimator = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.6, animations: {
                self.notiViewBottomAnchor.constant = ReferenceValues.Size.SafeAreaInsets.top + 8 + self.notiView.frame.height
                self.notiBaseView.layoutIfNeeded()
            })
            
            self.notiAnimator?.addCompletion({ position in
                switch position {
                case .end:
                    //print("position end")
                    self.hideNotiAlert()
                    
                default:
                    break
                }
            })
            
            self.notiAnimator?.startAnimation()
        }
    }
    
    private func hideNotiAlert() {
        //print("close")
        self.notiAnimator = UIViewPropertyAnimator(duration: 0.15, curve: .easeIn, animations: {
            self.notiViewBottomAnchor.constant = 0
            self.notiBaseView.layoutIfNeeded()
        })
        self.notiAnimator?.addCompletion({ position in
            switch position {
            case .end:
                //print("second position end")
                self.notiBaseView.isHidden = true
                
            default:
                break
            }
        })
        self.notiAnimator?.startAnimation(afterDelay: 3.0)
    }
    
    @objc private func notiButton(_ sender: UIButton) {
        if let action = self.notiButtonAction {
            action()
            
            self.notiButtonAction = nil
        }
    }
    
    // MARK: Compare to App Store version
    func compareAppVersionToAppStore(completion: ((_ needToUpdate: Bool) -> ())?) {
        guard let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String else {
            print("App Version Check >> impossible to get bundle id")
            
            completion?(false)
            
            return
        }
        
        let url = "https://itunes.apple.com/kr/lookup"
        
        let parameters: Parameters = [
            "bundleId":bundleId
        ]
        
        self.versionCheckRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        self.versionCheckRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data), let json = jsonObject as? [String: Any], let results = json["results"] as? [[String: Any]], let firstResult = results.first, let appStoreVersion = firstResult["version"] as? String else {
                    print("App Version Check >> impossible to get store version")
                    
                    completion?(false)
                    
                    return
                }
                
                guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
                    print("App Version Check >> impossible to get app version")
                    
                    completion?(false)
                    
                    return
                }
                
                let appStoreVersionArray = appStoreVersion.components(separatedBy: ".")
                let appVersionArray = appVersion.components(separatedBy: ".")
                
                guard appStoreVersionArray.count == 3 && appVersionArray.count == 3 else {
                    print("App Version Check >> improper version type")
                    
                    completion?(false)
                    
                    return
                }
                
                if let firstStoreVersionNumber = Int(appStoreVersionArray[0]),
                   let secondStoreVersionNumber = Int(appStoreVersionArray[1]),
                   let thirdStoreVersionNumber = Int(appStoreVersionArray[2]),
                   let firstAppVersionNumber = Int(appVersionArray[0]),
                   let secondAppVersionNumber = Int(appVersionArray[1]),
                   let thirdAppVersionNumber = Int(appVersionArray[2]) {
                    
                    let storeVersionValue = firstStoreVersionNumber * 100_000_000 + secondStoreVersionNumber * 100_000 + thirdStoreVersionNumber * 100
                    let appVersionValue = firstAppVersionNumber * 100_000_000 + secondAppVersionNumber * 100_000 + thirdAppVersionNumber * 100
                    
                    print("Store Version Int Value::::::::::: \(storeVersionValue)")
                    print("App Version Int Value::::::::::: \(appVersionValue)")
                    
                    if storeVersionValue > appVersionValue {
                        print("App Version Check >> store version is higher")
                        completion?(true) // Need to be updated
                        
                    } else {
                        print("App Version Check >> app version is same as store version (or higher which must not happen)")
                        completion?(false) // No need to be updated
                    }
                    
                } else {
                    print("App Version Check >> impossible to cast to Integer type with version")
                    completion?(false)
                }
                
            case .failure(let error):
                print("App Version Check >> error: \(error.localizedDescription)")
                completion?(false)
            }
        }
    }
    
    // MARK: Distance And Virtual Price
    func calculateDistance(departure: EstimateAddress, `return`: EstimateAddress, kindsOfEstimate: KindsOfEstimate) -> CLLocationDistance {
        let departure = CLLocationCoordinate2D(latitude: Double(departure.latitude)!, longitude: Double(departure.longitude)!)
        let `return` = CLLocationCoordinate2D(latitude: Double(`return`.latitude)!, longitude: Double(`return`.longitude)!)
        
//        let stopover: CLLocationCoordinate2D? = estimateAddresses["stopover"]?.name != "" ? CLLocationCoordinate2D(latitude: Double(estimateAddresses["stopover"]!.latitude)!, longitude: Double(estimateAddresses["stopover"]!.longitude)!) : nil
        
        return kindsOfEstimate == .roundTrip ? departure.distance(from: `return`) * 2 : departure.distance(from: `return`)
        
    }
    
    func calculateDistance(estimateAddresses: [String: EstimateAddress], kindsOfEstimate: KindsOfEstimate) -> CLLocationDistance {
        guard let latitude = Double(estimateAddresses["departure"]!.latitude) else { return 0 }
        guard let longitude = Double(estimateAddresses["departure"]!.longitude) else { return 0 }
        
        let departure = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let `return` = CLLocationCoordinate2D(latitude: Double(estimateAddresses["return"]!.latitude)!, longitude: Double(estimateAddresses["return"]!.longitude)!)
        
//        let stopover: CLLocationCoordinate2D? = estimateAddresses["stopover"]?.name != "" ? CLLocationCoordinate2D(latitude: Double(estimateAddresses["stopover"]!.latitude)!, longitude: Double(estimateAddresses["stopover"]!.longitude)!) : nil
        
        return kindsOfEstimate == .roundTrip ? departure.distance(from: `return`) * 2 : departure.distance(from: `return`)
        
    }
    
    // FIXME: 가견적 계산
    func caculateVirtualBasicPrice(distance: Int, kindsOfEstimate: KindsOfEstimate) -> Int {
        let pricePerKM: PricePerKM = distance < 400 ? .lessThan400 : .moreThan400
        var waitingTimePrice: Int {
            get {
                switch distance {
                case 0..<200:
                    return WaitingTimePrice.lessThan200.rawValue
                case 200..<300:
                    return WaitingTimePrice.lessThan300.rawValue
                case 300..<400:
                    return WaitingTimePrice.lessThan400.rawValue
                default:
                    return 0
                }
            }
        }
        
        var totalPrice: Int = ReferenceValues.basicPrice + waitingTimePrice
        
        if distance <= 100 {
            totalPrice = 500000 + waitingTimePrice
            
        } else if distance <= 200 {
            totalPrice = ReferenceValues.basicPrice + waitingTimePrice
            
        } else {
            totalPrice += distance < 400 ?
            (distance - 200) * pricePerKM.rawValue :
            200 * PricePerKM.lessThan400.rawValue + (distance - 400) * pricePerKM.rawValue
            
        }
//        if distance > 200 {
//            totalPrice += distance < 400 ?
//            (distance - 200) * pricePerKM.rawValue :
//            200 * PricePerKM.lessThan400.rawValue + (distance - 400) * pricePerKM.rawValue
//            
//        }
        
        return Int(Double(totalPrice) * (distance < 400 ? kindsOfEstimate.discountRate : 1.0))
    }
    
    func calculateHowManyNights(departureDate: String, returnDate: String) -> Int {
        let departure = SupportingMethods.shared.convertString(intoDate: departureDate, "yyyy.MM.dd")
        let `return` = SupportingMethods.shared.convertString(intoDate: returnDate, "yyyy.MM.dd")
        
        return Calendar.current.dateComponents([.day], from: departure, to: `return`).day!
    }
    
    // MARK: Text
    func makeAttributedString(_ strings: [NSAttributedString]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        for string in strings {
            attributedString.append(string)
        }
        
        return attributedString
    }
    
    func makeAttributedString(_ string: String, color: UIColor, font: UIFont, urlString: String? = nil, ofTextAlign alignment: NSTextAlignment, lineHeight: CGFloat? = nil) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        
        if let urlString = urlString, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            let attributedString = NSAttributedString(string: string, attributes: [
                .font:font,
                .foregroundColor:color,
                .paragraphStyle:paragraphStyle,
                .link:url
            ])
            
            return attributedString
            
        } else {
            let attributedString = NSAttributedString(string: string, attributes: [
                .font:font,
                .foregroundColor:color,
                .paragraphStyle:paragraphStyle
            ])
            
            return attributedString
        }
    }
    
    // MARK: Gredient layer
    func makeGradientLayer(colors: [UIColor], bounds: CGRect, locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint) -> CALayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        
        return gradientLayer
    }
    
    // MARK: Time & Date
    func makeDateFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") //Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")!
        dateFormatter.dateFormat = format
        
        return dateFormatter
    }
    
    func calculatePassedTime(_ targetDate: Date?) -> String? {
        guard let targetDate = targetDate else {
            return nil
        }
        
        let now: Int = Int(Date().timeIntervalSince1970)
        let target = Int(targetDate.timeIntervalSince1970)
        let seconds = now - target // time interval between now and target time
        
        if seconds < 3600 { // 1시간 미만
            let minutes = seconds / 60
            if minutes <= 0 {
                return "방금전"
                
            } else {
                return "\(minutes)분 전"
            }
            
        } else if seconds >= 3600 && seconds < 3600 * 24 { // 1시간 이상 1일(24시간) 미만
            let hours = seconds / 3600
            return "\(hours)시간 전"
            
        } else if seconds >= 3600 * 24 && seconds < 3600 * 24 * 7 { // 1일 이상 1주일(7일) 미만
            let days = seconds / (3600 * 24)
            return "\(days)일 전"
            
        } else { // 1주일(7일) 이상
            let dateFormatter = self.makeDateFormatter("yy.MM.dd")
            return dateFormatter.string(from: targetDate)
        }
        
    }
    
    func makeTimeIntervalOfBeginningOfDate(_ date: Date, timeZone: TimeZone = TimeZone(abbreviation: "KST")!, locale: Locale = Locale(identifier: "ko_KR")) -> Int {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timeZone

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let guideDate = calendar.date(from: DateComponents(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!, hour: 0, minute: 0, second: 0))
        
        return Int(guideDate!.timeIntervalSince1970)
    }
    
    func checkIfSameFirstDay(_ firstDate: Date, asSecondDay secondDate: Date, timeZone: TimeZone = TimeZone(abbreviation: "KST")!, locale: Locale = Locale(identifier: "ko_KR")) -> Bool {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timeZone
        
        let firstDateComponents = calendar.dateComponents([.year, .month, .day], from: firstDate)
        let secondDateComponents = calendar.dateComponents([.year, .month, .day], from: secondDate)
        
        let firstGuideDate = calendar.date(from: DateComponents(year: firstDateComponents.year!, month: firstDateComponents.month!, day: firstDateComponents.day!, hour: 0, minute: 0, second: 0))
        let secondGuideDate = calendar.date(from: DateComponents(year: secondDateComponents.year!, month: secondDateComponents.month!, day: secondDateComponents.day!, hour: 0, minute: 0, second: 0))
        
        return firstGuideDate == secondGuideDate
    }
    
    func determineOddDay(_ date: Date, timeZone: TimeZone = TimeZone(abbreviation: "KST")!, locale: Locale = Locale(identifier: "ko_KR")) -> Bool {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timeZone
        
        let dateComponents = calendar.dateComponents([.day], from: date)
        let day = dateComponents.day!
        
        return day % 2 > 0
    }
    
    func isLaterThanTargetDate(_ date: Date = Date(), targetDate: Date, timeZone: TimeZone = TimeZone(abbreviation: "KST")!, locale: Locale = Locale(identifier: "ko_KR")) -> Bool {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timeZone
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let targetDateComponents = calendar.dateComponents([.year, .month, .day], from: targetDate)
        
        let date = calendar.date(from: DateComponents(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!, hour: 0, minute: 0, second: 0))!
        let targetDate = calendar.date(from: DateComponents(year: targetDateComponents.year!, month: targetDateComponents.month!, day: targetDateComponents.day!, hour: 0, minute: 0, second: 0))!
        
        return date > targetDate
    }
    
    func determineIfEqualToOrLaterThanTargetDate(_ targetDate: Date, forOneDate date: Date = Date(), timeZone: TimeZone = TimeZone(abbreviation: "KST")!, locale: Locale = Locale(identifier: "ko_KR")) -> Bool {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timeZone
        
        let targetDateComponents = calendar.dateComponents([.year, .month, .day], from: targetDate)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let targetDate = calendar.date(from: DateComponents(year: targetDateComponents.year!, month: targetDateComponents.month!, day: targetDateComponents.day!, hour: 0, minute: 0, second: 0))!
        let date = calendar.date(from: DateComponents(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!, hour: 0, minute: 0, second: 0))!
        
        return date >= targetDate
    }
    
    func convertDateWithString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")!
        formatter.dateFormat = "yyyy_MM_dd"
        let date = formatter.date(from: dateString)
        
        return date
    }
    
    // Date -> String
    func convertDate(intoString date: Date, _ dateFormat: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: date)
    }
    
    // String -> Date
    func convertString(intoDate date: String, _ dateFormat: String = "yyyy_MM_dd") -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: date) ?? Date()
        
        return date
    }
    
    func selectedDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: dateString)!
        
        return date
    }
    
    func testForMakingTempDate(string: String) -> Date? {
        return self.makeDateFormatter("yyyy.MM.dd HH:mm:ss").date(from: string)
    }
    
    func determineDefaultTheme(_ default: @escaping () -> (), inWinter winter: (() -> ())? = nil, inSummer summer: (() -> ())? = nil, forDate date: Date = Date(), timeZone: TimeZone = TimeZone(abbreviation: "KST")!, locale: Locale = Locale(identifier: "ko_KR")) {
        
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timeZone
        
        let dateComponents = calendar.dateComponents([.month], from: date)
        
        guard let month = dateComponents.month else {
            `default`()
            
            return
        }
        
        switch month {
        case 12, 1:
            (winter ?? `default`)()
            
        case 7, 8:
            (summer ?? `default`)()
            
        default:
            `default`()
        }
    }
    
    // MARK: About map or location
    func calculateMetersToKiloMeters(_ meters: Int) -> String {
        let kiloMeters = meters / 1000
        let restMeters = meters % 1000
        
        if kiloMeters > 0 {
            if restMeters == 0 {
                return "\(kiloMeters)km"
                
            } else if restMeters > 0 && restMeters < 100 {
                return "\(kiloMeters).0km"
                
            } else { // restMeters >= 100
                let pointKiloMeters = restMeters / 100
                return "\(kiloMeters).\(pointKiloMeters)km"
            }
            
        } else {
            return "\(meters)m"
        }
    }
    
//    func makeAddress(_ place: TravelPlaceItem) -> (address: String, latitude: String, longitude: String)? {
//        let address = ""
//        + (place.tripPlaceAdd1 != "" ? " \(place.tripPlaceAdd1)" : "")
//        + (place.tripPlaceAdd2 != "" ? " \(place.tripPlaceAdd2)" : "")
//        + (place.tripPlaceAdd3 != "" ? " \(place.tripPlaceAdd3)" : "")
//
//        if address == "" || place.tripPlaceLatitude == "" || place.tripPlaceLongitude == "" {
//            return nil
//
//        } else {
//            return (address, place.tripPlaceLatitude, place.tripPlaceLongitude)
//        }
//    }
    
    // MARK: About constraint
    func makeConstraintsOf(_ firstView: UIView, sameAs secondView: UIView) {
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: secondView.topAnchor),
            firstView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor),
            firstView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor)
        ])
    }
    
    func makeConstraintsOf(_ firstView: UIView, sameAs secondViewLayout: UILayoutGuide) {
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: secondViewLayout.topAnchor),
            firstView.bottomAnchor.constraint(equalTo: secondViewLayout.bottomAnchor),
            firstView.leadingAnchor.constraint(equalTo: secondViewLayout.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: secondViewLayout.trailingAnchor)
        ])
    }
    
    // MARK: Determine app state
    enum AppState {
        case terminate
        case logout
        case networkError
        case serverError
        case expired
    }
    
    // FIXME: 추후 사용이 필요할 때 고쳐야 함.
//    func determineAppState(_ state: AppState) {
//        switch state {
//        case .terminate:
//            exit(0)
//            
//        case .logout:
//            guard let _ = ReferenceValues.firstVC?.presentedViewController as? CustomizedTabBarController else {
//                ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//                
//                return
//            }
//            
//            ReferenceValues.firstVC?.dismiss(animated: true)
//            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//            
//        case .networkError:
//            guard let _ = ReferenceValues.firstVC?.presentedViewController as? CustomizedTabBarController else {
//                ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//                
//                return
//            }
//            
//            ReferenceValues.firstVC?.dismiss(animated: false)
//            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//            
//        case .serverError:
//            guard let _ = ReferenceValues.firstVC?.presentedViewController as? CustomizedTabBarController else {
//                ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//                
//                return
//            }
//            
//            ReferenceValues.firstVC?.dismiss(animated: false)
//            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//            
//        case .expired:
//            guard let _ = ReferenceValues.firstVC?.presentedViewController as? CustomizedTabBarController else {
//                ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//                
//                return
//            }
//            
//            ReferenceValues.firstVC?.dismiss(animated: false)
//            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
//        }
//    }
//    
//    func checkExpiration(errorMessage: String, completion: (() -> ())?) {
//        completion?()
//        
//        if errorMessage == ReferenceValues.expiredConditionMessage {
//            let vc = AlertPopViewController(.normalOneButton(messageTitle: "로그아웃 되었습니다", messageContent: "다른 기기에서 중복 로그인되어\n현재 기기에서 자동 로그아웃 되었습니다.", buttonTitle: "확인", action: {
//                self.determineAppState(.expired)
//            }))
//            
//            if let topVC = SupportingMethods.shared.getTopVC(ReferenceValues.keyWindow.rootViewController) {
//                if let presentingVC = topVC.presentingViewController, let _ = topVC as? AlertPopViewController {
//                    presentingVC.dismiss(animated: false) {
//                        presentingVC.present(vc, animated: true)
//                    }
//                    
//                } else {
//                    topVC.present(vc, animated: true)
//                }
//            }
//            
//        } else {
//            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "서비스 접속이 원활하지 않습니다", messageContent: "잠시 후 다시 시도해 주세요.", leftButtonTitle: "앱 종료", leftAction: {
//                exit(0)
//                
//            }, rightButtonTitle: "재접속", rightAction: {
//                self.determineAppState(.serverError)
//            }))
//            
//            if let topVC = SupportingMethods.shared.getTopVC(ReferenceValues.keyWindow.rootViewController) {
//                if let presentingVC = topVC.presentingViewController, let _ = topVC as? AlertPopViewController {
//                    presentingVC.dismiss(animated: false) {
//                        presentingVC.present(vc, animated: true)
//                    }
//                    
//                } else {
//                    topVC.present(vc, animated: true)
//                }
//            }
//        }
//        
//        self.turnCoverView(.off)
//    }
    
    // MARK: Map
    // Google
    func showGoogleMap(lat: Double, lng: Double) {
        guard let url = URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=transit") else { return }
        
        // googlemap 앱스토어 url
        //guard let appStoreUrl = URL(string: "https://apps.apple.com/kr/app/google-maps/id585027354") else { return }
        let urlString = "comgooglemaps://"
        
        // googlemap 앱이 있다면,
        if let appUrl = URL(string: urlString) {
            // googlemap 앱이 존재한다면,
            if UIApplication.shared.canOpenURL(appUrl) {
                // 길찾기 open
                UIApplication.shared.open(url)
            } else { // googlemap 앱이 없다면,
                // googlemap 앱 설치 앱스토어로 이동
                UIApplication.shared.open(URL(string: "https://www.google.com/maps?saddr=&daddr=\(lat),\(lng)&directionsmode=transit")!)
            }
        }
    }
    
    // Kakao
    func showKakaoMap(lat: Double, lng: Double) {
        // 도착지 좌표 + 자동차 길찾기
        guard let url = URL(string: "kakaomap://route?ep=\(lat),\(lng)&by=CAR") else { return }
        // 카카오맵 앱스토어 url
        guard let appStoreUrl = URL(string: "itms-apps://itunes.apple.com/app/id304608425") else { return }
        let urlString = "kakaomap://open"

        if let appUrl = URL(string: urlString) {
            // 카카오맵 앱이 존재한다면,
            if UIApplication.shared.canOpenURL(appUrl) {
                // 길찾기 open
                UIApplication.shared.open(url)
            } else { // 카카오맵 앱이 없다면,
                // 카카오맵 앱 설치 앱스토어로 이동
                UIApplication.shared.open(appStoreUrl)
            }
        }
    }
    
    // Tmap
    func showTMap(locationName: String, lat: Double, lng: Double) {
        // 도착지 이름 + 도착지 좌표
        let urlStr = "tmap://route?rGoName=\(locationName)&rGoX=\(lng)&rGoY=\(lat)"
        
        // url에 한글이 들어가있기 때문에 인코딩을 따로 해줘야함
        guard let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedStr) else { return }
        
        // tmap 앱스토어 url
        guard let appStoreURL = URL(string: "http://itunes.apple.com/app/id431589174") else { return }

        // tmap 앱이 있다면,
        if UIApplication.shared.canOpenURL(url) {
            // 길찾기 open
            UIApplication.shared.open(url)
        } else { // tmap 앱이 없다면,
            // tmap 설치 앱스토어로 이동
            UIApplication.shared.open(appStoreURL)
        }
    }
    
    // Apple
    func showAppleMap(latitude: Double, longitude: Double) {
        // 주소 + 자동차 길찾기
        //let urlStr = "maps://?daddr=\(endPoint)&dirfgl=d"
        let urlStr = "maps://?daddr=\(latitude),\(longitude)"
        
        // 한글 인코딩
        guard let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedStr) else { return }
        
        // 애플지도 앱스토어 url
        guard let appStoreUrl = URL(string: "itms-apps://itunes.apple.com/app/id915056765") else { return }

        // 애플지도 앱이 있다면,
        if UIApplication.shared.canOpenURL(url) {
            // 애플 길찾기 open
            UIApplication.shared.open(url)
        } else { // 애플 지도 앱이 없다면,
            // 애플지도 설치 앱스토어로 이동
            UIApplication.shared.open(appStoreUrl)
        }
    }
    
    // MARK: Storyboard
    func makeViewControllerFromStoryBoard(_ storyboardId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId)
    }
    
    // MARK: Manage contents (photo / movie)
    func gatherDataFromPickedContents(index: Int, pickerType: PickerType, pickedResults: [String:PHPickerResult], selectedIdentifiers: [String], contentsMetaData: [String:PHAsset], contentsData: [String:Data], success: ((_ pickedResults: [String:PHPickerResult], _ selectedIdentifiers: [String], _ contentsData: [String:Data], _ contentMetaData: [String:PHAsset]) -> ())?, failure: (() -> ())?) {
        var index = index
        let count = selectedIdentifiers.count
        var contentsData = contentsData
        
        guard index < count else {
            DispatchQueue.main.async {
                success?(pickedResults, selectedIdentifiers, contentsData, contentsMetaData)
            }
            
            return
        }
        
        if pickerType == .image {
            if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let self = self, let image = image as? UIImage, let imageData = image.fixedOrientaion.jpegData(compressionQuality: 0.1) {
                        DispatchQueue.main.async {
                            contentsData.updateValue(imageData, forKey: selectedIdentifiers[index])
                            
                            index += 1
                            self.gatherDataFromPickedContents(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, itemProvider.hasItemConformingToTypeIdentifier(UTType.webP.identifier) {
                itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.webP.identifier) { data, error in
                    if let data = data, let _ = UIImage(data: data) {
                        DispatchQueue.main.async {
                            contentsData.updateValue(data, forKey: selectedIdentifiers[index])
                            
                            index += 1
                            self.gatherDataFromPickedContents(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    failure?()
                }
            }
            
        } else { // video
            if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, let videoAsset = contentsMetaData[selectedIdentifiers[index]], itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { [weak self] url, err in
                    if let self = self, let url = url {
                        var preset = AVAssetExportPresetPassthrough//AVAssetExportPresetHEVC1920x1080
                        
                        if videoAsset.pixelHeight > 1920 || videoAsset.pixelWidth > 1080 {
                            preset = AVAssetExportPresetHEVC1920x1080
                        }
                        
                        self.convertVideo(sourceUrl: url, preset: preset) { videoData in
                            DispatchQueue.main.async {
                                contentsData.updateValue(videoData, forKey: selectedIdentifiers[index])
                                if let thumbnailData = videoAsset.thumbnailImage.fixedOrientaion.jpegData(compressionQuality: 1.0) {
                                    contentsData.updateValue(thumbnailData, forKey: "thumbnailData")
                                }
                                
                                index += 1
                                self.gatherDataFromPickedContents(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                            }
                            
                        } failure: {
                            DispatchQueue.main.async {
                                failure?()
                            }
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    failure?()
                }
            }
        }
    }
    
    // MARK: Manage contents (photo / movie)
    func gatherDataFromPickedContentsForFeedWrite(index: Int, pickerType: PickerType, pickedResults: [String:PHPickerResult], selectedIdentifiers: [String], contentsMetaData: [String:PHAsset], contentsData: [String:Data], url: URL? = nil, success: ((_ pickedResults: [String:PHPickerResult], _ selectedIdentifiers: [String], _ contentsData: [String:Data], _ contentMetaData: [String:PHAsset], _ url: URL?) -> ())?, failure: (() -> ())?) {
        var index = index
        let count = selectedIdentifiers.count
        var contentsData = contentsData
        var url = url
        
        guard index < count else {
            DispatchQueue.main.async {
                if pickerType == .image {
                    success?(pickedResults, selectedIdentifiers, contentsData, contentsMetaData, nil)
                    
                } else {
                    success?(pickedResults, selectedIdentifiers, contentsData, contentsMetaData, url)
                    
                }
                
            }
            
            return
        }
        
        if pickerType == .image {
            if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let self = self, let image = image as? UIImage, let imageData = image.fixedOrientaion.jpegData(compressionQuality: 0.1) {
                        DispatchQueue.main.async {
                            contentsData.updateValue(imageData, forKey: selectedIdentifiers[index])
                            
                            index += 1
                            self.gatherDataFromPickedContentsForFeedWrite(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, itemProvider.hasItemConformingToTypeIdentifier(UTType.webP.identifier) {
                itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.webP.identifier) { data, error in
                    if let data = data, let _ = UIImage(data: data) {
                        DispatchQueue.main.async {
                            contentsData.updateValue(data, forKey: selectedIdentifiers[index])
                            
                            index += 1
                            self.gatherDataFromPickedContentsForFeedWrite(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    failure?()
                }
            }
            
        } else { // video
            if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, let videoAsset = contentsMetaData[selectedIdentifiers[index]], itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { [weak self] url, err in
                    if let self = self, let url = url {
                        var preset = AVAssetExportPresetPassthrough//AVAssetExportPresetHEVC1920x1080
                        
                        if videoAsset.pixelHeight > 1920 || videoAsset.pixelWidth > 1080 {
                            preset = AVAssetExportPresetHEVC1920x1080
                        }
                        
                        self.convertVideo(sourceUrl: url, preset: preset) { videoData in
                            DispatchQueue.main.async {
                                contentsData.updateValue(videoData, forKey: selectedIdentifiers[index])
                                if let thumbnailData = videoAsset.thumbnailImage.fixedOrientaion.jpegData(compressionQuality: 1.0) {
                                    contentsData.updateValue(thumbnailData, forKey: "thumbnailData")
                                }
                                
                                index += 1
                                self.gatherDataFromPickedContentsForFeedWrite(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, url: url, success: success, failure: failure)
                            }
                            
                        } failure: {
                            DispatchQueue.main.async {
                                failure?()
                            }
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    failure?()
                }
            }
        }
    }
    
    // MARK: Convert Video
    // AVAssetExportPresetHEVC1920x1080,
    func convertVideo(sourceUrl: URL, preset: String = AVAssetExportPresetPassthrough, success: ((_ videoData: Data) -> ())?, failure: (() -> ())?) {
        guard let videoData = try? Data(contentsOf: sourceUrl, options: Data.ReadingOptions.alwaysMapped) else {
            print("Video data of source url is nil")
            failure?()
            
            return
        }
        print("Original Video: \(videoData)")
        
        let originalVideoDataUrl = NSURL.fileURL(withPath: NSTemporaryDirectory() + UUID().uuidString + ".mp4")
        guard (try? videoData.write(to: originalVideoDataUrl, options: [])) != nil else {
            print("Writing video data of source url on disc is failed")
            failure?()
            
            return
        }
        
        let convertedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + UUID().uuidString + ".mp4")
        self.convertVideo(inputURL: originalVideoDataUrl, outputURL: convertedURL, preset: preset) { exportSession in
            guard let session = exportSession else {
                print("exportSession.status: nil")
                failure?()
                
                return
            }
            
            switch session.status {
            case .unknown:
                print("exportSession.status: unknown")
                failure?()
                
            case .waiting:
                print("exportSession.status: waiting")
                failure?()
                
            case .exporting:
                print("exportSession.status: exporting")
                failure?()
                
            case .completed:
                guard let convertedData = try? Data(contentsOf: convertedURL) else {
                    print("Video data of converted url is nil")
                    failure?()
                    
                    return
                }
                
                print("exportSession.status: completed")
                print("Converted Video: \(convertedData)")
                
                success?(convertedData)
                
            case .failed:
                print("exportSession.status: failed")
                failure?()
                
            case .cancelled:
                print("exportSession.status: cancelled")
                failure?()
                
            default:
                print("exportSession.status: default")
                failure?()
            }
        }
    }
    
    private func convertVideo(inputURL: URL,
                       outputURL: URL,
                       preset: String,
                      handler:@escaping (_ exportSession: AVAssetExportSession?) -> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset,
                                                       presetName: preset) else {
            handler(nil)

            return
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.exportAsynchronously {
            handler(exportSession)
        }
    }
    
    // MARK: Utility
    func printJsonFromData(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
            print("\n::::::::::::::::::::::::::::::::: JSON :::::::::::::::::::::::::::::::::")
            print(json)
            print("::::::::::::::::::::::::::::::::: JSON :::::::::::::::::::::::::::::::::\n")
            
        } else {
            print("::::::: JSON 출력(print) 실패 :::::::")
        }
    }
    
    // MARK: Localization
    func changeLanguage(_ language: Languages) {
        UserDefaults.standard.set([language.code], forKey: "AppleLanguages")
        
    }
    
    func getText(_ key: String) -> String {
        let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String
        let languageCode = String(language.split(separator: "-")[0])
        
        print("language: \(languageCode)")
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")!
        let bundle = Bundle(path: path)
        
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? ""
    }
    
    // MARK: Permission
    func requestAppTrackingPermission(completionHandler: @escaping () -> ()) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                    completionHandler()
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                    completionHandler()
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                    completionHandler()
                case .restricted:
                    print("Restricted")
                    completionHandler()
                @unknown default:
                    print("Unknown")
                    completionHandler()
                }
            }
        }
    }
    
    func requestNotificationPermission(completionHandler: @escaping () -> ()){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                print("Push: 권한 허용")
                completionHandler()
            } else {
                print("Push: 권한 거부")
                completionHandler()
            }
        })
    }

    func checkAlbumPermission(completionHandler: @escaping (String) -> Void){
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status{
            case .limited:
                completionHandler("일부 허용")
                print("Album: 일부 허용")
            case .authorized:
                completionHandler("허용")
                print("Album: 권한 허용")
            case .denied:
                completionHandler("거부")
                print("Album: 권한 거부")
            case .restricted, .notDetermined:
                completionHandler("선택하지 않음")
                print("Album: 선택하지 않음")
            default:
                completionHandler("default")
            }
        }
    }
    
    // MARK: UserDefualts Estimate 저장 및 불러오기
    func saveLocalEstimateData(estimateList: [PreEstimate]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(estimateList){
            UserDefaults.standard.setValue(encoded, forKey: "estimateList")
        }
        
    }
    
    func readLocalEstimateData() -> [PreEstimate]? {
        if let savedData = UserDefaults.standard.object(forKey: "estimateList") as? Data{
            let decoder = JSONDecoder()
            if let estimateList = try? decoder.decode([PreEstimate].self, from: savedData){
                return estimateList
                
            }
            
        }
        
        return nil
    }
    
    // MARK: Local Push
    func sendLocalPush(title: String, body: String, identifier: String) {
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - Other Extensions
// MARK: Int
extension Int {
    var withCommaString: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))
    }
}

// MARK: Array
extension Array {
    subscript(indice indice: Int) -> Element? {
        return indices ~= indice ? self[indice] : nil
    }
}

// MARK: Date
extension Date {
    func isWeekday() -> Bool {
        let weekdayList = ["월", "화", "수", "목", "금"]
        let dayOfTheWeek = SupportingMethods.shared.convertDate(intoString: self, "EE")
        
        if weekdayList.contains(dayOfTheWeek) {
            return true
            
        } else {
            return false
            
        }
        
    }
    
    func isPeak() -> Bool {
        let peakList = [4,5,9,10]
        let month = Int(SupportingMethods.shared.convertDate(intoString: self, "M"))!
        
        if peakList.contains(month) {
            return true
            
        } else {
            return false
            
        }
    }
}

// MARK: UIImage
extension UIImage {
    var fixedOrientaion: UIImage {
        if self.imageOrientation == .up {
                return self
            }
        
            var transform: CGAffineTransform = CGAffineTransform.identity
            switch self.imageOrientation {
            case .down, .downMirrored:
                transform = transform.translatedBy(x: self.size.width, y: self.size.height)
                transform = transform.rotated(by: CGFloat(Double.pi))
                
            case .left, .leftMirrored:
                transform = transform.translatedBy(x: self.size.width, y: 0)
                transform = transform.rotated(by: CGFloat(Double.pi / 2))
                
            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0, y: self.size.height)
                transform = transform.rotated(by: CGFloat(-(Double.pi / 2)))
            default: // .up, .upMirrored
                break
            }

            switch self.imageOrientation {
            case .upMirrored, .downMirrored:
                //transform.translatedBy(x: self.size.width, y: 0)
                //transform.scaledBy(x: -1, y: 1)
                CGAffineTransformTranslate(transform, size.width, 0)
                CGAffineTransformScale(transform, -1, 1)
                
            case .leftMirrored, .rightMirrored:
                //transform.translatedBy(x: self.size.height, y: 0)
                //transform.scaledBy(x: -1, y: 1)
                CGAffineTransformTranslate(transform, size.height, 0)
                CGAffineTransformScale(transform, -1, 1)
                
            default: // .up, .down, .left, .right
                break
            }

            let ctx:CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: (self.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (self.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

            ctx.concatenate(transform)

            switch self.imageOrientation {
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
                
            default:
                ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            }

            let cgimg:CGImage = ctx.makeImage()!
            let img:UIImage = UIImage(cgImage: cgimg)

            return img
    }
    
    class func useCustomImage(_ name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage(systemName: "photo")!
    }
}

// MARK: UIDevice haptics
extension UIDevice {
    // MARK: Make Haptic Effect
    static func softHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .soft)
        haptic.impactOccurred()
    }
    
    static func lightHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
    }
    
    static func heavyHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .heavy)
        haptic.impactOccurred()
    }
}

// MARK: UIColor to be possible to get color using 0 ~ 255 integer
extension UIColor {
    class func useRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / CGFloat(255), green: green / CGFloat(255), blue: blue / CGFloat(255), alpha: alpha)
    }
}

// MARK: - Extension for UILabel
extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attributedString
    }
    
    func asFontColor(targetString: String, font: UIFont?, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        self.attributedText = attributedString
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        self.attributedText = attributeString
    }
}

// MARK: - Extension for UIView
enum VerticalLocation {
    case bottom
    case top
    case left
    case right
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.3, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 1), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -1), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -1, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 1, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

// MARK: String
extension String {
    func substring(from: Int, length: Int) -> String? {
        guard from < self.count && length > 0 && from + length <= self.count else {
            return nil
        }
        
        // Index 값 획득
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(startIndex, offsetBy: length - 1)
        
        // 파싱
        return String(self[startIndex...endIndex])
    }
    
//    func validatePathName() -> Bool {
////        // 정규식 pattern. 한글, 영어, 숫자, 공백만 있어야함
////        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9\\s]$"
//
//        // 정규식 pattern. 한글, 영어, 숫자, 공백만 있어야함 (초성 금지)
//        let pattern = "^[[가-힣a-zA-Z][0-9][\\s]]$"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
//
//        return predicate.evaluate(with: self)
//    }
    
    func validatePathName() -> Bool {
//        // 정규식 pattern. 한글, 영어, 숫자, 공백만 있어야함
//        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9\\s]$"
        
        // 정규식 pattern. 한글, 영어, 숫자, 공백만 있어야함 (초성 금지)
        let pattern = "^[가-힣a-zA-Z0-9\\s]$"
        let stringArray = Array(self)
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            for index in 0..<stringArray.count {
                let results = regex.matches(in: String(stringArray[index]), options: [], range: NSRange(location: 0, length: 1))
                if results.isEmpty {
                    return false
                }
            }
        }
        
        return true
    }
    
}

// MARK: Shadow
extension CALayer {
    func useSketchShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur / 2.0
        
        if spread == 0 {
            self.shadowPath = nil
            
        } else {
            let dx = -spread
            let rect = self.bounds.insetBy(dx: dx, dy: dx)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func useSketchShadow(color: UIColor, alpha: Float, shadowSize: CGFloat, viewSize: CGSize) {
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: viewSize.width + shadowSize,
                                                   height: viewSize.height + shadowSize))
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.shadowOpacity = alpha
        self.shadowPath = shadowPath.cgPath
    }
}

// MARK: UIFont
extension UIFont {
    enum PretendardFontType: String {
        case Black
        case Bold
        case ExtraBold
        case ExtraLight
        case Light
        case Medium
        case Regular
        case SemiBold
        case Thin
    }
    class func useFont(ofSize size: CGFloat, weight: PretendardFontType) -> UIFont {
        return UIFont(name: "PretendardVariable-\(weight.rawValue)", size: size)!
    }
}

// MARK: - PHAsset
extension PHAsset {
    var thumbnailImage : UIImage {
        get {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail: UIImage?
            option.isSynchronous = true
            manager.requestImage(for: self, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result
            })
            return thumbnail ?? UIImage()
        }
    }
}

extension UITextField {
    func setPlaceholder(placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 0, green: 0, blue: 0, alpha: 0.2),
            .font:UIFont.useFont(ofSize: 14, weight: .Regular)
        ])
    }
    
    func setBorder() {
        self.borderStyle = .none
        self.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
        self.addLeftPadding()
    }
    
    func addLeftPadding() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        
        self.leftView = view
        self.leftViewMode = ViewMode.always
    }
}

extension CLLocationCoordinate2D {
    /// Returns distance from coordianate in meters.
    /// - Parameter from: coordinate which will be used as end point.
    /// - Returns: Returns distance in meters.
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }
}

// MARK: - View Protocol
protocol EssentialViewMethods {
    func setViewFoundation()
    func initializeObjects()
    func setDelegates()
    func setGestures()
    func setNotificationCenters()
    func setSubviews()
    func setLayouts()
    func setViewAfterTransition()
}

// MARK: - Cell & Header Protocol
protocol EssentialCellHeaderMethods {
    func setViewFoundation()
    func initializeObjects()
    func setSubviews()
    func setLayouts()
}
