//
//  MovieListResponseModel.swift
//  CombineNetworkLayer
//
//  Created by 최원석 on 2023/05/05.
//

import Foundation

struct MovieList: Codable {
    let movies: [Movies]
    let orderType: Int
    
    enum CodingKeys: String, CodingKey {
        case movies
        case orderType = "order_type"
    }
}

struct Movies: Codable {
    
    let grade: Int
    let thumb: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case grade, thumb, date, id, title
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
}
