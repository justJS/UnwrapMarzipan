//
//  GlossaryViewController.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/01/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class GlossaryViewController: UITableViewController {
    let dataSource = GlossaryDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Glossary"
        navigationItem.largeTitleDisplayMode = .never

        tableView.dataSource = dataSource
        tableView.register(GlossaryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARZIPAN: Set up macOS navigation bar items
        #if MARZIPAN
        navigationController?.setNavigationBarHidden(true, animated: false)
        Unwrap.marzipanCoordinator?.resetNavigationBar()
        Unwrap.marzipanCoordinator?.setupLeftBarButtonItem(text: "Back", target: self, action: #selector(back))
        #endif
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        // MARZIPAN: Set up macOS navigation bar items
//        #if MARZIPAN
//        Unwrap.marzipanCoordinator?.resetNavigationBar()
//        #endif
//    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}
