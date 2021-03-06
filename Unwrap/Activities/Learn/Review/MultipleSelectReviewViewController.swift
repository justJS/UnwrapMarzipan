//
//  MultipleSelectReviewViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import UIKit

class MultipleSelectReviewViewController: ReviewViewController, Storyboarded {
    @IBOutlet var prompt: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var answerButton: UIButton!

    var dataSource: MultipleSelectReviewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = getTitle()
        dataSource = MultipleSelectReviewDataSource(review: review)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.isEditing = true

        prompt.attributedText = review.question.fromSimpleHTML()
    }

    func getTitle() -> String {
        return "Review"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.setTitle(title!)
        #endif
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // warn users there might be more cells to scroll through
        tableView.flashScrollIndicators()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        tableView.reloadData()

        // Set the theme on Marzipan
        #if MARZIPAN
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = .darkGray
        } else {
            tableView.backgroundColor = .white
        }
        #endif
    }

    @IBAction func checkAnswer(_ sender: Any) {
        if dataSource.isShowingAnswers {
            coordinator?.answerSubmitted(from: self, wasCorrect: dataSource.isUserCorrect)
        } else {
            dataSource.isShowingAnswers = true
            tableView.reloadData()

            answerButton.setTitle("CONTINUE", for: .normal)
            navigationItem.leftBarButtonItem?.isEnabled = false

            // MARZIPAN: Set up macOS navigation bar items
            #if MARZIPAN
            Unwrap.marzipanCoordinator?.leftBarButtonItem?.isEnabled = false
            #endif
        }
    }
}
