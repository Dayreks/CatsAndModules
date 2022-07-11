//
//  Networking.swift
//  Networking
//
//  Created by Bohdan on 14.06.2022.
//


import SwiftUI
import UIKit
//import FirebasePerformance
//import FirebaseCore

public class Networking: ObservableObject {
    public var images: [Cat] = []
    //let trace: Trace?
    
    public init() {
     //   trace = Performance.startTrace(name: "image-parsing")
    }
    
    public func load(link: String, onCompleted: @escaping (Networking) -> Void) {
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: link)!
        let _ = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, let dataList = try? JSONDecoder().decode([Cat].self, from: data) else {return }
            for link in dataList {
                self.images.append(Cat(url: link.url))
            }
           // self.trace?.stop()
            onCompleted(self)
        }.resume()
    }
}

public struct Cat: Codable, Identifiable{
    public var id = UUID()
    public var url: String
    
    enum CodingKeys: String, CodingKey{
        case url
    }
}

extension Cat {
   @State public static var test = Cat(url: "https://cdn2.thecatapi.com/images/rBuGgH_Wj.jpg")
}
