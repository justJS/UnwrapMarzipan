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
        setupGlobalMenuItems()

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

    // MARK: Segmented Control

    func setupSegmentedControl() {
        segmentedControl = _UIWindowToolbarSegmentedControlItem(identifier: "segmentedControl")
        segmentedControl.target = self
        segmentedControl.action = #selector(segmentedControlDidChange)
        segmentedControl.segmentTitles = ["Home", "Learn", "Practice", "Challenges", "News"]
    }

    @objc func segmentedControlDidChange() {
        let index = segmentedControl.selectedSegment

        switch index {
        case 1:
            currentViewController = learn.splitViewController
        case 2:
            currentViewController = practice.splitViewController
        case 3:
            currentViewController = challenges.splitViewController
        case 4:
            currentViewController = news.splitViewController
        default:
            currentViewController = home.navigationController
        }
    }

    // MARK: Menu

    func setupGlobalMenuItems() {
        let separator = _UIMenuBarItem.separatorItem() as! _UIMenuBarItem

        let homeItem = _UIMenuBarItem(title: "Home", action: #selector(mainMenuBarItemClicked), keyEquivalent: "1")
        homeItem?.target = self

        let learnItem = _UIMenuBarItem(title: "Learn", action: #selector(learnMenuBarItemClicked), keyEquivalent: "2")
        learnItem?.target = self

        let practiceItem = _UIMenuBarItem(title: "Practice", action: #selector(practiceMenuBarItemClicked), keyEquivalent: "3")
        practiceItem?.target = self

        let challengesItem = _UIMenuBarItem(title: "Challenges", action: #selector(challengesMenuBarItemClicked), keyEquivalent: "4")
        challengesItem?.target = self

        let newsItem = _UIMenuBarItem(title: "News", action: #selector(newsMenuBarItemClicked), keyEquivalent: "5")
        newsItem?.target = self

        (_UIMenuBarMenu.mainMenu() as? _UIMenuBarMenu)?.insertItems([homeItem, learnItem, practiceItem, challengesItem, newsItem, separator], atBeginningOfMenu: _UIMenuBarStandardMenuIdentifierWindow)
    }

    @objc func mainMenuBarItemClicked() {
        segmentedControl.setSelected(true, forSegment: 0)
        currentViewController = home.navigationController
    }

    @objc func learnMenuBarItemClicked() {
        segmentedControl.setSelected(true, forSegment: 1)
        currentViewController = learn.splitViewController
    }

    @objc func practiceMenuBarItemClicked() {
        segmentedControl.setSelected(true, forSegment: 2)
        currentViewController = practice.splitViewController
    }

    @objc func challengesMenuBarItemClicked() {
        segmentedControl.setSelected(true, forSegment: 3)
        currentViewController = challenges.splitViewController
    }

    @objc func newsMenuBarItemClicked() {
        segmentedControl.setSelected(true, forSegment: 4)
        currentViewController = news.splitViewController
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
            currentViewController = challenges.splitViewController
        } else if shortcutItem.type == "com.hackingwithswift.unwrapswift.news" {
            currentViewController = news.splitViewController
        } else {
            fatalError("Unknown shortcut item type: \(shortcutItem.type).")
        }
    }
}
#endif
