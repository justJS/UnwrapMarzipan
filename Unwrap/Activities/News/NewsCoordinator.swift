//
//  NewsCoordinator.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import UIKit

// MARZIPAN: Some frameworks are not available on macOS
#if os(iOS) && !MARZIPAN
import SafariServices
#endif

/// Manages everything launched from the News tab in the app.
class NewsCoordinator: Coordinator {
    var navigationController: CoordinatedNavigationController

    init(navigationController: CoordinatedNavigationController = CoordinatedNavigationController()) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.coordinator = self

        let viewController = NewsViewController(style: .plain)
        viewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(bundleName: "News"), tag: 4)
        viewController.coordinator = self

        navigationController.viewControllers = [viewController]

        // force our view controller to load immediately, so we download the news in the background rather than waiting for users to go to the tab
        viewController.loadViewIfNeeded()
    }

    /// Creates and configures – but does not show! – a Safari view controller for a specific article. This might be called when the user tapped a story, or when they 3D touch one.
    func readViewController(for article: NewsArticle) -> UIViewController {
        // MARZIPAN: SafariServices is not available on macOS
        #if os(iOS) && !MARZIPAN
        let viewController = SFSafariViewController(url: article.url)
        return viewController
        #else
        return UIViewController()
        #endif
    }

    /// Triggered when we already have a Safari view controller configured and ready to go, so we just show it.
    func startReading(using viewController: UIViewController, withURL url: URL) {
        navigationController.present(viewController, animated: true)
        User.current.readNewsStory(forURL: url)
    }

    /// Creates, configures, and presents a Safari view controller for a specific article.
    func read(_ article: NewsArticle) {
        // MARZIPAN: SafariServices is not available on macOS
        #if os(iOS) && !MARZIPAN
        let viewController = readViewController(for: article)
        startReading(using: viewController, withURL: article.url)
        #else
        UIApplication.shared.open(article.url)
        User.current.readNewsStory(forURL: article.url)
        #endif
    }

    /// Loads the Hacking with Swift store.
    @objc func buyBooks() {
        let storeURL = URL(staticString: "https://www.hackingwithswift.com/store")

        // MARZIPAN: SafariServices is not available on macOS
        #if os(iOS) && !MARZIPAN
        let viewController = SFSafariViewController(url: storeURL)
        navigationController.present(viewController, animated: true)
        #else
        UIApplication.shared.open(storeURL)
        #endif
    }
}
