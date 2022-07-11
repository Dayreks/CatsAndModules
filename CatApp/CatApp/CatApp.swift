//
//  CatApp.swift
//  CatApp
//
//  Created by Bohdan on 15.06.2022.
//

import SwiftUI
import Networking
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct CatApp: App {
    @State var network = ImageData()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var presentingAlert = !UserDefaults.standard.bool(forKey: "dataAsked")
    
    var body: some Scene {
        WindowGroup {
            CatList()
                .environmentObject(network)
                .alert("Is it okay to collect your personal data ?", isPresented: $presentingAlert) {
                    Button("Yes") {
                        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                        UserDefaults.standard.set(true, forKey: "dataAsked")
                    }
                    Button("No", role: .cancel) {
                        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
                        UserDefaults.standard.set(true, forKey: "dataAsked")
                    }
                }
        }
        
    }
}

