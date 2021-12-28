//
//  BreedsViewController.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import UIKit
import Combine
import Dogs

final class BreedsViewController: UIViewController {

    private var viewModel: BreedsViewModel!

    private var subscriptions = Set<AnyCancellable>()

    private var displayedBreeds: BreedsViewModelOutput?

    private let tableView = UITableView()
    private let breedCellIdentifier = "BreedCell"

    static func make(viewModel: BreedsViewModel) -> BreedsViewController {
        let viewController = BreedsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindToViewModel()
        viewModel.fetch()
    }

    private func bindToViewModel() {
        viewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .sink { [weak self] breeds in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.displayedBreeds = breeds
                unwrappedSelf.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: breedCellIdentifier)
    }
}

extension BreedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: breedCellIdentifier, for: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedBreeds?.displayableBreeds.count ?? 0
    }
}

extension BreedsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let breeds = displayedBreeds else { return }
        if breeds.displayableBreeds.indices.contains(indexPath.row) {
            let breed = breeds.displayableBreeds[indexPath.row].name
            cell.textLabel?.text = breed
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let breeds = displayedBreeds else { return }

        if breeds.displayableBreeds.indices.contains(indexPath.row) {
            breeds.displayableBreeds[indexPath.row].selection()
        }
    }
}
