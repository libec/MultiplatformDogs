import Foundation
import UIKit
import Combine
import Dogs

final class BreedsDetailViewController: UIViewController {

    private var viewModel: BreedDetailViewModel!

    private var subscriptions = Set<AnyCancellable>()

    private var displayedDogs: [DisplayableDog] = []

    private var collectionView: UICollectionView!
    private let dogsCellIdentifier = "DogCell"
    private let insets: CGFloat = 16

    static func make(viewModel: BreedDetailViewModel) -> BreedsDetailViewController {
        let viewController = BreedsDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Breed Detail"
        setupCollectionView()
        bindToViewModel()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DogCell.self, forCellWithReuseIdentifier: dogsCellIdentifier)
    }

    private func bindToViewModel() {
        viewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .sink { [weak self] dogs in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.displayedDogs = dogs
                unwrappedSelf.collectionView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension BreedsDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = (view.frame.size.width / 2) - (insets * 1.5)
        return CGSize(width: sideSize, height: sideSize)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: dogsCellIdentifier, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayedDogs.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DogCell, displayedDogs.indices.contains(indexPath.row) {
            let displayableDog = displayedDogs[indexPath.row]
            cell.show(displayableDog: displayableDog)
        }
    }
}
