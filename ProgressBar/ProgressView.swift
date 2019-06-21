//
//  ProgressView.swift
//  ProgressBar
//
//  Created by metoSimka on 21/06/2019.
//  Copyright © 2019 metoSimka. All rights reserved.
//
//

import UIKit

@IBDesignable
class VerticalProgressView: UIView {
    
    // MARK: - Public variables
    var progressScaleView = UIView()
    var heightConstraint = NSLayoutConstraint()
    
    // MARK: - IBInspectable
    @IBInspectable
    var animationDuration = 0.5
    
    @IBInspectable
    var progress: CGFloat = 0.0 {
        didSet {
            setProgress(progress)
        }
    }
    
    @IBInspectable
    var corner: CGFloat = 0.0 {
        didSet {
            if autoCorner {
                updateCornerRadius(withValue: self.frame.size.width/2)
            } else {
                updateCornerRadius(withValue: corner)
            }
        }
    }
    
    @IBInspectable
    var colorProgress: UIColor = UIColor.blue {
        didSet {
            progressScaleView.backgroundColor = colorProgress
        }
    }
    
    @IBInspectable var autoCorner: Bool = true {
        didSet{
            if autoCorner {
                updateCornerRadius(withValue: self.frame.size.width/2)
            } else {
                updateCornerRadius(withValue: corner)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        setupProgressScaleView()
    }
    
    // MARK: - Private variables
    private var progressValue: CGFloat = 0
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Public methods
    
    public func setProgress(_ ratio: CGFloat) {
        if ratio < 0 {
            progressValue = 0
        } else if ratio > 1 {
            progressValue = self.frame.size.height
        } else {
            progressValue = ratio * self.frame.size.height
        }
        updateProgress()
    }
    
    public func setProgressColor(withColor color: UIColor) {
        progressScaleView.backgroundColor = color
    }
    
    // MARK: - Private methods
    
    func updateCornerRadius(withValue: CGFloat) {
        self.layer.cornerRadius = withValue
        self.progressScaleView.layer.cornerRadius = withValue
    }
    
    public func updateProgress() {
        self.heightConstraint.constant = self.progressValue
        self.layoutIfNeeded()
    }
    
    private func setupProgressScaleView() {
        self.addSubview(progressScaleView)
        progressScaleView.frame = CGRect(x: 0,
                                         y: 0,
                                         width:self.frame.size.width,
                                         height:self.frame.size.height)
        
        progressScaleView.translatesAutoresizingMaskIntoConstraints = false
        let activeBarConstraintBottom = NSLayoutConstraint(item: progressScaleView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let activeBarConstraintLeading = NSLayoutConstraint(item: progressScaleView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let activeBarConstraintTrailling = NSLayoutConstraint(item: progressScaleView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        heightConstraint = NSLayoutConstraint(item: progressScaleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: progressValue)
        
        self.addConstraints([activeBarConstraintBottom, activeBarConstraintLeading,activeBarConstraintTrailling, heightConstraint])
        self.bounds.size.width = progressScaleView.bounds.size.width
    }
}

