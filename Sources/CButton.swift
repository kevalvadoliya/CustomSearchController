//
//  cButton.swift
//  CustomSearchController
//
//  Created by Keval Vadoliya on 11/10/22.
//

import UIKit

public class CButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButtonUI()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setButtonUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setButtonUI()
    }
    
    private func setButtonUI() {
        titleLabel?.font = titleFont
        titleLabel?.textAlignment = titleAlignment
        titleLabel?.adjustsFontForContentSizeCategory = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        setTitleColor(titleColor, for: .normal)
        backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
        setDynamicFontSize()
    }
    
    override open var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
        }
    }
    
    @IBInspectable var titleColor: UIColor = .white {
        didSet {
            setTitleColor(titleColor, for: .normal)
        }
    }
    
    @IBInspectable var enabledBackgroundColor: UIColor = .systemBlue {
        didSet {
            backgroundColor = enabledBackgroundColor
        }
    }
    
    @IBInspectable var disabledBackgroundColor: UIColor = .lightGray {
        didSet {
            backgroundColor = disabledBackgroundColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    var titleFont: UIFont = UIFont.preferredFont(forTextStyle: .footnote) {
        didSet {
            titleLabel?.font = titleFont
        }
    }
    
    var titleAlignment: NSTextAlignment = .center {
        didSet {
            titleLabel?.textAlignment = titleAlignment
        }
    }
    
}
