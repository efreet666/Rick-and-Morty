//
//  EpisodeDataModel.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 06.07.2022.
//

import Foundation

struct Episode: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

typealias EpisodeModel = [Episode]
