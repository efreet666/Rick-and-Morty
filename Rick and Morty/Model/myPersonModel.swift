//
//  myPersonModel.swift
//  Rick and Morty
//
//  Created by Влад Бокин on 03.07.2022.
//

import Foundation

// MARK: - PersonModel
struct MyPersonModel: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let type: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
