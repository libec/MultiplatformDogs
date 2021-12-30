//
//  DogCell.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import UIKit
import Combine
import Dogs

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

    func show(displayableDog: DisplayableDog, resource: DogsImageResource) {
        guard let url = URL(string: displayableDog.imageUrl) else {
            log("Invalid dog image URL")
            return
        }

        resource
            .imageData(for: url)
            .receive(on: DispatchQueue.main, options: .none)
            .sink { data in
                self.imageView.image = UIImage(data: data!)
            }.store(in: &subscriptions)
    }
}
