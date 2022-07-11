//
//  CatCel.swift
//  CatApp
//
//  Created by Bohdan on 15.06.2022.
//

import SwiftUI
import Networking
import FirebasePerformance

struct CatCell: View {
    @Binding var image: String
    let trace = Performance.startTrace(name: "image-load")
    
    var body: some View {
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
                        trace?.stop()
                    }
            case .failure:
                Text("Failed fetching image. Make sure to check your data connection and try again.")
                    .foregroundColor(.red)
            @unknown default:
                Text("Unknown error. Please try again.")
                    .foregroundColor(.red)
            }
        }
        .frame(width: 350, height: 350)
        .padding()
    }
}

struct CatCell_Previews: PreviewProvider {
    static var previews: some View {
        CatCell(image: Cat.$test.url )
    }
}
