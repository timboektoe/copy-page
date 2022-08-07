//
//  HeaderFactory.swift
//  CopyPage
//
//  Created by Maksym Svitlovskyi on 02.08.2022.
//

import UIKit

public class HeaderFactory {

	private let componentsFactory = ComponentsFactory()

	public init() { }

	public func makeWebNavigationHeader() -> HeaderView {
		let headerView = HeaderView()

		let title = componentsFactory.makeHeaderTitle(with: L10n.Webnavigationview.Header.title)
		let subtitle = componentsFactory.makeHeaderSubtitle(with: L10n.Webnavigationview.Header.subtitle)

		headerView.add(view: title)
		headerView.add(view: subtitle)

		return headerView
	}

	public func makeMoveToWebHeader(
		with headline: String,
		with action: @escaping () -> Void,
		completion: (() -> Void)? = nil
	) -> HeaderView {
		let headerView = HeaderView()

		let title = componentsFactory.makeHeaderTitle(with: L10n.Webnavigationview.PromptHeader.title)
		let subtitle = componentsFactory.makeHeaderSubtitle(with: L10n.Webnavigationview.PromptHeader.description)
		let button = componentsFactory.makeButton(with: L10n.Webnavigationview.PromptHeader.button, action: {
			action()
			headerView.removeFromSuperview()
			completion?()
		})

		let header = UILabel()
		header.text = L10n.Webnavigationview.PromptHeader.headline(headline)

		headerView.add(view: title)
		headerView.add(view: header)
		headerView.add(view: subtitle)
		headerView.add(view: button)

		return headerView
	}

	public func doneWebHeader(
		action: @escaping () -> Void
	) -> HeaderView {
		let headerView = HeaderView()

		let title = componentsFactory.makeHeaderTitle(with: L10n.Webnavigationview.DoneHeader.title)
		let subtitle = componentsFactory.makeHeaderSubtitle(with: L10n.Webnavigationview.DoneHeader.subtitle)
		let button = componentsFactory.makeButton(with: L10n.Webnavigationview.DoneHeader.button, action: action)

		headerView.add(view: title)
		headerView.add(view: subtitle)
		headerView.add(view: button)

		return headerView
	}

	public func documentsNavigationViewHeader() -> HeaderView {
		let headerView = HeaderView()

		let title = componentsFactory.makeHeaderTitle(with: L10n.Documentsnavigationview.title)
		let subtitle = componentsFactory.makeHeaderSubtitle(with: L10n.Documentsnavigationview.subtitle)

		headerView.add(view: title)
		headerView.add(view: subtitle)

		return headerView
	}
}
