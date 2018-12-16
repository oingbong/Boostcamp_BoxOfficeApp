//
//  UIAlertController+Movie.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func sorted() -> UIAlertController {
        let sortedTitle = "정렬방식 선택"
        let sortedMessage = "영화를 어떤 순서로 정렬할까요?"
        let userInfoKey = "value"
        let key = Notification.Name("sorted")
        
        let alert = UIAlertController(title: sortedTitle, message: sortedMessage, preferredStyle: UIAlertController.Style.actionSheet)
        let reservationRate = UIAlertAction(title: OrderType.rate.description, style: .default) { (_) in
            NotificationCenter.default.post(name: key, object: nil, userInfo: [userInfoKey : 0])
        }
        let curation = UIAlertAction(title: OrderType.curation.description, style: .default) { (_) in
            NotificationCenter.default.post(name: key, object: nil, userInfo: [userInfoKey : 1])
        }
        let date = UIAlertAction(title: OrderType.date.description, style: .default) { (_) in
            NotificationCenter.default.post(name: key, object: nil, userInfo: [userInfoKey : 2])
        }
        
        alert.addAction(reservationRate)
        alert.addAction(curation)
        alert.addAction(date)
        return alert
    }
}

// 참고 : UIAlertController 는 subclassing 을 지원하지 않으므로 extension 을 사용
//https://developer.apple.com/documentation/uikit/uialertcontroller
