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
                roundedCorner()
            } else {
             setCustomCorner()
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
                roundedCorner()
            } else {
                setCustomCorner()
            }
        }
    }
    
    // MARK: - Private variables
    private var progressValue: CGFloat = 0

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    // MARK: - Public methods
    
    public func setProgress(_ ratio: CGFloat, update: Bool? = true, updataWithAnimation: Bool? = true) {
        if ratio < 0 {
            print("Warning: progress can't be negative. Progress will be set to 0 ")
            progressValue = 0
        } else if ratio > 1 {
            print("Progress take values between 0 and 1, where 1 is 100%. Progress will be set to 1")
            progressValue = self.frame.size.height
        } else {
        progressValue = ratio * self.frame.size.height
        }
        if update == true {
            guard let animation = updataWithAnimation else {
                updateProgress(animation: true)
                return
            }
            updateProgress(animation: animation)
        }
    }
    
    public func setProgressColor(withColor color: UIColor, animated: Bool? = true) {
        if animated == true {
            UIView.animate(withDuration: animationDuration) {
                self.progressScaleView.backgroundColor = color
            }
        }
        progressScaleView.backgroundColor = color
    }
    
    public func updateProgress(animation: Bool) {
        if animation {
            UIView.animate(withDuration: animationDuration) {
                self.heightConstraint.constant = self.progressValue
                self.layoutIfNeeded()
            }
        } else {
            self.heightConstraint.constant = self.progressValue
            self.layoutIfNeeded()
        }
    }
    // MARK: - Private methods
    
    func roundedCorner() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.progressScaleView.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func setCustomCorner() {
        self.layer.cornerRadius = corner
        self.progressScaleView.layer.cornerRadius = corner
    }
}
