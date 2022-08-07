//
//  UIButton+Padding.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

extension UIButton {
	func setPadding(_ insets: UIEdgeInsets) {
		if #available(iOS 15, *) {

			if configuration == nil {
				self.configuration = .filled()
			}

			configuration?.contentInsets = NSDirectionalEdgeInsets(
				top: insets.top,
				leading: insets.left,
				bottom: insets.bottom,
				trailing: insets.right
			)
		} else {
			contentEdgeInsets = insets
		}
	}

	func setBackgroundColor(_ color: UIColor) {
		if #available(iOS 15, *) {
			
			if configuration == nil {
				configuration = .filled()
			}

			configuration?.baseBackgroundColor = color
			backgroundColor = color
		} else {
			backgroundColor = color
		}
	}
}
