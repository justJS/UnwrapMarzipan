//
//  ReviewViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import UIKit

class ReviewViewController: UIViewController, PracticingViewController {
    var coordinator: (AnswerHandling & Skippable)?

    var questionNumber = 1

    var practiceType = "review"

    var sectionName = ""
    var review: StudyReview!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Not implemented")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // We need to configure our navigation items super early to avoid janky animations thanks to our adaptive layout
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skip))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(hint))
        extendedLayoutIncludesOpaqueBars = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(coordinator != nil, "You must set a coordinator before presenting this view controller.")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.resetNavigationBar()
        Unwrap.marzipanCoordinator?.setTitle(title!)
        Unwrap.marzipanCoordinator?.setupLeftBarButtonItem(text: "Skip", target: self, action: #selector(skip))
        Unwrap.marzipanCoordinator?.setupRightBarButtonItem(text: "Hint", target: self, action: #selector(hint))
        #endif
    }

    @objc func hint() {
        showAlert(body: review.hint, on: self)
    }

    @objc func skip() {
        coordinator?.skipReviewing()
    }
}
