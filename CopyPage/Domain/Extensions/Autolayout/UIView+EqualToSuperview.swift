//
//  UIView+EqualToSuperview.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

extension UIView {
	func constraintsEqualToSuperview() {

		guard let superview = self.superview else {
			print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
			return
		}

		self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
		self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
		self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
		self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
	}
}
