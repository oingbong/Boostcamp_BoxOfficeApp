//
//  Movie.swift
//  BoxOfficeApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: String // 영화 고유 ID
    var title: String // 영화제목
    var grade: Int // 관람등급
    var thumb: String? // 포스터 이미지 섬네일 주소
    var image: String? // 포스터 이미지 섬네일 주소
    var reservationGrade: Int // 예매순위
    var raservationRate: Double // 예매율
    var userRating: Double // 사용자 평점
    var date: String // 개봉일
    // for Details
    var audience: Int? // 총 관람객 수
    var actor: String? // 배우진
    var duration: Int? // 영화 상영 길이
    var director: String? // 감독
    var synopsis: String? // 줄거리
    var genre: String? // 영화 장르
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case grade = "grade"
        case thumb = "thumb"
        case image = "image"
        case reservationGrade = "reservation_grade"
        case raservationRate = "reservation_rate"
        case userRating = "user_rating"
        case date = "date"
        case audience = "audience"
        case actor = "actor"
        case duration = "duration"
        case director = "director"
        case synopsis = "synopsis"
        case genre = "genre"
    }
}
