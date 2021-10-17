//
//  InstanceProvider.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

public protocol InstanceProvider {
    func resolve<Instance>(_ type: Instance.Type) -> Instance
}
