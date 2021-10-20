//
//  BreedDetatilViewController.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Foundation
import UIKit

final class BreedsDetailViewController: UIViewController {

    static func make() -> BreedsDetailViewController {
        let viewController = BreedsDetailViewController()
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Breed Detail"
    }
}
