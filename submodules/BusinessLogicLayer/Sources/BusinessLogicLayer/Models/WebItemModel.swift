// MARK: - WebSiteElement
public struct WebSiteElement: Codable {
	public let name, imageName: String
	public let url: String
	public let source: String
}


public typealias WebSite = [WebSiteElement]
