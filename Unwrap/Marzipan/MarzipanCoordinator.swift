//
//  MarzipanCoordinator.swift
//  Unwrap
//
//  Created by Julian Schiavo on 14/3/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

// MARZIPAN: Replacement for UITabBarController
#if MARZIPAN
class MarzipanCoordinator: NSObject {
    let window: UIWindow?

    let home = HomeCoordinator()
    let learn = LearnCoordinator()
    let practice = PracticeCoordinator()
    let challenges = ChallengesCoordinator()
    let news = NewsCoordinator()

    var currentViewController: UIViewController {
        didSet {
            window?.rootViewController = currentViewController
        }
    }

    // Navigation Bar Items
    private var titleLabel: _UIWindowToolbarLabelItem?
    private var segmentedControl: _UIWindowToolbarSegmentedControlItem!
    var leftBarButtonItem: _UIWindowToolbarButtonItem?
    var rightBarButtonItem: _UIWindowToolbarButtonItem?

    init(window: UIWindow?) {
        self.window = window
        currentViewController = home.navigationController

        super.init()

        setupSegmentedControl()
        refreshNavigationBar()
    }

    // MARK: Navigation Bar

    func resetNavigationBar() {
        titleLabel = nil
        leftBarButtonItem = nil
        rightBarButtonItem = nil
        refreshNavigationBar()
    }

    func refreshNavigationBar() {
        var items = [AnyHashable]()
        var itemIdentifiers = [String]()
        var centeredItemIdentifier = ""

        if let leftBarButtonItem = leftBarButtonItem {
            items.append(leftBarButtonItem)
            itemIdentifiers.append(leftBarButtonItem.identifier)
        }

        if let titleLabel = titleLabel {
            items.append(titleLabel)
            itemIdentifiers.append("NSToolbarFlexibleSpaceItem")
            itemIdentifiers.append("titleLabel")
            centeredItemIdentifier = "titleLabel"
        } else {
            items.append(segmentedControl)
            itemIdentifiers.append("segmentedControl")
            centeredItemIdentifier = "segmentedControl"
        }

        if let rightBarButtonItem = rightBarButtonItem {
            items.append(rightBarButtonItem)
            itemIdentifiers.append("NSToolbarFlexibleSpaceItem")
            itemIdentifiers.append(rightBarButtonItem.identifier)
        }

        window?._windowToolbarController().templateItems = Set<AnyHashable>(items)
        window?._windowToolbarController()?.itemIdentifiers = itemIdentifiers

        window?._windowToolbarController().centeredItemIdentifier = centeredItemIdentifier
        window?._windowToolbarController().autoHidesToolbarInFullScreen = true
    }

    func setTitle(_ title: String) {
        titleLabel = _UIWindowToolbarLabelItem(identifier: "titleLabel")
        titleLabel?.text = title
        refreshNavigationBar()
    }

    func setupLeftBarButtonItem(text: String? = nil, imageName: String? = nil, target: AnyObject!, action: Selector!) {
        leftBarButtonItem = _UIWindowToolbarButtonItem(identifier: UUID().uuidString)
        leftBarButtonItem?.target = target
        leftBarButtonItem?.action = action

        if let text = text {
            leftBarButtonItem?.title = text
        } else if let imageName = imageName {
            leftBarButtonItem?.imageName = imageName
        }

        refreshNavigationBar()
    }

    func setupRightBarButtonItem(text: String? = nil, imageName: String? = nil, target: AnyObject!, action: Selector!) {
        rightBarButtonItem = _UIWindowToolbarButtonItem(identifier: UUID().uuidString)
        rightBarButtonItem?.target = target
        rightBarButtonItem?.action = action

        if let text = text {
            rightBarButtonItem?.title = text
        } else if let imageName = imageName {
            rightBarButtonItem?.imageName = imageName
        }

        refreshNavigationBar()
    }

    func setupSegmentedControl() {
        segmentedControl = _UIWindowToolbarSegmentedControlItem(identifier: "segmentedControl")
        segmentedControl.target = self
        segmentedControl.action = #selector(segmentedControlDidChange)
        segmentedControl.segmentTitles = ["Home", "Learn", "Practice", "Challenges", "News"]
        /* Or, use images
         item.segmentImageNames = @[@"TabOneIcon", @"TabTwoIcon"];
         */
    }

    @objc func segmentedControlDidChange() {
        let index = segmentedControl.selectedSegment

        switch index {
        case 0:
            currentViewController = home.navigationController
        case 1:
            currentViewController = learn.navigationController
        case 2:
            currentViewController = practice.navigationController
        case 3:
            currentViewController = challenges.navigationController
        case 4:
            currentViewController = news.navigationController
        default:
            currentViewController = home.navigationController
        }
    }

    // MARK: AppDelegate

    /// If we get some launch options, figure out which one was requested and jump right to the correct tab.
    func handle(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let item = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
            handle(shortcutItem: item)
        }
    }

    func handle(shortcutItem: UIApplicationShortcutItem) {
        if shortcutItem.type == "com.hackingwithswift.unwrapswift.challenges" {
            currentViewController = challenges.navigationController
        } else if shortcutItem.type == "com.hackingwithswift.unwrapswift.news" {
            currentViewController = news.navigationController
        } else {
            fatalError("Unknown shortcut item type: \(shortcutItem.type).")
        }
    }
}
#endif
