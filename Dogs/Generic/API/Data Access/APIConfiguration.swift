//
//  APIConfiguration.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation

public protocol APIConfiguration {
    var baseURL: String { get }
}

public struct ProductionAPIConfiguration: APIConfiguration {

    public let baseURL = "https://dog.ceo/api"

    public init() { } 
}
