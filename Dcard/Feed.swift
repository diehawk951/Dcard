//
//  Feed.swift
//  Dcard
//
//  Created by 梁嘉峻 on 2020/2/6.
//  Copyright © 2020 梁嘉峻. All rights reserved.
//

import Foundation
struct Feed: Codable {
    var id: Int
    var title: String
    var school: String?
    var forumName: String
    var excerpt: String
    var gender: String
    var updatedAt: Date
    var topics: [String]
    var media: [Media?]
    var likeCount:Int
    var commentCount:Int
}

struct Media: Codable {
    var url: String
}
