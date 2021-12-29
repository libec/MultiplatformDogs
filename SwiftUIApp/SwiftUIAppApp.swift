//
//  SwiftUIAppApp.swift
//  SwiftUIApp
//
//  Created by Libor Huspenina on 28.12.2021.
//  Copyright © 2021 Cleverlance. All rights reserved.
//

import SwiftUI
import Dogs

@main
struct SwiftUIAppApp: App {

    let appStart = AppStart()

    var body: some Scene {
        WindowGroup {
            let view: BreedsView = appStart.startApp()
            view
        }
    }
}
