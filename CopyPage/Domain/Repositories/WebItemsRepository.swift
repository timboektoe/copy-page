//
//  WebItemsRepository.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 28.07.2022.
//

import Foundation

struct ServerConfigurationModel: Decodable {
	var stub: Bool
	var sources: [String]
}

enum WebItemsRepositoryErrors {
	case dataIsNil
}

protocol WebItemsRepositoryProtocol {
	func getWebModels(completion: @escaping (Result<WebSite, Error>) -> Void)
}

class WebItemsRepository: WebItemsRepositoryProtocol {

	func getWebModels(completion: @escaping (Result<WebSite, Error>) -> Void) {
		getServerConfiguration { result in
			switch result {
			case .success(let configuration):
				completion(.success(self.readWebModels().filter {
					configuration.sources.contains($0.source)
				}))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

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

	func getServerConfiguration(completion: @escaping (Result<ServerConfigurationModel, Error>) -> Void) {
		guard let url = URL(string: "https://iwize.nl/infolia/source-info.json") else {
			return
		}

		let session = URLSession.shared
		let request = URLRequest(url: url)

		let task = session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				return
			}

			do {
				let configuration = try JSONDecoder().decode(ServerConfigurationModel.self, from: data)
				completion(.success(configuration))
			} catch {
				completion(.failure(error))
			}
		}

		task.resume()
	}
}
