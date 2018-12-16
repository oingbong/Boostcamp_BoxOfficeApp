//
//  Watchable.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol Watchable {
    func appendButtonItem()
    func configure(with element: Int)
    func configureTitle(from element: Int)
    func configureObservers()
}
