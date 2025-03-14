// Copyright © 2018 Stormbird PTE. LTD.

import UIKit

protocol AssetDefinitionsOverridesViewControllerDelegate: class {
    func didDelete(overrideFileForContract file: URL, in viewController: AssetDefinitionsOverridesViewController)
    func didTapShare(file: URL, in viewController: AssetDefinitionsOverridesViewController)
}

class AssetDefinitionsOverridesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let fileExtension: String
    private var overriddenURLs: [URL] = []
    weak var delegate: AssetDefinitionsOverridesViewControllerDelegate?

    init(fileExtension: String) {
        self.fileExtension = fileExtension
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = Colors.appBackground

        tableView.register(AssetDefinitionsOverridesViewCell.self, forCellReuseIdentifier: AssetDefinitionsOverridesViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = Colors.appBackground
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.anchorsConstraint(to: view),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(overriddenURLs urls: [URL]) {
        self.overriddenURLs = urls
        tableView.reloadData()
    }
}

extension AssetDefinitionsOverridesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.didDelete(overrideFileForContract: overriddenURLs[indexPath.row], in: self)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapShare(file: overriddenURLs[indexPath.row], in: self)
    }
}

extension AssetDefinitionsOverridesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetDefinitionsOverridesViewCell.identifier, for: indexPath) as! AssetDefinitionsOverridesViewCell
        cell.configure(viewModel: .init(url: overriddenURLs[indexPath.row], fileExtension: fileExtension))
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return overriddenURLs.count
    }
}
