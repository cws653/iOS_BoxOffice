//
//  CommentListResponse.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation

struct CommentList: Codable {
    let comments: [Comment]
    let movieID: String

    enum CodingKeys: String, CodingKey {
        case comments
        case movieID = "movie_id"
    }
}

struct Comment: Codable {
    let rating:Double
    let timestamp:Double
    let writer: String
    let movieID: String
    let contents: String

    enum CodingKeys: String, CodingKey {
        case rating, timestamp, writer, contents
        case movieID = "movie_id"
    }
}

struct PostComment: Codable {
    var rating: Int
    var writer: String
    var movieID: String
    var contents: String

    enum CodingKeys: String, CodingKey {
        case rating, writer, contents
        case movieID = "movie_id"
    }
}

struct DecodePost: Codable {
    var rating: Double
    var timestamp: Double
    var writer: String
    var movieID: String
    var contents: String

    enum CodingKeys: String, CodingKey {
        case rating, timestamp, writer, contents
        case movieID = "movie_id"
    }
}

