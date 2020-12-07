//
//  ProgressView.swift
//  NYNews
//
//  Created by Klaws Achkar on 12/7/20.
//  Copyright © 2019 Klaws Achkar. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bkgdView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var parentView: UIView!
    
    init(_ view: UIView) {
        super.init(frame: view.bounds)
        self.parentView = view
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        commonInit()
    }
    
    func commonInit() {
        // Load the View for the class
        Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)
        // Add the content view
        addSubview(contentView)
        // Set the content view frame to the view bounds
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // Animate the activity indicator
        activityIndicator.startAnimating()
        // Set the corner radius for the message container
        containerView.layer.cornerRadius = 5
    }
    
    func show(_ message: String) {
        // Set the message text
        progressLabel.text = message
        // Show the Progress view
        parentView.addSubview(self)
    }
    
    func hide() {
        // Hide the Progress view by removing it from its superview
        self.removeFromSuperview()
    }
}
