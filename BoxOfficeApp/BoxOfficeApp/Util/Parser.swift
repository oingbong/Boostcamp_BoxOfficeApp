//
//  Parser.swift
//  BoxOfficeApp
//
//  Created by oingbong on 09/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Parser {
    static func jsonUrl(with value: String, type: URLType, handler: @escaping (Data?) -> Void) {
        // 1. URL 객체 정의 - else 일 때 사용자에게 알람 (선택사항)
        guard let url = URL(string: "\(type.description)\(value)") else { return }
        print(url.description)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            handler(data)
        }
        task.resume()
    }
    
    static func decode<T: Decodable>(from data: Data?) -> T? {
        guard let data = data else { return nil }
        do {
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch {
            return nil
        }
    }
}

enum URLType: CustomStringConvertible {
    case orderType
    case id
    case comment
    
    var description: String {
        let url = "http://connect-boxoffice.run.goorm.io/"
        switch self {
        case .orderType:
            return String("\(url)movies?order_type=")
        case .id:
            return String("\(url)movie?id=")
        case .comment:
            return String("\(url)comments?movie_id=")
        }
    }
}
