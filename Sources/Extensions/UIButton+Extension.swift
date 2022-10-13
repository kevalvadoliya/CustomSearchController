//
//  UIButton+Extension.swift
//  SearchDemo
//
//  Created by Keval Vadoliya on 11/10/22.
//

import UIKit

extension UIButton {

    func setDynamicFontSize() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setButtonDynamicFontSize),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
    }
    
    @IBAction func setButtonDynamicFontSize() {
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
}
