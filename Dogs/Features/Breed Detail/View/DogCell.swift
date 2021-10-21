//
//  DogCell.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import UIKit
import Combine

final class DogCell: UICollectionViewCell {

    private var subscriptions = Set<AnyCancellable>()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unavailable")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)

        contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }

    func show(displayableDog: DisplayableDog) {
        guard let url = URL(string: displayableDog.imageUrl) else {
            log("Invalid dog image URL")
            return
        }

        // NOTE: - This is kinda fast'n furious style of solution, it'd make more sense to have a feature for the cell with some of it's own data access layers
        // but you get the gist from the other features
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main, options: .none)
            .sink { image in
                self.imageView.image = image
            }.store(in: &subscriptions)
    }
}
