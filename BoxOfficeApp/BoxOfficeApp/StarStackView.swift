//
//  StarStackView.swift
//  BoxOfficeApp
//
//  Created by oingbong on 15/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class StarStackView: UIStackView {
    enum ButtonType {
        case full
        case half
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(count: Int) {
        let value = count / 2
        let isHalf = count % 2 == 1 ? true : false
        for index in 0..<value {
            button(type: .full, at: index)
            if isHalf && index == value - 1 {
                button(type: .half, at: index + 1)
            }
        }
    }
    
    private func button(type: ButtonType, at index: Int) {
        let imageName = type == .full ? "ic_star_large_full" : "ic_star_large_half"
        guard let button = self.subviews[index] as? UIButton else { return }
        guard let image = UIImage(named: imageName) else { return }
        button.setImage(image, for: .normal)
    }
}
