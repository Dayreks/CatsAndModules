//
//  ObservableObject.swift
//  CatApp
//
//  Created by Bohdan on 15.06.2022.
//

import Foundation
import Networking

final class ImageData: ObservableObject{
    @Published var cats: [Cat] = []
    let emptyData = Networking()
    var page = 0
    var animal : (String, String)  = {
        switch Bundle.main.object(forInfoDictionaryKey: "type") as! String {
        case "CATS" :
            return ("cat", "387381a2-645a-41e0-a869-ce76d5309b32")
        case "DOGS":
            return ("dog", "229ace9f-bd06-489b-becb-9561fffd7a70")
        default:
            return ("", "")
        }
    }()
    
    init(){
        self.reload()
    }
    
    func reload(){
        self.page += 1
        
        emptyData.load(link: "https://api.the\(animal.0)api.com/v1/images/search?api_key=\(animal.1)&limit=15&page=\(self.page)"){ [weak self] imageData in
            DispatchQueue.main.async {
                self?.cats = imageData.images
            }
        }
    }
}

