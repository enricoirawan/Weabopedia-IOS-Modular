//
//  AccountViewController.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import UIKit
public class AccountViewController: UIViewController {
    // MARK: - Properties
    private var imageProfileHeader: AccountHeaderUIView?

    private let accountTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
        return tableView
    }()
    
    // MARK: - Life Cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.accountTableView.reloadData()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(accountTableView)

        accountTableView.dataSource = self
        accountTableView.delegate = self
        
        imageProfileHeader = AccountHeaderUIView(frame: CGRect(x: view.bounds.width, y: AccountHeaderUIView.viewHeight, width: view.bounds.width, height: AccountHeaderUIView.viewHeight))
        accountTableView.tableHeaderView = imageProfileHeader

        configureConstraint()
    }

    // MARK: - Helper
    private func configureConstraint() {
        let accountTableViewConstraints = [
            accountTableView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: accountTableView.bottomAnchor),
            accountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: accountTableView.trailingAnchor)
        ]

        NSLayoutConstraint.activate(accountTableViewConstraints)
    }
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }

        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var contentConfiguration = cell.defaultContentConfiguration()

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                contentConfiguration.text = "Enrico Irawan"
                contentConfiguration.secondaryText = "Account name"
                contentConfiguration.image = UIImage(systemName: "person.circle")
                contentConfiguration.imageProperties.tintColor = .systemOrange
            case 1:
                contentConfiguration.text = "irawanenrico@gmail.com"
                contentConfiguration.secondaryText = "Account email"
                contentConfiguration.image = UIImage(systemName: "envelope.circle")
                contentConfiguration.imageProperties.tintColor = .systemOrange
            default:
                fatalError("not implement")
            }
        case 1:
            contentConfiguration.text = "Exit App"
            contentConfiguration.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
            contentConfiguration.imageProperties.tintColor = .systemOrange
        default:
            fatalError("not implement")
        }

        cell.contentConfiguration = contentConfiguration
        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Account Info"
        }
        return "Actions"
    }
}
