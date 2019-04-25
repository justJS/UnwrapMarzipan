//
//  ViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2019 Hacking with Swift.
//

import UIKit

// MARZIPAN: Some frameworks are not available on macOS
#if os(iOS) && !MARZIPAN
import SwiftEntryKit
#endif

/// The first run screen for the app, explaining the basics of how things work.
class WelcomeViewController: UIViewController, Storyboarded {
    /// Triggered when the user taps Start Tour
    @IBAction func startTour(_ sender: Any) {
        guard let view = self.view as? WelcomeView else {
            fatalError("WelcomeViewController doesn't have a WelcomeView as its view.")
        }

        view.showTour()
    }

    /// Triggered when the user wants to end the tour at any point.
    @IBAction func skipTour(_ sender: Any) {
        // MARZIPAN: SwiftEntryKit is not available on macOS
        #if os(iOS) && !MARZIPAN
        SwiftEntryKit.dismiss()
        #else
        navigationController?.dismiss(animated: true)
        #endif
    }
}
