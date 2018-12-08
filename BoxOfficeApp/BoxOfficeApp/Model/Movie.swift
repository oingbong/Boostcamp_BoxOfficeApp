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
    var thumb: String // 포스터 이미지 섬네일 주소
    var reservation_grade: Int // 예매순위
    var reservation_rate: Double // 예매율
    var user_rating: Double // 사용자 평점
    var date: String // 개봉일
    // for Details
    var audience: Int? // 총 관람객 수
    var actor: String? // 배우진
    var duration: Int? // 영화 상영 길이
    var director: String? // 감독
    var synopsis: String? // 줄거리
    var genre: String? // 영화 장르
}
