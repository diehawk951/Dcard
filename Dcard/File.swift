//
//  File.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/4.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let genreId: String
    let name: String
    let url: URL
}

struct Movie: Codable {
    let artistName: String
    let id: Int
    let releaseDate : Date
    let name: String
    let kind: String
    let copyright: String?
    let artworkUrl100: URL
    let genres: [Genre]
    let url: URL
}

struct Author: Codable {
    let name:String
    let uri: URL
}

struct Link: Codable {
    let `self`: URL?
    let alternate: URL?
}

struct Feed: Codable {
    let title: String
    let id: URL
    let author: Author
    let links: [Link]
    let copyright: String
    let country: String
    let icon: URL
    let updated: Date
    let results: [Movie]
}

struct TopMovies: Codable {
    let feed: Feed
}
