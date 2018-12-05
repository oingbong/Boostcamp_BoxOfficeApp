//
//  movie.swift
//  BoxOfficeApp
//
//  Created by oingbong on 05/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class Movie {
    var id: String // 영화 고유 ID
    var title: String // 영화제목
    var grade: Int // 관람등급
    var thumb: String // 포스터 이미지 섬네일 주소
    var reservation_grade: Int // 예매순위
    var reservation_rate: Double // 예매율
    var user_rating: Double // 사용자 평점
    var date: String // 개봉일
    
    init(id: String, title: String, grade: Int, thumb: String, reservation_grade: Int, reservation_rate: Double, user_rating: Double, date: String) {
        self.id = id
        self.title = title
        self.grade = grade
        self.thumb = thumb
        self.reservation_grade = reservation_grade
        self.reservation_rate = reservation_rate
        self.user_rating = user_rating
        self.date = date
    }
}

class MovieDetails: Movie {
    var audience: Int // 총 관람객 수
    var actor: String // 배우진
    var duration: Int // 영화 상영 길이
    var director: String // 감독
    var synopsis: String // 줄거리
    var genre: String // 영화 장르
    
    init(id: String, title: String, grade: Int, thumb: String, reservation_grade: Int, reservation_rate: Double, user_rating: Double, date: String,
         audience: Int, actor: String, duration: Int, director: String, synopsis: String, genre: String) {
        self.audience = audience
        self.actor = actor
        self.duration = duration
        self.director = director
        self.synopsis = synopsis
        self.genre = genre
        super.init(id: id, title: title, grade: grade, thumb: thumb, reservation_grade: reservation_grade, reservation_rate: reservation_rate, user_rating: user_rating, date: date)
    }
}

class MovieEvaluation {
    var movie_id: String // 영화 고유ID
    var rating: Double // 평점
    var timestamp: Double // 작성일시 UNIX Timestamp 값
    var writer: String // 작성자
    var contents: String // 한줄평 내용
    
    init(movie_id: String, rating: Double, timestamp: Double, writer: String, contents: String) {
        self.movie_id = movie_id
        self.rating = rating
        self.timestamp = timestamp
        self.writer = writer
        self.contents = contents
    }
}
