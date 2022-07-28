//
//  UserDefaultsManager.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 26.07.2022.
//

import Foundation

class UserDefaultsManager {

	static let container = UserDefaults(suiteName: "group.copypage.safariappextension")!

	static let app = UserDefaults.standard
}
