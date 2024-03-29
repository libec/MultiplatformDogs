import UIKit
import Combine
import Dogs

final class DogCell: UICollectionViewCell {

    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: DogViewModel!
    private var displayableDog: DisplayableDog!
    private var resource: DogsImageResource!

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private var likeButton: UIButton? = nil

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unavailable")
    }

    func setup(
        viewModel: DogViewModel,
        displayableDog: DisplayableDog,
        resource: DogsImageResource
    ) {
        self.viewModel = viewModel
        self.displayableDog = displayableDog
        self.resource = resource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)

        contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }

    func show() {
        guard let url = URL(string: displayableDog.imageUrl) else {
            log("Invalid dog image URL")
            return
        }

        reload(with: displayableDog)

        Task.init(priority: .userInitiated) {
            self.imageView.image = try? await resource.imageData(for: url).map { UIImage(data: $0)! }
            self.likeButton?.isHidden = false
        }
    }

    private func reload(with dog: DisplayableDog) {
        if let displayedButton = self.likeButton {
            displayedButton.removeFromSuperview()
        }
        let handler: UIActionHandler = { [weak self] action in
            self?.viewModel?.toggleFavorite()
        }
        let selectAction = UIAction(handler: handler)
        let button = UIButton(frame: CGRect.zero, primaryAction: selectAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: dog.favorite ? "heart.fill" : "heart"), for: .normal)

        contentView.addSubview(button)

        contentView.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bringSubviewToFront(button)
        self.likeButton = button
        self.likeButton?.isHidden = true
    }
}
