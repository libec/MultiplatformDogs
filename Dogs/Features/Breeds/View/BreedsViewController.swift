//
//  BreedsViewController.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import UIKit

final class BreedsViewController: UIViewController {

    static func make() -> BreedsViewController {
        let viewController = BreedsViewController()
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
}
