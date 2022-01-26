import UIKit
import Dogs

protocol DogCellFactory {
    func cell(
        for displayableDog: DisplayableDog,
        indexPath: IndexPath,
        collectionView: UICollectionView,
        reuseIdentifier: String
    ) -> UICollectionViewCell
}

final class DogCellFactoryImpl: DogCellFactory {

    private let instanceProvider: InstanceProvider

    init(instanceProvider: InstanceProvider) {
        self.instanceProvider = instanceProvider
    }

    func cell(
        for displayableDog: DisplayableDog,
        indexPath: IndexPath,
        collectionView: UICollectionView,
        reuseIdentifier: String
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let dogCell = cell as? DogCell {
            dogCell.setup(
                viewModel: instanceProvider.resolve(DogViewModel.self, argument: displayableDog),
                displayableDog: displayableDog,
                resource: instanceProvider.resolve(DogsImageResource.self)
            )
        }
        return cell
    }
}
