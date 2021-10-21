//
//  BreedsRepository.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation
import Combine

public protocol BreedsRepository {
    func fetch()
    var query: AnyPublisher<[Breed], Never> { get }
}

public final class BreedsLocalRepository: BreedsRepository {

    private let breedsResource: BreedsResource

    private let subject = PassthroughSubject<[Breed], Never>()
    private var subscriptions = Set<AnyCancellable>()

    public init(breedsResource: BreedsResource) {
        self.breedsResource = breedsResource
    }

    public func fetch() {
        breedsResource.fetch()
            .replaceError(with: [])
            .sink { [weak self] breed in
                // NOTE: - This would deserve better binding to subject than sink
                // something like resource.fetch().bind(to: subject)
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.subject.send(breed)
            }.store(in: &subscriptions)
    }

    public lazy var query: AnyPublisher<[Breed], Never> = {
        subject
            .share()
            .eraseToAnyPublisher()
    }()
}
