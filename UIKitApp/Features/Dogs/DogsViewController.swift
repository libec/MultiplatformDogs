import Foundation
import UIKit
import Combine
import Dogs

final class DogsViewController: UIViewController {

    private var viewModel: DogsViewModel!
    private var dogCellFactory: DogCellFactory!

    private var subscriptions = Set<AnyCancellable>()

    private var displayedDogs: [DisplayableDog] = []

    private var collectionView: UICollectionView!
    private let dogsCellIdentifier = "DogCell"
    private let insets: CGFloat = 16

    static func make(
        viewModel: DogsViewModel,
        dogCellFactory: DogCellFactory
    ) -> DogsViewController {
        let viewController = DogsViewController()
        viewController.viewModel = viewModel
        viewController.dogCellFactory = dogCellFactory
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dogs"
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
                var indices: [IndexPath] = []
                for index in 0..<unwrappedSelf.displayedDogs.count {
                    if !dogs.contains(unwrappedSelf.displayedDogs[index]) {
                        indices.append(IndexPath(item: index, section: 0))
                    }
                }
                unwrappedSelf.displayedDogs = dogs
                unwrappedSelf.collectionView.reloadItems(at: indices)
            }.store(in: &subscriptions)
    }
}

extension DogsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let sideSize = (view.frame.size.width / 2) - (insets * 1.5)
        return CGSize(width: sideSize, height: sideSize)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        dogCellFactory.cell(for: displayedDogs[indexPath.row], indexPath: indexPath, collectionView: collectionView, reuseIdentifier: dogsCellIdentifier)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        displayedDogs.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        (cell as? DogCell)?.show()
    }
}
