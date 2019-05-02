//
//  StudyViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import UIKit
import WebKit

/// Responsible for showing one chapter of the book as text.
class StudyViewController: UIViewController, TappableTextViewDelegate {
    var coordinator: LearnCoordinator?
    var chapter = ""

    // MARZIPAN: Attributed Strings from HTML don't work on macOS
    #if os(iOS) && !MARZIPAN
    var studyTextView = StudyTextView()
    #else
    var studyWebView = WKWebView()
    #endif

    override func loadView() {
        // MARZIPAN: Attributed Strings from HTML don't work on macOS
        #if os(iOS) && !MARZIPAN
        studyTextView.linkDelegate = self
        studyTextView.loadContent(chapter)
        view = studyTextView
        #else
        studyWebView.loadHTMLString(NSAttributedString.html(chapterName: chapter), baseURL: Bundle.main.resourceURL)
        view = studyWebView
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(coordinator != nil, "You must set a coordinator before presenting this view controller.")

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: coordinator, action: #selector(LearnCoordinator.finishedStudying))

        // always include the safe area insets in the scroll view content adjustment
        studyTextView.contentInsetAdjustmentBehavior = .always
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.resetNavigationBar()
        Unwrap.marzipanCoordinator?.setupLeftBarButtonItem(text: "Back", target: coordinator, action: #selector(LearnCoordinator.back))
        Unwrap.marzipanCoordinator?.setupRightBarButtonItem(text: "Next", target: coordinator, action: #selector(LearnCoordinator.finishedStudying))
        #endif
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // warn users there might be more content to scroll through

        // MARZIPAN: Attributed Strings from HTML don't work on macOS
        #if os(iOS) && !MARZIPAN
        studyTextView.flashScrollIndicators()
        #else
        studyWebView.scrollView.flashScrollIndicators()
        #endif
    }

    /// Most chapters have a video, so this catches link taps and triggers video playback.
    func linkTapped(_ url: URL) {
        let action = url.lastPathComponent

        if action == "playVideo" {
            coordinator?.playStudyVideo()
        } else {
            // this is some other kind of URL; open it up in a web view
            coordinator?.show(url: url)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // If our view controller is changing size we need to reload our content to make sure the movie view at the top correctly fills the full width of the screen.
        coordinator.animate(alongsideTransition: nil) { ctx in
            self.studyTextView.loadContent(self.chapter)
        }
    }
}
