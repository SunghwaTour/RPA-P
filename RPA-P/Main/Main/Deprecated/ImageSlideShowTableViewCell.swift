//
//  ImageSlideShowTableViewCell.swift
//  RPA-P
//
//  Created by Awesomepia on 9/1/24.
//

import UIKit
import ImageSlideshow

final class ImageSlideShowTableViewCell: UITableViewCell {

    lazy var imageSlideShow: ImageSlideshow = {
        let pageIndicator = LabelPageIndicator()
        
        let imageSlideShow = ImageSlideshow()
        imageSlideShow.contentScaleMode = .scaleToFill
        imageSlideShow.circular = true
        imageSlideShow.scrollView.bounces = false
        imageSlideShow.slideshowInterval = 3
        imageSlideShow.pageIndicator = pageIndicator
        imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .right(padding: 15), vertical: .customBottom(padding: 10))
        imageSlideShow.delegate = self
        imageSlideShow.translatesAutoresizingMaskIntoConstraints = false
        
        var imageResources: [ImageSource] = [
            ImageSource(image: .useCustomImage("Seorak")),
            ImageSource(image: .useCustomImage("Naejangsan")),
            ImageSource(image: .useCustomImage("Mureung")),
        ]
        imageSlideShow.setImageInputs(imageResources)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageSlideShow(_:)))
        imageSlideShow.addGestureRecognizer(gesture)
        
        return imageSlideShow
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCellFoundation()
        self.initializeViews()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: Extension for essential methods
extension ImageSlideShowTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
    }
    
    // Initialize views
    func initializeViews() {
        
    }
    
    // Set gestures
    func setGestures() {
        
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.imageSlideShow,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // imageSlideShow
        NSLayoutConstraint.activate([
            self.imageSlideShow.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageSlideShow.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageSlideShow.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageSlideShow.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageSlideShow.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 329/360),
        ])
    }
}

// MARK: - Extension for methods added
extension ImageSlideShowTableViewCell {
    func setCell() {
        
    }
}

// MARK: - Extension for selector added
extension ImageSlideShowTableViewCell {
    @objc func imageSlideShow(_ gesture: UITapGestureRecognizer) {
        //FIXME: Userinfo도 담아서 줘야함
        NotificationCenter.default.post(name: Notification.Name("PushTourView"), object: nil)
        
    }
}



// MARK: - Extension for ImageSlideshowDelegate
extension ImageSlideShowTableViewCell: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        
    }
    
}
