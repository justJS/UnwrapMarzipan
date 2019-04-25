//
//  CreditsViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import UIKit

class CreditsViewController: UIViewController, Storyboarded {
    @IBOutlet var textView: UITextView!
    var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(coordinator != nil, "You must set a coordinator before presenting this view controller.")

        title = "Credits"

        let contents = String(bundleName: "Credits.md")
        textView.attributedText = contents.fromSimpleMarkdown()
    }

    override func viewDidLayoutSubviews() {
        // Set content offset to zero to make sure the textview starts from the top
        // when the view is laid out.
        textView.setContentOffset(.zero, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.resetNavigationBar()
        Unwrap.marzipanCoordinator?.setupLeftBarButtonItem(text: "Back", target: coordinator, action: #selector(HomeCoordinator.back))
        #endif
    }
}
