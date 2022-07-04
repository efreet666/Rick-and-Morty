//
//  Controller.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import Foundation

class Controller {
    
    let network = NetworkManager()
    
   
    func requestData() {
        network.request(pageUrl: NetworkManager.allPersonURL)
    }
}
