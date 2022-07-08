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

enum ObtainEpisodeResult {
    case success(EpisodeModel)
    case failure(Error)
}

class NetworkManager{

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
    
    class func fetchEpisode(episodeURL: String, completion: @escaping (ObtainEpisodeResult) -> Void) {
        AF.request(episodeURL).responseDecodable(of: EpisodeModel.self) {
            responseJson in
            switch responseJson.result {
            case .success(let json):
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    
}
