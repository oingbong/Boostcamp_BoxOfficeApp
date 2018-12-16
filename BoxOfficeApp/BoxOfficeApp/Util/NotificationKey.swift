//
//  NotificationKey.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct NotificationKey {
    static let updateItem = Notification.Name("updateItem")
    static let sorted = Notification.Name("sorted")
    static let updateItemDetail = Notification.Name("updateItemDetail")
    static let isHidden = Notification.Name("isHidden")
    static let userInfoValue = "value"
    static let userInfoIsHidden = "isHidden"
}
