//
//  UserDefaultsManager.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 26.07.2022.
//

import Foundation

public class UserDefaultsManager {

	public static let container = UserDefaults(suiteName: "group.copypage.safariappextension")!

	public static let app = UserDefaults.standard
}
