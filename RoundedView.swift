//
//  RoundedView.swift
//  SJSegmentedScrollViewDemo
//
//  Created by Davit Isajanyan on 8/19/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

@objc class RoundedView: UIView {
    @IBInspectable var radius: Int = -1 {
        didSet {
            self.toRound()
        }
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.toRound()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.toRound()
    }
    
    private func toRound() {
        if radius < 0 {
            self.layer.cornerRadius = self.frame.size.height * 0.5
        } else {
            self.layer.cornerRadius = CGFloat(radius)
        }
        self.layer.masksToBounds = true
    }
}
