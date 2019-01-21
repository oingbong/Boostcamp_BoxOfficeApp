//
//  UIViewController+Indicator.swift
//  BoxOfficeApp
//
//  Created by oingbong on 16/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

extension UIViewController {
    func displaySpinner(view: UIView) {
        let spinnerView = UIView(frame: view.bounds)
        spinnerView.backgroundColor = .gray
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.center = spinnerView.center
        
        spinnerView.addSubview(indicator)
        view.addSubview(spinnerView)
    }
    
    func removeSpinner(view: UIView) {
        guard view.subviews.count >= 2 else { return }
        let subview = view.subviews[view.subviews.count - 1]
        subview.removeFromSuperview()
    }
}
