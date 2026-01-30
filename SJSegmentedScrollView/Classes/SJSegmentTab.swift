//
//  SJSegmentTab.swift
//  Pods
//
//  Created by Subins on 22/11/16.
//  Copyright © 2016 Subins Jose. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//    associated documentation files (the "Software"), to deal in the Software without restriction,
//    including without limitation the rights to use, copy, modify, merge, publish, distribute,
//    sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//    substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import UIKit

typealias DidSelectSegmentAtIndex = (_ segment: SJSegmentTab?,_ index: Int,_ animated: Bool) -> Void

open class SJSegmentTab: UIView {

	let kSegmentViewTagOffset = 100
	let button = UIButton(type: .custom)
    let badgeView = UIView()

	var didSelectSegmentAtIndex: DidSelectSegmentAtIndex?
	var isSelected = false {
		didSet {
			button.isSelected = isSelected
		}
	}

    convenience init(title: String) {
		self.init(frame: CGRect.zero)
        setTitle(title)
	}

	convenience init(view: UIView) {
		self.init(frame: CGRect.zero)

		insertSubview(view, at: 0)
		view.removeConstraints(view.constraints)
		addConstraintsToView(view)
	}

	required override public init(frame: CGRect) {
		super.init(frame: frame)

		translatesAutoresizingMaskIntoConstraints = false
		button.frame = bounds
		button.addTarget(self, action: #selector(SJSegmentTab.onSegmentButtonPress(_:)),
		                 for: .touchUpInside)
		addSubview(button)
		addConstraintsToView(button)
        
        badgeView.bounds = CGRect(x: 0, y: 0, width: 4, height: 4)
        badgeView.layer.cornerRadius = 2
        badgeView.layer.masksToBounds = true
        badgeView.backgroundColor = UIColor.red
        badgeView.isHidden = false
        addSubview(badgeView)
        
        setupConstraints()
	}
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	func addConstraintsToView(_ view: UIView) {

		view.translatesAutoresizingMaskIntoConstraints = false
		let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
		                                                         options: [],
		                                                         metrics: nil,
		                                                         views: ["view": view])
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
		                                                           options: [],
		                                                           metrics: nil,
		                                                           views: ["view": view])
		addConstraints(verticalConstraints)
		addConstraints(horizontalConstraints)
	}
    
    private func setupConstraints() {
        badgeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            badgeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            badgeView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            badgeView.widthAnchor.constraint(equalToConstant: 4),
            badgeView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    open func setTitle(_ title: String, rightInsets: CGFloat = 5) {
        
        button.setTitle(title, for: .normal)
        button.imageEdgeInsets.right = rightInsets
    }
    
    open func setImage(_ image: UIImage) {
        
        button.setImage(image, for: .normal)
    }

	open func titleColor(_ color: UIColor) {
        button.tintColor = color
		button.setTitleColor(color, for: .normal)
	}
    
    open func selectedTitleColor(_ color: UIColor?) {
        
        button.setTitleColor(color, for: .selected)
    }

	open func titleFont(_ font: UIFont) {

		button.titleLabel?.font = font
	}
    
    open func enableButton(enable: Bool) {
    }
    
    open func updateBadgeView(_ isHidden: Bool) {
        badgeView.isHidden = isHidden
    }
    
    open func updateTitle(title: String, image: UIImage? = nil, leftInsets: CGFloat = 5, rightInsets: CGFloat = 5) {
        self.setTitle(title, rightInsets: rightInsets)
        if let image = image {
            self.button.titleEdgeInsets.left = leftInsets
            self.setImage(image)
        }
    }
    
    open func setTitleEdgeInsets(_ inset: UIEdgeInsets) {
        self.button.titleEdgeInsets = inset
    }
    
    open func setImageEdgeInsets(_ inset: UIEdgeInsets) {
        self.button.titleEdgeInsets = inset
    }

	@objc func onSegmentButtonPress(_ sender: AnyObject) {
		let index = tag - kSegmentViewTagOffset
		NotificationCenter.default.post(name: Notification.Name(rawValue: "DidChangeSegmentIndex"),
		                                object: index)
        didSelectSegmentAtIndex?(self, index, true)
	}
}
