//
//  HomeViewController.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/26/24.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    lazy var viewModel = HomeViewModel()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = UITableViewController()
        tableView = controller.tableView
        tableView.separatorStyle = .none
        tableView.backgroundColor = .red
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
