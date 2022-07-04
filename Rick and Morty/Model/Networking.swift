//
//  Networking.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import Foundation
import Alamofire




enum ObtainResult {
    case success(MyPersonModel)
    case failure(Error)
}

class NetworkManager{

    
    var characters = [Result]()
    
    static let allPersonURL = "https://rickandmortyapi.com/api/character"
    
    class func fetchData(_ pageUrl: String, completion: @escaping (ObtainResult) -> Void) {
        AF.request(pageUrl).responseDecodable(of: MyPersonModel.self) { responseJson in
            switch responseJson.result {
            case .success(let json):
                completion(.success(json))
                print(completion(.success(json)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCountryData(_ pageUrl: String) {
        DispatchQueue.main.async {
            NetworkManager.fetchData(pageUrl) { [weak self] result in
                switch result {
                case .success(let infoDataModel):
                    // Decode response into data model
                    if let result = infoDataModel.results {
                        for character in result{
                            self?.characters.append(character)
                            print(self?.characters.count as Any)
                        
                            
                        }
                    }
                    
                    
                    
                case .failure(let err):
                    print(err)
                }
            }
        }
        
    }
    
    func request(pageUrl: String){
        fetchCountryData(pageUrl)
    }
    
}
