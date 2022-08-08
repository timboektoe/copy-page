import Foundation

enum WebItemsRepositoryErrors: LocalizedError {
	case dataIsNil
}

public protocol WebItemsRepositoryProtocol {
	func getWebModels(completion: @escaping (Result<WebSite, Error>) -> Void)
	func readWebModels() -> WebSite
}

public class WebItemsRepository: WebItemsRepositoryProtocol {

	public struct ServerConfigurationModel: Decodable {
		var stub: Bool
		var sources: [String]
	}

	// TODO: Dependency injection ?
	private var serverConfiguration: ServerConfigurationModel? = nil

	public init() { }

	public init(with configuration: ServerConfigurationModel) {
		self.serverConfiguration = configuration
	}

	public func getWebModels(completion: @escaping (Result<WebSite, Error>) -> Void) {

		if let serverConfiguration = serverConfiguration {
			completion(.success(getEnabledWebSites(for: serverConfiguration)))
		} else {
			getServerConfiguration { result in
				switch result {
				case .success(let config):
					completion(.success(self.getEnabledWebSites(for: config)))
					self.serverConfiguration = config
				case .failure(let error):
					completion(.failure(error))
				}
			}
		}
	}

	private func getEnabledWebSites(for config: ServerConfigurationModel) -> WebSite {
		return readWebModels().filter {
			config.sources.contains($0.source)
		}
	}

	public func readWebModels() -> WebSite {
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

	private func getServerConfiguration(completion: @escaping (Result<ServerConfigurationModel, Error>) -> Void) {

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
				completion(.failure(WebItemsRepositoryErrors.dataIsNil))
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
