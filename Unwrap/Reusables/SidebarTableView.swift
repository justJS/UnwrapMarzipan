//
//  SidebarTableView.swift
//  Unwrap
//
//  Created by Julian Schiavo on 26/4/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class SidebarTableView: UITableView {
    override var style: UITableView.Style {
        return UITableView.Style(rawValue: Int(UITableViewStyleSidebar))!
    }

    override init(frame: CGRect, style: UITableView.Style) {
        // MARZIPAN: Some frameworks are not available on macOS
        #if MARZIPAN
        let sidebarStyle = UITableView.Style(rawValue: Int(UITableViewStyleSidebar))
        super.init(frame: frame, style: sidebarStyle!)
        #else
        super.init(frame: frame, style: style)
        #endif
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
