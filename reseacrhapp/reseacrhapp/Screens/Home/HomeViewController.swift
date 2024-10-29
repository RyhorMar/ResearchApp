//
//  HomeViewController.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/26/24.
//

import UIKit
import SnapKit


import ResearchKitUI

final class HomeViewController: UIViewController {
    lazy var viewModel = HomeViewModel()
    private var tableView: UITableView!
    private var loader: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureAddButton()
        viewModel.loadData { [weak self] in
            guard let self else { return }
            if self.viewModel.content.count > 0 {
                self.tableView.reloadData()
            }
            else {
                self.addUser()
            }
        }
    }
    
    private func configure() {
        navigationController?.navigationBar.tintColor = .blue
        let controller = UITableViewController()
        tableView = controller.tableView
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        addUser()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier:"cellReuseIdentifier")
        }
        cell?.textLabel?.text = viewModel.content[indexPath.row].name
        let age = viewModel.content[indexPath.row].age ?? 0
        let email = viewModel.content[indexPath.row].email ?? ""
        cell?.detailTextLabel?.text = "Age: \(age) Email: \(email)"
    return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController {
    private func addUser() {
        /// Prepare ORKTask with ORKSteps
        let task = viewModel.taskWithStepsToAddUser()
        /// configure Task View Controller(
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self
        
        present(taskViewController, animated: true)
    }
}

extension HomeViewController: @preconcurrency ORKTaskViewControllerDelegate {
    @MainActor func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskFinishReason, error: (any Error)?) {
        if reason == .completed {
            if let user = viewModel.user(with: taskViewController.result) {
                viewModel.save(user: user)
                viewModel.loadData { [weak self] in
                    self?.tableView.reloadData()
                }
            }
            taskViewController.dismiss(animated: true)
        }
    }
    
}
