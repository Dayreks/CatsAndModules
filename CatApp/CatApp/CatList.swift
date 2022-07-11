//
//  CatList.swift
//  CatApp
//
//  Created by Bohdan on 15.06.2022.
//

import SwiftUI
import Networking
import FirebasePerformance
import FirebaseCrashlytics


struct CatList: View {
    @EnvironmentObject var network: ImageData
    let trace = Performance.startTrace(name: "image-parse")
    
    var body: some View {
        NavigationView {
            self.imageCollectionView
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Cat App")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Crash") {
                            Crashlytics.crashlytics().log("Crash log")
                            fatalError("Oppsie! I crashed you, ahahah")
                            //[0][1]
                            //13...3
                        }
                    }
                }
        }
    }
    
    private var imageCollectionView: some View {
        ScrollView {
            LazyVStack {
                ForEach($network.cats) { $cat in
                    NavigationLink(
                        destination: CatView(image: $cat.url),
                        label: { CatCell(image: $cat.url) }
                    )
                }
                Color.clear
                    .frame(width: 0, height: 0, alignment: .bottom)
                    .onAppear {
                        network.reload()
                        trace?.stop()
                    }
            }
        }
    }
}

struct CatList_Previews: PreviewProvider {
    static var previews: some View {
        CatList().environmentObject(ImageData())
    }
}
