//
//  WebItemModel.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 25.07.2022.
//

import Foundation

// MARK: - WebSiteElement
struct WebSiteElement: Codable {
	let name, imageName: String
	let url: String
	let source: String
}


typealias WebSite = [WebSiteElement]
