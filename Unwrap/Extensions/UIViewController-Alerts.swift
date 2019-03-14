//
//  UIViewController-Alerts.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2018 Hacking with Swift.
//

import UIKit

// MARZIPAN: Some frameworks are not available on macOS
#if os(iOS) && !MARZIPAN
import SwiftEntryKit
#endif

extension UIViewController {
    /// Does all the leg work of making any UIViewController be shown inside a pre-styled SwiftEntryKit alert.
    func presentAsAlert(on viewController: UIViewController) {
        // MARZIPAN: SwiftEntryKit is not available on macOS
        #if os(iOS) && !MARZIPAN
        var attributes = EKAttributes()
        attributes.displayDuration = .infinity

        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
        attributes.screenBackground = .color(color: UIColor(bundleName: "AlertBackgroundDim"))
        attributes.position = EKAttributes.Position.center
        view.clipsToBounds = true
        view.layer.cornerRadius = 20

        SwiftEntryKit.display(entry: self, using: attributes)
        #else
        viewController.present(self, animated: true)
        #endif
    }

    /// Shows an alert only if it hasn't already been shown.
    func showFirstTimeAlert(name: String, title: String, message: String) {
        let defaultsName = "Shown\(name)"

        if UserDefaults.standard.bool(forKey: defaultsName) == false {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)

            UserDefaults.standard.set(true, forKey: defaultsName)
        }
    }
}
