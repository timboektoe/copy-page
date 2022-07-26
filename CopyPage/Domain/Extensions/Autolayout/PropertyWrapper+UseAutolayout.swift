//
//  PropertyWrapper+UseAutolayout.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import UIKit

@propertyWrapper
public struct UseAutoLayout<T: UIView> {
	public var wrappedValue: T {
		didSet {
			setAutoLayout()
		}
	}

	public init(wrappedValue: T) {
		self.wrappedValue = wrappedValue
		setAutoLayout()
	}

	func setAutoLayout() {
		wrappedValue.translatesAutoresizingMaskIntoConstraints = false
	}
}
