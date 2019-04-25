//
//  NewsViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2018 Hacking with Swift.
//

import UIKit

/// The main view controller you see in  the Challenges tab in the app.
class NewsViewController: UITableViewController, Storyboarded {
    var coordinator: NewsCoordinator?

    /// This handles all the rows in our table view, including downloading news.
    var dataSource = NewsDataSource()

    /// This handles showing something meaningful if news download failed.
    var emptyDataSource = NewsEmptyDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(coordinator != nil, "You must set a coordinator before presenting this view controller.")

        title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buy Swift Books", style: .plain, target: coordinator, action: #selector(NewsCoordinator.buyBooks))

        dataSource.delegate = self
        tableView.dataSource = dataSource

        // Configure DZNEmptyDataSource to show a meaningful message when news loading fails. We need to create an empty table footer view to stop separators appearing everywhere.
        tableView.emptyDataSetSource = emptyDataSource
        tableView.emptyDataSetDelegate = emptyDataSource
        tableView.tableFooterView = UIView()
        emptyDataSource.delegate = self

        // MARZIPAN: 3D Touch is disabled on macOS for now
        #if os(iOS) && !MARZIPAN
        registerForPreviewing(with: self, sourceView: tableView)
        #endif

        // Allow folks to pull to refresh stories. Honestly, this will never actually do anything because it's not like I publish *that* often, but it's a bit like close buttons on an elevator – people expect them to work.
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchArticles), for: .valueChanged)

        // Start fetching news articles as soon as we're loaded.
        fetchArticles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.resetNavigationBar()
        Unwrap.marzipanCoordinator?.setupRightBarButtonItem(text: "Buy Swift Books", target: coordinator, action: #selector(NewsCoordinator.buyBooks))
        #endif
    }

    /// Clears our tab badge as soon as we're shown.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarItem.badgeValue = nil
        dataSource.containsNewArticles = false
    }

    /// Tell the delegate we need to fetch articles immediately.
    @objc func fetchArticles() {
        dataSource.fetchArticles()
    }

    /// Called as soon as our data source has finished its news download, so we can update the UI.
    func finishedLoadingArticles() {
        tableView.reloadData()
        refreshControl?.endRefreshing()

        // if we aren't currently visible, show a star
        if tabBarController?.selectedViewController != navigationController {
            if dataSource.containsNewArticles {
                tabBarItem.badgeValue = "★"
            }
        }
    }

    /// Called when the user selects a news story.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = dataSource.article(at: indexPath.row)
        coordinator?.read(article)
    }
}

// MARZIPAN: 3D Touch is disabled on macOS for now
#if os(iOS) && !MARZIPAN
extension NewsViewController: UIViewControllerPreviewingDelegate {
    /// Called when the user 3D touches on a news story.
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            let article = dataSource.article(at: indexPath.row)
            return coordinator?.readViewController(for: article)
        }

        return nil
    }

    /// Called when the user 3D touches harder on a news story.
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        coordinator?.startReading(using: viewControllerToCommit)
    }
}
#endif
