//
//  Character.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation
import SwiftData

// MARK: - CharacterModel

@MainActor
@Model
final class CharacterModel: Codable {
    @Attribute(.unique) var id = UUID().uuidString
    var info: Info?
    var results: [CResult]?

    init(info: Info, results: [CResult]) {
        self.info = info
        self.results = results
    }

    enum CodingKeys: String, CodingKey {
        case info, results
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(Info.self, forKey: .info)
        self.results = try container.decode([CResult].self, forKey: .results)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(info, forKey: .info)
        try container.encode(results, forKey: .results)
    }
}

// MARK: - Info

@Model
final class Info: Codable {
    @Attribute(.unique) var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?

    init(count: Int, pages: Int, next: String, prev: String) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }

    enum CodingKeys: String, CodingKey {
        case count, pages, next, prev
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.pages = try container.decode(Int.self, forKey: .pages)
        self.next = try container.decode(String.self, forKey: .next)
        self.prev = try container.decodeIfPresent(String.self, forKey: .prev)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(pages, forKey: .pages)
        try container.encode(next, forKey: .next)
        try container.encode(prev, forKey: .prev)
    }
}

// MARK: - CResult

@Model
final class CResult: Codable {
    
    @Attribute(.unique)  var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: Location?
    var location: Location?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
    var isBookmarked: Bool = false

    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, episode: [String], url: String, created: String, isBookmarked: Bool = false) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
        self.isBookmarked = isBookmarked
    }

    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, image, episode, url, created
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decodeIfPresent(String.self, forKey: .species)
        self.type = try container.decode(String.self, forKey: .type)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.origin = try container.decode(Location.self, forKey: .origin)
        self.location = try container.decode(Location.self, forKey: .location)
        self.image = try container.decode(String.self, forKey: .image)
        self.episode = try container.decode([String].self, forKey: .episode)
        self.url = try container.decode(String.self, forKey: .url)
        self.created = try container.decode(String.self, forKey: .created)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(species, forKey: .species)
        try container.encode(type, forKey: .type)
        try container.encode(gender, forKey: .gender)
        try container.encode(origin, forKey: .origin)
        try container.encode(location, forKey: .location)
        try container.encode(image, forKey: .image)
        try container.encode(episode, forKey: .episode)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }
}

// MARK: - Location

@Model
final class Location: Codable {
    @Attribute(.unique)  var name: String?
    var url: String?

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }

    enum CodingKeys: String, CodingKey {
        case name, url
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
}
