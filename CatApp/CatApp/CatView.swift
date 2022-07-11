//
//  ContentView.swift
//  CatApp
//
//  Created by Bohdan on 14.06.2022.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct CatView: View {
    @Binding var image: String
    
    var body: some View {
        LazyVStack {
            AsyncImage(url: URL(string: image), scale: 2) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onAppear(){
                            Crashlytics.crashlytics().log("Your user pressed on this link: \(self.image)")
                        }
                case .failure:
                    Text("Failed fetching image. Make sure to check your data connection and try again.")
                        .foregroundColor(.red)
                @unknown default:
                    Text("Unknown error. Please try again.")
                        .foregroundColor(.red)
                }
            }
            .frame(height: 350)
            Text("I am a cat, LOL")
                .bold()
        }
    }
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView(image: Cat.$test.url )
    }
}
