//
//  StudyViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2018 Hacking with Swift.
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
        }
    }
}
