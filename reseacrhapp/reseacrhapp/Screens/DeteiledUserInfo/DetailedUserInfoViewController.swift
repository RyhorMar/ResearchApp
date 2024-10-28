//
//  DetailedUserInfoViewController.swift
//  reseacrhapp
//
//  Created by Martsynkevich, Grigorii on 10/26/24.
//

final class DetailedUserInfoViewController: UIViewController {
    private let viewModel: DetailedUserInfoViewModel

    required init(viewModel: DetailedUserInfoViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
