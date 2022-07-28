//
//  WebItemsRepository.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 28.07.2022.
//

import Foundation

class WebItemsRepository {
	func readWebModels() -> WebSite {
		guard let url = Bundle.main.url(forResource: "webmodels", withExtension: "json") else {
			fatalError("Cant find url")
		}

		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			let result = try decoder.decode(WebSite.self, from: data)
			return result
		} catch {
			fatalError(error.localizedDescription)
		}
	}
}
