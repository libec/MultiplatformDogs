//
//  BreedsRepository.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation
import Combine

public protocol BreedsRepository {
    var query: AnyPublisher<[Breed], Never> { get }
    var last: [Breed] { get }
}

public final class BreedsLocalRepository: BreedsRepository {

    private let breedsResource: BreedsResource

    private let subject = PassthroughSubject<[Breed], Never>()
    private var subscriptions = Set<AnyCancellable>()

    public init(breedsResource: BreedsResource) {
        self.breedsResource = breedsResource
    }

    public lazy var query: AnyPublisher<[Breed], Never> = {
        breedsResource.fetch()
            .replaceError(with: [])
            .share()
            .handleEvents(receiveOutput: { breeds in
                self.last = breeds
            })
            .eraseToAnyPublisher()
    }()

    public private(set) var last: [Breed] = []
}
