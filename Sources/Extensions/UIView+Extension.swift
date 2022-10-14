//
//  UIView+Extension.swift
//  CustomSearchController
//
//  Created by Keval Vadoliya on 11/10/22.
//

import UIKit

extension UIView {
    
    func loadViewFromNib(nibName: String? = nil) -> UIView {
        let identifier: String = nibName ?? String(describing: type(of: self))
        let nib = UINib(nibName: identifier, bundle: Bundle.module)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return view
    }
    
}
