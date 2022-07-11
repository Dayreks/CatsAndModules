//
//  CatAppApp.swift
//  CatApp
//
//  Created by Bohdan on 14.06.2022.
//

import SwiftUI
import Networking

@main
struct CatAppApp: App {
    @EnvironmentObject var network: ImageData
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(network)
        }
    }
}
