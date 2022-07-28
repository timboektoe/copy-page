//
//  UserDefaults+isExist.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 28.07.2022.
//

import Foundation

extension UserDefaults {

	func valueExists(forKey key: String) -> Bool {
		return object(forKey: key) != nil
	}

}
